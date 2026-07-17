---
name: scaffold
description: 새 프로젝트·서비스·모듈을 언어별로 부트스트랩할 때 사용. 공식 스캐폴더(create-next-app, cargo new, uv init, Spring Initializr 등)를 우선 쓰고, 손으로 파일 트리를 찍지 않으며, 구조는 필요할 때만 키운다. 언어를 정하면 references/<lang>.md의 현행 명령·디렉터리·코드 샘플을 따른다.
---

# Scaffold

새 코드베이스를 시작한다. 목표는 **최소한의 올바른 뼈대** — 공식 도구가 만든, 현행 버전의, 딱 지금 필요한 만큼의 구조. 빈 디렉터리 트리는 구조가 아니라 노이즈다.

## 규칙

1. **공식 스캐폴더를 재발명하지 않는다.** `create-next-app`·`cargo new`·`npm create vue`·Spring Initializr가 존재한다. 손으로 파일을 찍기 전에 공식 도구가 있는지 먼저 확인하고, 있으면 무조건 그것을 쓴다.
2. **버전을 하드코딩하지 않는다.** 스캐폴더는 항상 최신을 안다. `@latest`를 쓰고, Rust 의존성은 `cargo add`, Spring 버전은 Initializr 서버 기본값에 맡긴다. 이 문서의 버전 숫자도 "확인 후 사용" 대상이다.
3. **구조는 flat until it hurts.** 처음부터 `cmd/`·`pkg/`·워크스페이스·package-by-feature를 깔지 않는다. 코드가 그걸 요구할 때 도입한다. 빈 디렉터리 트리는 구조가 아니라 노이즈다.
4. **죽은 도구를 쓰지 않는다.** Create React App, Vue CLI(`@vue/cli`), 신규 프로젝트의 Spring Boot 3.x, 신규 프로젝트의 Lombok 반사 사용 — 전부 금지. 아래 표의 현행 도구를 쓴다.

## 현행 도구 표 (2026-07 기준 · 쓰기 전 최신 확인)

| 언어 / 스택 | 공식 스캐폴더 | 피할 것 |
|---|---|---|
| Node / TypeScript | 단일 공식 스캐폴더 없음 → `npm init` + tsx·Biome·Vitest | ts-node, nodemon, jest, dotenv, 신규의 ESLint+Prettier |
| React (Next.js) | `npx create-next-app@latest` | Create React App(죽음), 신규의 Pages Router |
| Vue | `npm create vue@latest` | Vue CLI(`@vue/cli`, 유지보수 모드), Vetur |
| Python | `uv init` | 수동 pip+venv, setup.py/.cfg, 신규의 Poetry |
| Go | `go mod init` | `golang-standards/project-layout` 맹목 복제, 조기 `cmd/`·`pkg/` |
| Rust | `cargo new` / `cargo init` | 수동 `Cargo.toml`, `edition` 하드코딩, 조기 워크스페이스 |
| Java (Spring) | Spring Initializr (`start.spring.io`) | 신규의 Spring Boot 3.x, 신규의 Lombok, 수동 pom/gradle |

## 언어 선택 → 레퍼런스

각 레퍼런스는 **공식 스캐폴더 명령 · flat 디렉터리 트리 · 관용 코드 샘플 · 피할 죽은 도구 · 출처**를 담는다. 스캐폴드 전에 해당 파일을 읽는다.

| 시작하는 것 | 읽을 것 |
|---|---|
| Node/TS 서비스·라이브러리 | [references/typescript-node.md](references/typescript-node.md) |
| Next.js 웹앱 | [references/react-next.md](references/react-next.md) |
| Vue 웹앱 | [references/vue.md](references/vue.md) |
| Python 앱·라이브러리 | [references/python.md](references/python.md) |
| Go 서비스·CLI | [references/go.md](references/go.md) |
| Rust 바이너리·크레이트 | [references/rust.md](references/rust.md) |
| Java/Spring Boot 서비스 | [references/java-spring.md](references/java-spring.md) |

## 스캐폴드 후 (공통)

- `git init` (스캐폴더가 안 했다면) → 첫 커밋은 생성 직후 그대로.
- 락파일 커밋: `package-lock.json`·`uv.lock`·`Cargo.lock`·`go.sum`.
- README에 "실행/테스트/빌드" 3줄만. 나머지는 코드가 요구할 때.
