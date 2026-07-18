#!/usr/bin/env bash
# inject-handoff.sh — SessionStart(resume) 훅.
# 세션 재개 시 HANDOFF.md 전문을 stdout으로 뱉어 다음 세션 컨텍스트에 주입한다.
set -uo pipefail

root="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
f="$root/HANDOFF.md"
[ -f "$f" ] || exit 0

echo "# 이전 세션 인계 (HANDOFF.md)"
echo "아래는 지난 세션이 남긴 인계문이다. 이어서 작업할 때 먼저 참고하라."
echo ""
cat "$f"
exit 0
