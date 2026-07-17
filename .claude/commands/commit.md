---
description: 현재 브랜치에서 변경 내역을 add 후 한 줄 커밋 메시지로 commit
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git status:*), Bash(git diff:*), Bash(git branch:*)
---

현재 브랜치: !`git branch --show-current`
변경 파일: !`git status --short`
변경 요약(파일명+증감만): !`git diff --stat HEAD`

## 작업

위 정보만으로 커밋을 수행한다. **full `git diff` 내용은 절대 읽지 마라** (토큰 낭비). 위에 주입된 `--stat`과 파일명만으로 판단한다.

1. `git add -A` 로 전체 스테이징.
2. 변경 파일명과 `--stat`을 근거로 한 일을 한 줄로 요약한다.
3. 아래 prefix 중 변경 성격에 가장 맞는 하나를 골라 커밋 메시지를 만든다:
   `feat:` `docs:` `fix:` `debug:` `db:` `api:` `test:`
4. `git commit -m "<prefix> <한 일 한 줄 요약>"` 실행. 메시지는 한국어, 한 줄, 마침표 없이.

## 규칙

- 변경 없으면(위 목록 비었으면) add/commit 하지 말고 "변경 없음" 한 줄만 출력하고 종료.
- push 하지 않는다. commit 까지만.
- 커밋 후 `git status --short` 로 결과 한 줄 확인 외 추가 출력 금지.
