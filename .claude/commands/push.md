---
description: 현재 브랜치에서 add + 한 줄 커밋 후 origin으로 push
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git push:*), Bash(git rev-parse:*)
---

현재 브랜치: !`git branch --show-current`
변경 파일: !`git status --short`
변경 요약(파일명+증감만): !`git diff --stat HEAD`
upstream 설정 여부: !`git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "NO_UPSTREAM"`

## 작업

위 정보만으로 커밋 후 push 한다. **full `git diff` 내용은 절대 읽지 마라** (토큰 낭비). 위 `--stat`과 파일명만으로 판단한다.

1. 변경이 있으면 `git add -A` 후, `feat: docs: fix: debug: db: api: test:` 중 성격에 맞는 prefix로 한 줄 한국어 커밋(마침표 없이) `git commit -m "..."` 실행. 변경 없으면 커밋 건너뛴다.
2. push 실행:
   - upstream이 `NO_UPSTREAM` 이면 `git push -u origin <현재 브랜치>`
   - 아니면 `git push`
3. push 후 결과 한 줄 확인 외 추가 출력 금지.

## 규칙

- 커밋할 변경도 없고 push할 앞선 커밋도 없으면 "push할 내역 없음" 한 줄만 출력하고 종료.
- **`--force` / `-f` push 절대 금지.** 거부되면 사용자에게 상황만 보고하고 강제하지 마라.
- 커밋 로직은 [commit](commit.md) 커맨드와 동일 규칙을 따른다.
