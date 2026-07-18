# Scaffold: Go

Go 서비스·CLI는 `go mod init` 하나로 시작한다. **flat부터.** `cmd/`·`pkg/`는 코드가 요구할 때만.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **Go 1.26.x** (최신 2개 메이저만 지원: 1.26 / 1.25). 툴체인 내장: `go test`, `go vet`, `gofmt`.
- 레이아웃 원칙: **작으면 루트에 flat**, 비공개 로직은 `internal/`(컴파일러가 외부 import 차단), `cmd/`는 바이너리가 여럿일 때, `pkg/`는 외부 공개 라이브러리일 때만.

## 스캐폴드

```bash
mkdir myapp && cd myapp
go mod init github.com/you/myapp
# 의존성은 import 후 자동 정리:
go mod tidy
```

## 디렉터리

단일 바이너리 / 작은 라이브러리 — **루트에 flat**:

```
myapp/
├── go.mod
├── go.sum
├── main.go
└── canvas.go
```

비공개 패키지가 생기면 `internal/`:

```
myapp/
├── go.mod
├── main.go
└── internal/
    └── canvas/
        └── canvas.go
```

`cmd/`는 바이너리가 둘 이상일 때, `pkg/`는 외부에서 import할 라이브러리를 낼 때만. 그 전엔 노이즈.

## 코드 샘플

`main.go`:

```go
package main

import "fmt"

func greet(name string) string {
	return fmt.Sprintf("hello, %s", name)
}

func main() {
	fmt.Println(greet("ohpen"))
}
```

`main_test.go`:

```go
package main

import "testing"

func TestGreet(t *testing.T) {
	if got := greet("ohpen"); got != "hello, ohpen" {
		t.Errorf("greet() = %q", got)
	}
}
```

## 피할 것

- `golang-standards/project-layout`(비공식) 맹목 복제 — `/pkg/`는 import 경로에 무의미한 pass-through.
- 파일 하나짜리 프로젝트에 `cmd/`·`pkg/`·깊은 트리 조기 도입.
- 서버 프로젝트에서 로직을 외부 공개용으로 노출 — 대신 `internal/`.

## 출처

- Go 모듈 레이아웃(공식) — https://go.dev/doc/modules/layout
- Go 릴리스 — https://go.dev/doc/devel/release
- No-nonsense Go layout — https://laurentsv.com/blog/2024/10/19/no-nonsense-go-package-layout.html
