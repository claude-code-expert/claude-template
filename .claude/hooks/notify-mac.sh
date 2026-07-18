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

# 볼륨·사운드 설정 로드(있으면). 파일 값이 다음 알림부터 적용된다(재시작 불필요).
conf="$(cd "$(dirname "$0")" 2>/dev/null && pwd)/notify.conf"
[ -f "$conf" ] && . "$conf"

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

# 배너 표시 — osascript(Apple 1차 메커니즘, macOS 26/Tahoe 에서 렌더됨).
# 알림은 "Script Editor" 앱으로 귀속되니 시스템 설정 > 알림 > Script Editor 가 허용이어야 뜬다.
# (terminal-notifier 2.0.0 은 레거시 NSUserNotification 이라 Tahoe 에서 배너 렌더 안 됨 → 안 씀.)
# 주입 방지: 따옴표·백슬래시 제거. 줄바꿈은 공백으로(AppleScript 리터럴이 생 줄바꿈 못 담음).
safe_msg="$(printf '%s' "$msg" | tr -d '\\"' | tr '\n' ' ')"
safe_title="$(printf '%s' "$title" | tr -d '\\"' | tr '\n' ' ')"
osascript -e "display notification \"$safe_msg\" with title \"$safe_title\"" >/dev/null 2>&1 || true

# 볼륨 지정 재생. vol=0 이면 무음, 파일 없으면 건너뜀. 훅 안 막게 백그라운드.
if [ "$vol" != "0" ] && [ "$vol" != "0.0" ] && [ -f "$sound" ]; then
  afplay -v "$vol" "$sound" >/dev/null 2>&1 &
fi

exit 0
