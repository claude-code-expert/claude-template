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
