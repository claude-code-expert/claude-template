# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 이 리포가 무엇인가

Claude Code 확장 요소 — **슬래시 커맨드 · MCP 서버 · hooks · 스킬** — 를 만들고 **실제로 돌려서 정상 동작하는지 검증하는 랩**이다. 배포되는 "제품"이 없다. 산출물은 두 갈래로 나뉜다:

- **확장 자체** (`.claude/`, `.mcp.json`): 커맨드·스킬 정의. 이게 리포의 본체다.
- **검증 흔적**: 그 확장을 한 번 실행한 결과물. 스킬이 잘 도는지 보려고 만든 것이지 독립 제품이 아니다.
  - `ohpen-web/` — `scaffold` 스킬로 만든 Next.js 앱
  - `demo/` — `anti-ai-slop` 스킬 시연용 랜딩 2종(`ohpen-slop.html` vs `ohpen-anti-slop.html`)
  - `changelog/changelog.md` — `changelog` 스킬이 남긴 결정 로그
  - `HANDOFF.md` — `handoff` 스킬이 남긴 세션 인계문

확장을 수정할 때는 정의(`.claude/`)와 그 검증 흔적을 함께 본다. 흔적만 고치면 스킬이 실제로 그렇게 동작하는지는 검증되지 않는다.

## 슬래시 커맨드 (`.claude/commands/`)

전부 한국어 출력, git/검사 워크플로우 자동화. 커맨드끼리 체인된다: `pr` = `commit` + `push` + PR 생성.

| 커맨드 | 역할 |
|---|---|
| `/check [명령]` | 문법→테스트→lint **fail-fast** 검사. 통과 시 `check pass` 한 줄. 인자 주면 감지 무시하고 그대로 실행 |
| `/commit` | `git add -A` 후 한 줄 한국어 커밋(prefix: `feat/docs/fix/debug/db/api/test`) |
| `/push` | commit + origin push. upstream 없으면 `-u` |
| `/pr [base]` | commit + push + PR. base 인자 없으면 **`develop`** 기준 |

커맨드 공통 규칙 (수정·신규 작성 시 반드시 지킬 것):
- **full `git diff`를 읽지 않는다** — 토큰 낭비. 커맨드는 `--stat`·파일명·상태만 주입받아 판단하도록 설계됐다.
- **`allowed-tools`는 필요한 러너/명령만 화이트리스트**한다. 목록 밖 명령은 권한 프롬프트가 뜨는 게 의도된 보안 경계다 — 우회하지 않는다. (`/check`가 이 원칙의 기준 예시)
- **`--force` push 금지.** 거부되면 상황만 보고하고 강제하지 않는다.

## 스킬 (`.claude/skills/`)

각 스킬은 `SKILL.md` + `references/`로 구성. 스킬 본문은 라우팅·규칙이고, 실제 지침은 `references/<주제>.md`에 있어 **산출물을 만들기 전에 매칭되는 레퍼런스를 먼저 읽는** 구조다.

- `anti-ai-slop` — 슬롭 없는 산출물(문서/시각화/문서변환). `references/{writing,visualization,conversion}.md`
- `scaffold` — 언어별 공식 스캐폴더 우선 부트스트랩. `references/<lang>.md` 7종
- `changelog` — 되돌리기 어려운 결정만 append-only 기록
- `handoff` — 세션 인계

## MCP 서버 (`.mcp.json`)

`sequential-thinking`, `context7`(라이브러리 문서 조회), `playwright`(브라우저 자동화) — 셋 다 `npx` stdio.

## hooks (`.claude/hooks/` + `.claude/settings.json`)

hook은 stdin으로 이벤트 JSON을 받고, 리마인더·인계성 hook은 **비차단(exit 0)**으로 둔다. `settings.json` 문법 오류는 조용히 무시되니 붙인 뒤 실제 트리거로 검증한다. `$CLAUDE_PROJECT_DIR`가 프로젝트 루트로 주입된다.

**구현됨 — handoff 왕복 (`settings.json`에 배선):**
- `dump-handoff.sh` (PreCompact, matcher `manual`): `/compact` 수동 압축 직전 브랜치·변경파일·최근 사용자 메시지 스냅샷을 `HANDOFF.md`에 append. PreCompact는 모델 호출 불가 → 기계적 안전망일 뿐. `auto` 압축엔 안 걸린다.
- `inject-handoff.sh` (SessionStart, matcher `resume`): `--resume`/`--continue` 재개 시 `HANDOFF.md` 전문을 stdout으로 뱉어 컨텍스트 주입 (SessionStart는 stdout=컨텍스트).
- 둘 다 `handoff` 스킬이 참조. 훅이 원료(스냅샷) 남기고 스킬(모델)이 사람 인계문으로 가공.

**아직 미구현:**
- `changelog-reminder.py` (PreToolUse, `git push`/`gh pr create`): 매니페스트 변경이 있는데 changelog 갱신이 없으면 **비차단** 리마인더. → `changelog` 스킬이 참조하나 파일 부재로 아직 작동 안 함.

## 주의 (gotchas)

- **`.env`가 tracked**이며 값은 플레이스홀더(`ghp_실제토큰값`)다. 실제 토큰을 여기 넣고 커밋하지 않는다.
- 루트 `package-lock.json`은 짝이 되는 `package.json`이 없는 **stray**다(빈 lockfile). 확인 후 정리 대상.

## 응답 
- 한글로 응답 결과를 제시 
- 처리한 응답 결과에 설명이 필요할 경우 다음의 세가지 항목으로 대답 
무엇을, 왜, 어떻게 바꾸었나?