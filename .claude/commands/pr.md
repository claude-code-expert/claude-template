---
description: commit + push 후 현재 브랜치에서 base 브랜치로 PR 생성 (base=인자, 없으면 develop)
argument-hint: "[base-branch]"
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git push:*), Bash(git rev-parse:*), Bash(git log:*), Bash(git merge-base:*), Bash(gh pr:*)
---

현재 브랜치(head): !`git branch --show-current`
base 인자: "$1"

## 작업

**full `git diff` 내용은 절대 읽지 마라** (토큰 낭비). commit 커맨드와 push 커맨드를 순서대로 그대로 재사용한다.

1. **commit**: [commit](commit.md) 규칙대로 `git add -A` 후 `feat: docs: fix: debug: db: api: test:` prefix로 한 줄 한국어 커밋. 변경 없으면 건너뛴다.
2. **push**: [push](push.md) 규칙대로 origin에 push. upstream 없으면 `git push -u origin <현재 브랜치>`.
3. **base 결정**:
   - `$1` 이 있으면 base = `$1`
   - 없으면 base = `develop`
4. **PR 생성**:
   - PR 본문은 `git log <base>..HEAD --oneline` (커밋 제목 목록만, diff 아님)으로 요약해서 만든다. base가 로컬에 없으면 `origin/<base>` 로 대체.
   - `gh pr create --base <base> --head <현재 브랜치> --title "<대표 한 줄>" --body "<커밋 목록 요약>"`

## 규칙

- head == base 이면(현재 브랜치를 자기 자신에 PR) 중단하고 "base와 head가 같음: <브랜치>" 한 줄만 출력.
- `git merge-base <현재 브랜치> origin/<base>` 가 비면(공통 히스토리 없음) 중단하고 "base와 공통 히스토리 없음: <base>" 한 줄만 출력. 강제하지 마라.
- 이미 열린 PR이 있어 `gh pr create` 가 실패하면 강제하지 말고 `gh pr view --json url -q .url` 로 기존 PR URL만 보고.
- 생성 성공 시 PR URL 한 줄 외 추가 출력 금지.
