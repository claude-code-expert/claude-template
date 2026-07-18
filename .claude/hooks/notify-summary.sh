#!/usr/bin/env bash
# notify-summary.sh — Stop 훅. 마지막 응답을 3줄로 요약해 macOS 알림창에 띄운다.
# transcript(JSONL)에서 마지막 assistant 텍스트를 뽑아 앞 3줄로 압축한다(훅은 모델 호출 불가 → 기계적 요약).
# 완료음은 notify-mac 과 같은 env 를 재사용:
#   CLAUDE_NOTIFY_DONE_SOUND   기본 /System/Library/Sounds/Glass.aiff
#   CLAUDE_NOTIFY_DONE_VOLUME  기본 0.5  (0=음소거)
set -uo pipefail

# 볼륨·사운드 설정 로드(있으면). 파일 값이 다음 알림부터 적용된다(재시작 불필요).
conf="$(cd "$(dirname "$0")" 2>/dev/null && pwd)/notify.conf"
[ -f "$conf" ] && . "$conf"

payload="$(cat)"

# Stop 훅 stdin 엔 응답 텍스트가 없다. transcript_path 로 JSONL 을 읽어야 한다.
transcript="$(printf '%s' "$payload" | jq -r '.transcript_path // empty' 2>/dev/null)"
[ -z "$transcript" ] && transcript="$(printf '%s' "$payload" \
  | sed -n 's/.*"transcript_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"

# jq 없거나 transcript 없으면 조용히 종료(훅은 절대 세션 안 막음).
command -v jq >/dev/null 2>&1 || exit 0
[ -f "$transcript" ] || exit 0

# 마지막 assistant 응답 텍스트 추출. content 가 배열/문자열 양쪽 방어.
text="$(jq -rs '
  [ .[]
    | select(.type=="assistant")
    | .message.content
    | (if type=="array" then (map(select(.type=="text").text) | join("\n")) else (. // "") end)
    | select(length > 0)
  ] | last // ""' "$transcript" 2>/dev/null)"

[ -z "$text" ] && exit 0

# 3줄 요약: 마크다운 마커(#, -, *, `, **) 제거 → 빈 줄 제거 → 앞 3줄 → 각 줄 100자 컷.
summary="$(printf '%s' "$text" \
  | sed -E 's/^#+[[:space:]]*//; s/^[[:space:]]*[-*][[:space:]]+//; s/`//g; s/\*\*//g' \
  | grep -v '^[[:space:]]*$' \
  | head -3 \
  | cut -c1-100)"

[ -z "$summary" ] && exit 0

# 알림창 표시 — osascript(macOS 26/Tahoe 에서 렌더됨. "Script Editor" 앱 알림 허용 필요).
# 주입 방지: 따옴표·백슬래시 제거. 3줄을 공백으로 합침(AppleScript 리터럴이 생 줄바꿈 못 담음 → 배너도 어차피 한 줄).
safe="$(printf '%s' "$summary" | tr -d '\\"' | tr '\n' ' ')"
osascript -e "display notification \"$safe\" with title \"Claude Code — 응답 완료\" subtitle \"3줄 요약\"" >/dev/null 2>&1 || true

# 완료음(볼륨 지정). 0 이면 무음. 훅 안 막게 백그라운드.
sound="${CLAUDE_NOTIFY_DONE_SOUND:-/System/Library/Sounds/Glass.aiff}"
vol="${CLAUDE_NOTIFY_DONE_VOLUME:-0.5}"
if [ "$vol" != "0" ] && [ "$vol" != "0.0" ] && [ -f "$sound" ]; then
  afplay -v "$vol" "$sound" >/dev/null 2>&1 &
fi

exit 0
