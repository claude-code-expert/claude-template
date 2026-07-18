#!/usr/bin/env bash
# dump-handoff.sh — PreCompact(manual) 훅.
# 압축 직전 기계적 스냅샷(브랜치·변경파일·최근 사용자 메시지)을 HANDOFF.md에 덧붙인다.
# 이건 안전망일 뿐. handoff 스킬이 이 스냅샷을 읽어 사람이 읽을 인계문으로 정리한다.
set -uo pipefail

root="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
out="$root/HANDOFF.md"

# PreCompact 훅은 stdin으로 {trigger, transcript_path, ...} JSON을 받는다.
input="$(cat)"
transcript="$(printf '%s' "$input" | sed -n 's/.*"transcript_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"

cd "$root" || exit 0
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')"
stamp="$(date '+%Y-%m-%d %H:%M')"

{
  echo ""
  echo "## ⏸ pre-compact snapshot — $stamp · 브랜치 \`$branch\`"
  echo ""
  echo "**변경 파일:**"
  echo '```'
  git status --short 2>/dev/null || echo '(git status 실패)'
  echo '```'
  echo "**마지막 커밋:** \`$(git log --oneline -1 2>/dev/null || echo '?')\`"

  # 최근 사용자 메시지 — best-effort. jq 없으면 조용히 건너뛴다(하드 의존 금지).
  if command -v jq >/dev/null 2>&1 && [ -f "$transcript" ]; then
    echo ""
    echo "**최근 사용자 메시지:**"
    echo '```'
    jq -r 'select(.type=="user") | .message.content
             | if type=="array" then (map(select(.type=="text").text) | join(" ")) else . end' \
       "$transcript" 2>/dev/null | grep -v '^[[:space:]]*$' | tail -5 || true
    echo '```'
  fi
} >> "$out"

exit 0
