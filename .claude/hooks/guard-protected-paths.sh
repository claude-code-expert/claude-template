#!/usr/bin/env bash
# 보호 경로 수정 차단 (PreToolUse, matcher: "Edit|Write|Bash").
#   Edit/Write : tool_input.file_path 가 민감 파일이면 차단.
#   Bash       : 명령어에 보호 경로 토큰 + 쓰기/삭제 동사가 함께 있으면 차단(읽기는 통과).
# 차단은 exit 2 (사유를 stderr 로 Claude 에 전달). jq 없으면 파싱 불가 → 차단(fail-closed).
set -euo pipefail

block() { echo "BLOCKED: $1" >&2; exit 2; }

# 보안 게이트라 파서 부재 시 통과가 아니라 차단.
command -v jq >/dev/null 2>&1 || block "jq 없음 — 보호 경로 검사 불가라 안전하게 차단합니다(fail-closed)."

payload=$(cat)
tool=$(printf '%s' "$payload" | jq -r '.tool_name // ""')

case "$tool" in
  Edit|Write|MultiEdit|NotebookEdit)
    file=$(printf '%s' "$payload" | jq -r '.tool_input.file_path // .tool_input.notebook_path // ""')
    [ -z "$file" ] && exit 0
    case "$file" in
      */.env|*/.env.*|*/credentials*|*/.git/config|*/id_rsa|*/id_ed25519|*/*.pem)
        block "'$file' 는 수정 금지(민감 파일). 훅이 편집을 차단했습니다." ;;
    esac
    ;;

  Bash)
    cmd=$(printf '%s' "$payload" | jq -r '.tool_input.command // ""')
    [ -z "$cmd" ] && exit 0

    # 보호 경로 토큰(명령어 어디에 있어도) / 쓰기·삭제 동사.
    token_regex='\.env|credentials|/\.git/config|id_rsa|id_ed25519|\.pem'
    write_regex='(>>?)|(^|[[:space:]])(tee|dd|truncate|cp|mv|rm|install|ln|chmod|chown)([[:space:]]|$)|sed[[:space:]]+-i'

    # ponytail: 휴리스틱 — 토큰+동사 동시 매칭만 잡는다. base64/변수/eval 우회는 못 막음.
    #           근본 차단은 tracked .env 를 repo 에서 제거하는 것(CLAUDE.md gotcha 참고).
    if printf '%s' "$cmd" | grep -Eq "$token_regex" \
       && printf '%s' "$cmd" | grep -Eq "$write_regex"; then
      block "명령이 보호 경로를 수정/삭제하려 합니다: '$cmd'. 훅이 차단했습니다."
    fi
    ;;
esac

exit 0   # 명시적 통과
