# Scaffold: Rust

Rust는 `cargo new`로 시작한다. `Cargo.toml`을 손으로 쓰지 말고, 의존성은 `cargo add`, edition은 cargo 기본값에 맡긴다.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **Edition 2024** (Rust 1.85+ 안정, `cargo new` 기본). 툴: `cargo`, `clippy`, `rustfmt`.
- 워크스페이스는 **크레이트가 여럿일 때만**. 단일 크레이트는 flat.

## 스캐폴드

```bash
cargo new my-app            # 바이너리. 라이브러리는  cargo new --lib my-lib
cd my-app
cargo add serde --features derive
cargo add tokio --features full
cargo build
```

`Cargo.toml` — edition은 cargo가 채움. MSRV만 명시:

```toml
[package]
name = "my-app"
version = "0.1.0"
edition = "2024"
rust-version = "1.85"

[dependencies]
# cargo add 가 채운다 — 손으로 버전 하드코딩 금지
```

## 디렉터리

단일 크레이트 — flat:

```
my-app/
├── Cargo.toml
├── Cargo.lock          # 바이너리는 커밋
└── src/
    └── main.rs         # 라이브러리는 lib.rs
```

크레이트가 여럿이 될 때만 워크스페이스:

```toml
# 루트 Cargo.toml (가상 워크스페이스)
[workspace]
resolver = "3"                        # edition 2024 → resolver 3, 가상 워크스페이스는 명시 필수
members = ["core", "cli"]

[workspace.dependencies]
serde = { version = "1", features = ["derive"] }
```

멤버 크레이트는 `serde.workspace = true`로 참조. 처음부터 이 트리를 깔지 말 것.

## 코드 샘플

`src/main.rs`:

```rust
fn greet(name: &str) -> String {
    format!("hello, {name}")
}

fn main() {
    println!("{}", greet("ohpen"));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn greets() {
        assert_eq!(greet("ohpen"), "hello, ohpen");
    }
}
```

## 피할 것

- `Cargo.toml`·의존성 버전 손으로 쓰기 → `cargo add`.
- `edition` 하드코딩(옛 2021 등) → `cargo new` 기본값.
- 크레이트 하나짜리에 워크스페이스 조기 도입.

## 출처

- The Cargo Book — https://doc.rust-lang.org/cargo/
- 워크스페이스 — https://doc.rust-lang.org/cargo/reference/workspaces.html
- Edition 2024 — https://doc.rust-lang.org/edition-guide/rust-2024/
