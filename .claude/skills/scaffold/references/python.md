# Scaffold: Python

Python 앱·라이브러리는 **uv**로 시작한다. uv 하나가 인터프리터·가상환경·의존성·락·실행을 다 한다.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **uv**(패키징·환경·실행) + **Ruff**(lint+format) + **ty**(타입검사, Astral) + **pytest**. Python 3.13.
- 설정은 전부 `pyproject.toml` 한 곳. `setup.py`·`setup.cfg`·`.flake8`·`mypy.ini` 금지.
- **src 레이아웃** — 로컬은 되는데 CI import가 깨지는 문제를 막는다.

## 스캐폴드

```bash
uv python install 3.13
uv init my-app            # 앱. 라이브러리는  uv init --lib my-lib
cd my-app
uv add fastapi 'pydantic>=2'
uv add --dev pytest ruff ty
uv sync
uv run pytest
```

## 디렉터리 (src 레이아웃)

```
my-app/
├── pyproject.toml
├── uv.lock              # 커밋 (재현성의 소스)
├── .python-version
├── src/
│   └── my_app/
│       └── __init__.py
└── tests/
    └── test_core.py
```

`pyproject.toml` — 툴 설정 집중:

```toml
[project]
name = "my-app"
version = "0.1.0"
requires-python = ">=3.13"
dependencies = ["fastapi", "pydantic>=2"]

[dependency-groups]
dev = ["pytest", "ruff", "ty"]

[tool.ruff]
line-length = 88
target-version = "py313"

[tool.ruff.lint]
select = ["E", "F", "I", "UP"]   # pyflakes·pycodestyle·isort·pyupgrade
```

## 코드 샘플

`src/my_app/__init__.py`:

```python
def greet(name: str) -> str:
    return f"hello, {name}"
```

`tests/test_core.py`:

```python
from my_app import greet


def test_greet() -> None:
    assert greet("ohpen") == "hello, ohpen"
```

## 피할 것

- 수동 `python -m venv` + `pip install` → `uv`.
- `requirements.txt`를 진실의 소스로 → `uv.lock`이 소스, 필요하면 lock에서 export.
- `setup.py`/`setup.cfg`/`.flake8`/`mypy.ini` → 전부 `pyproject.toml`.
- 신규에 Poetry → uv. (기존 Poetry는 편할 때 이관, uv가 읽어들임.)

## 출처

- uv — https://docs.astral.sh/uv/ · Ruff — https://docs.astral.sh/ruff/ · ty — https://github.com/astral-sh/ty
- 프로젝트 셋업 튜토리얼 — https://pydevtools.com/handbook/tutorial/set-up-a-complete-python-project/
