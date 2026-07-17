---
description: 문법·테스트·lint 검사 실행. 통과 시 "check pass" 한 줄, 실패 시 핵심 한 줄 보고
allowed-tools: Bash(ls:*), Bash(grep:*), Bash(npm run:*), Bash(pnpm run:*), Bash(yarn run:*), Bash(npx tsc:*), Bash(npx eslint:*), Bash(tsc:*), Bash(eslint:*), Bash(python -m py_compile:*), Bash(python -m pytest:*), Bash(pytest:*), Bash(ruff:*), Bash(go build:*), Bash(go test:*), Bash(go vet:*), Bash(golangci-lint:*), Bash(cargo check:*), Bash(cargo test:*), Bash(cargo clippy:*), Bash(make:*), Bash(./gradlew:*), Bash(gradle:*), Bash(mvn:*)
---

인자(있으면 감지 무시하고 이걸 그대로 실행): $ARGUMENTS
package.json 검사 script: !`grep -oE '"(lint|test|typecheck|build|check|tsc)"[[:space:]]*:' package.json 2>/dev/null`
Makefile 타겟: !`grep -oE '^[a-zA-Z_-]+:' Makefile 2>/dev/null`
lock 파일: !`ls -d package-lock.json pnpm-lock.yaml yarn.lock 2>/dev/null`
프로젝트 마커: !`ls -d package.json pyproject.toml setup.py setup.cfg tox.ini Cargo.toml go.mod build.gradle build.gradle.kts pom.xml tsconfig.json ruff.toml .eslintrc .eslintrc.js .eslintrc.json .eslintrc.cjs 2>/dev/null`

## 작업

문법 → 테스트 → lint 순서로 검사한다. **fail-fast**: 먼저 실패한 단계에서 멈추고 그 단계만 보고한다.

### 1. 인자 우선
`$ARGUMENTS` 가 비어있지 않으면 감지를 건너뛰고 그 문자열을 Bash 로 **그대로 실행**한다. 결과를 아래 "보고 규칙"대로 보고하고 종료.

### 2. 감지 실행 (인자 없을 때)
위 주입된 신호로 각 단계 명령을 고른다. 감지 안 된 단계는 조용히 건너뛴다.

| 단계 | 우선순위 |
|------|----------|
| 문법/타입 | package.json `typecheck`·`tsc`·`build` script > `npx tsc --noEmit`(tsconfig.json) > `python -m py_compile`(py) > `go build ./...`(go.mod) > `cargo check`(Cargo.toml) |
| 테스트 | package.json `test` script > `python -m pytest -q` / `pytest -q` > `go test ./...` > `cargo test` > Makefile `test` > `./gradlew test` / `mvn -q test` |
| lint | package.json `lint` script > `ruff check .` > `npx eslint .` > `golangci-lint run` > `cargo clippy` > Makefile `lint` |

- npm script 는 lock 파일 기준 패키지 매니저로 실행하되 **항상 `run` 형태**로: pnpm-lock→`pnpm run <script>`, yarn.lock→`yarn run <script>`, 그 외→`npm run <script>`.
- 각 단계 명령은 Bash 로 실행하고 종료코드로 성공/실패 판정.

## 보고 규칙

- **모든 감지된 단계 통과** → `check pass` 한 줄만 출력. 그 외 아무 것도 출력 금지.
- **실패** → 한 줄만: `<단계> 실패: <핵심 사유>`
  - 단계 = 문법 | 테스트 | lint (또는 인자 실행 시 그 명령)
  - 핵심 사유 = 에러 메시지 / 실패한 테스트명 / lint 규칙 중 가장 핵심 1개. 전체 로그 붙여넣기 금지.
- **감지된 단계가 하나도 없고 인자도 없음** → 실행하지 말고 한 줄로 물어봄: `실행할 검사 명령을 못 찾음. 무엇을 실행할까? (예: /check npm test)`

## 규칙

- 통과 시 절대 로그·설명·이모지 추가하지 마라. `check pass` 딱 한 줄.
- 실패 시에도 한 줄. 여러 단계가 실패해도 먼저 실패한 하나만 보고.
- 자동 수정·재시도 하지 마라. 검사만 한다.
- **보안**: allowed-tools 는 검사 러너만 사전승인한다. 인자로 받은 임의 명령이나 목록 밖 도구는 실행 시 권한 프롬프트가 뜬다 — 승인해야 실행됨. 이 프롬프트를 우회하려 하지 마라.
