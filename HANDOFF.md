# HANDOFF — 2026-07-17

내일 작업: **hooks 신규 작업** (오늘 커밋 이후 시작).

---

## 지금 상태

- 브랜치: `feat/skills`
- 마지막 커밋: `89c1d9b feat: 문법 테스트 lint 검사 check 슬래시 커맨드 추가`
- **오늘 작업은 전부 미커밋(untracked).** 내일 시작 전 커밋 먼저.

커밋 대상:
| 경로 | 내용 |
|---|---|
| `.claude/skills/anti-ai-slop/` | 안티슬롭 스킬 + references 3개(writing/visualization/conversion) |
| `.claude/skills/scaffold/` | 스캐폴드 스킬 + references 7개(언어별) |
| `.claude/skills/changelog/` | 결정 기록 스킬 (유저 작성) |
| `.claude/skills/handoff/` | 빈 스텁 (미작성) |
| `changelog/changelog.md` | 결정 로그 첫 항목(ohpen-web 스캐폴드) |
| `demo/` | OhPen 랜딩 2종(slop / anti-slop) |
| `ohpen-web/` | Next 16 App Router 앱 (랜딩 포팅) |
| `.vscode/` | 에디터 설정 |
| `package-lock.json` (루트) | ⚠️ stray — 루트에 package.json 없음. cruft 의심, 커밋 전 확인/삭제 |

---

## 오늘 한 일

- **스킬 3종 신규 작성** (웹 리서치 → 베스트프랙티스 적용): anti-ai-slop, scaffold(언어 7종), changelog(결정 로그).
- **`/check` 커맨드** + allowed-tools 보안 축소(무제한 Bash → 러너 화이트리스트).
- **OhPen 랜딩** slop/anti-slop 2종 → **Next.js 앱(`ohpen-web/`)으로 포팅**, 빌드·렌더 검증.
- 하이드레이션 경고 수정(`<html suppressHydrationWarning>`, 원인=브라우저 확장).
- 결정 로그 첫 항목 기록.

---

## 내일: hooks 작업 시작점

**아직 hooks 인프라 없음**: `.claude/settings.json`·`.claude/hooks/` 둘 다 부재.

### 바로 만들 것 — `changelog-reminder` 훅 (스펙 이미 존재)
`changelog` 스킬(`.claude/skills/changelog/SKILL.md`)이 이 훅을 참조하는데 파일이 없어 **작동 안 함**. 스펙:
- **이벤트**: PreToolUse, matcher = `Bash` (그중 `git push` / `gh pr create`)
- **동작**: 이번에 나갈 커밋에 의존성·빌드 매니페스트(`package.json`·`go.mod`·`Cargo.toml`·`pom.xml` 등) 변경이 있는데 `changelog/changelog.md` 갱신이 없으면 **비차단 리마인더** 출력. push는 막지 않는다.
- **위치**: `.claude/hooks/changelog-reminder.py`, 설정은 `.claude/settings.json`의 `hooks.PreToolUse`.

### 참고 (hooks 기본)
- 훅 설정은 `.claude/settings.json`(프로젝트) 또는 유저 설정. 이벤트: `PreToolUse`·`PostToolUse`·`UserPromptSubmit`·`SessionStart`·`Stop` 등.
- PreToolUse는 `{decision, reason}` JSON으로 차단/허용 제어 가능. **리마인더는 비차단**(exit 0 + stdout/stderr 메시지)으로.
- 훅 스크립트는 stdin으로 tool 입력 JSON을 받음. `git push` 감지는 `tool_input.command` 파싱.
- 검증: 훅 붙인 뒤 매니페스트 바꾼 커밋으로 `git push` 시도 → 리마인더 뜨는지 확인. `settings.json` 문법 오류 주의(로드 실패 시 조용히 무시됨).

### 다른 훅 후보 (스킬과 연동되면 유용)
- `check` 커맨드를 Stop/PostToolUse에서 자동 실행?
- 커밋 메시지 prefix 검증(commit 스킬 규칙) PreToolUse on `git commit`.

---

## 열린 항목

- [ ] 오늘 작업 커밋 (위 표) — 내일 시작 전.
- [ ] 루트 `package-lock.json` stray 여부 확인 후 정리.
- [ ] `.claude/hooks/changelog-reminder.py` + `.claude/settings.json` 작성 (내일 본작업).
- [ ] `handoff` 스킬이 빈 스텁 — 핸드오프가 반복되면 changelog처럼 형식 작성 고려.

## 재개 명령
```bash
cd /Users/codevillain/Claude-Code-Expert/claude-template
git status          # 미커밋 확인
git log --oneline -3
# 커밋 후 hooks 작업 → .claude/settings.json + .claude/hooks/
```
