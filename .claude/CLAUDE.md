# CLAUDE.md

이 프로젝트는 다른 프로젝트에서 사용할 MCP, Command, Skill, Hooks의 필수요소들과 사용법을 드롭인으로 복사 붙여넣기 해서 작은 규모의 하네스를 구성하는 목적으로 만들었다.

## MCP Tools

각 MCP 사용법은 아래 문서로 분리되어 있다.

@mcp/context7.md
@mcp/sequential-thinking.md
@mcp/playwright.md

## Commands

`.claude/commands/` 의 슬래시 커맨드. 토큰 절약을 위해 git 명령을 직접 실행한다.

- **`/git-commit [메시지]`**: 현재 브랜치에 `add -A` 후 커밋. 메시지 없으면 diff 요약으로 자동 작성.
- **`/git-push`**: 현재 브랜치를 `git push -u origin HEAD` 로 push.
- **`/git-pr [base]`**: commit → push → `gh pr create --base <base> --fill`. `base` 없으면 `develop`.
- **`/check [명령]`**: lint + typecheck + test 를 한 번에 실행하고 실패만 보고. 프로젝트 종류 자동 감지, 인자로 명령 직접 지정 가능.

## Skills

`.claude/skills/` 의 스킬. 조건에 맞는 작업이 시작되면 자동 발동한다.

- **`anti-ai-slop`**: 이미지·HTML·SVG·슬라이드·PDF 같은 시각 산출물과 문서·리포트·카피 글을 만들기 직전 발동하는 품질 게이트. 그라데이션·글로우·장식 모션 등 slop 디자인과 상투어·균질 구조·불릿 남발 등 AI 글쓰기 지문을 차단한다. 세부 기준은 `references/`(visual-craft·slides-pdf·writing-tells)로 분리.
- **`scaffold`**: "next.js/go/rust/spring/typescript/react/vue 스캐폴딩 만들어줘" 류 발화에 발동. 손으로 템플릿을 찍지 않고 각 생태계 공식 스캐폴더(create-next-app·cargo·create-vue·Spring Initializr)를 최신 명령으로 실행한 뒤, CLI가 안 만드는 구조·린터·CI를 얹는다. 죽은 도구(CRA 등) 차단 + YAGNI 구조 강제. 세부는 `references/`(js-ts·go-rust·java-spring).
- **`handoff`**: 세션 인계. "핸드오프", "이어서 작업", "인계/컨텍스트 정리" 발화에 발동해 진행상황·실패·다음 할 일을 `.handoff.md`(레포 루트)에 남긴다. 아래 `precompact-handoff` 훅과 짝을 이룬다.
- **`changelog`**: 되돌릴 수 없는 결정(아키텍처·의존성·API 계약)과 근거를 `changelog/changelog.md`에 append-only로 기록. 아래 `changelog-reminder` 훅이 push/PR 직전 매니페스트 변경을 감지하면 이 스킬로 기록할지 검토한다.

## Hooks

`.claude/hooks/` 의 훅. 설정은 `.claude/settings.json`.

- **`precompact-handoff.py`** (PreCompact): 컨텍스트 압축 직전 기계적 스냅샷(브랜치·변경파일·최근 사용자 메시지)을 `.handoff.md`에 덧붙인다. PreCompact는 모델을 부를 수 없어(컨텍스트 주입 미지원) 스냅샷만 남기고, 사람이 읽을 인계문 정리는 `handoff` 스킬이 한다. `.handoff.md`는 세션 로컬이라 `.gitignore` 처리.
- **`changelog-reminder.py`** (PreToolUse/Bash): `git push`·`gh pr create` 직전, 나갈 커밋에 의존성·빌드 매니페스트 변경이 있는데 `changelog/changelog.md` 갱신이 없으면 비차단 리마인더를 모델에 주입한다. push를 막지 않는다(defer).
