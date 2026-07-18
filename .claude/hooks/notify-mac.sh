#!/usr/bin/env bash
# notify-mac.sh — macOS 데스크톱 알림 훅.
# 이벤트별로 소리·볼륨을 달리한다:
#   Notification = 입력 대기(권한 프롬프트·옵션 창·유휴) / Stop = 응답 완료
#
# 볼륨/소리 커스터마이즈 (셸 프로필이나 세션 env에서 export):
#   CLAUDE_NOTIFY_INPUT_SOUND   기본 /System/Library/Sounds/Ping.aiff
#   CLAUDE_NOTIFY_INPUT_VOLUME  기본 1.0   (0.0~1.0+, 0=음소거)
#   CLAUDE_NOTIFY_DONE_SOUND    기본 /System/Library/Sounds/Glass.aiff
#   CLAUDE_NOTIFY_DONE_VOLUME   기본 0.5   (0.0~1.0+, 0=음소거)
#
# 볼륨 제어를 위해 소리는 afplay -v 로 재생한다.
# (display notification 의 `sound name` 은 시스템 알림 볼륨 고정 — 알림별 조절 불가)
set -uo pipefail

payload="$(cat)"

# 이벤트 판별. jq 우선, 없으면 sed fallback.
event="$(printf '%s' "$payload" | jq -r '.hook_event_name // empty' 2>/dev/null)"
[ -z "$event" ] && event="$(printf '%s' "$payload" \
  | sed -n 's/.*"hook_event_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"

case "$event" in
  Notification)
    title="Claude Code — 입력 필요"
    msg="$(printf '%s' "$payload" | jq -r '.message // "입력을 기다리는 중"' 2>/dev/null)"
    [ -z "$msg" ] && msg="입력을 기다리는 중"
    sound="${CLAUDE_NOTIFY_INPUT_SOUND:-/System/Library/Sounds/Ping.aiff}"
    vol="${CLAUDE_NOTIFY_INPUT_VOLUME:-1.0}"
    ;;
  *)  # Stop 및 그 외 → 완료 알림
    title="Claude Code — 완료"
    msg="응답이 끝났습니다"
    sound="${CLAUDE_NOTIFY_DONE_SOUND:-/System/Library/Sounds/Glass.aiff}"
    vol="${CLAUDE_NOTIFY_DONE_VOLUME:-0.5}"
    ;;
esac

# 배너 표시. terminal-notifier 있으면 우선(권한 설정 없이 우상단 알림센터에 확실히 뜸),
# 없으면 osascript 폴백(호출 앱에 알림 권한 필요).
if command -v terminal-notifier >/dev/null 2>&1; then
  terminal-notifier -title "$title" -message "$msg" >/dev/null 2>&1 || true
else
  # osascript -e 주입 방지: 따옴표·백슬래시 제거 후 삽입.
  safe_msg="$(printf '%s' "$msg" | tr -d '\\"')"
  safe_title="$(printf '%s' "$title" | tr -d '\\"')"
  osascript -e "display notification \"$safe_msg\" with title \"$safe_title\"" >/dev/null 2>&1 || true
fi

# 볼륨 지정 재생. vol=0 이면 무음, 파일 없으면 건너뜀. 훅 안 막게 백그라운드.
if [ "$vol" != "0" ] && [ "$vol" != "0.0" ] && [ -f "$sound" ]; then
  afplay -v "$vol" "$sound" >/dev/null 2>&1 &
fi

exit 0
