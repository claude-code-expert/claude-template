# Scaffold: Node / TypeScript

Node 백엔드 서비스 또는 라이브러리. **단일 공식 스캐폴더는 없다** — `npm init` 후 현행 도구를 얹는다.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **런타임**: Node 24 (dev), 22 (prod LTS 하한). Node 24는 `node app.ts` 네이티브 실행(타입은 strip만, 검사는 안 함).
- **dev 실행**: `tsx --watch` · **타입검사**: `tsc --noEmit` (CI/pre-commit) · **lint+format**: Biome(고정 버전) · **테스트**: Vitest.

## 스캐폴드

```bash
mkdir my-svc && cd my-svc && npm init -y
npm i -D typescript @types/node @tsconfig/node24 tsx vitest
npm i -D -E @biomejs/biome            # -E: Biome는 고정 버전 권장
npx @biomejs/biome init
```

`tsconfig.json` — 베이스를 extends, 손으로 옵션 나열 금지:

```json
{
  "extends": "@tsconfig/node24/tsconfig.json",
  "compilerOptions": { "outDir": "dist", "rootDir": "src" },
  "include": ["src", "tests"]
}
```

`package.json` scripts:

```json
{
  "type": "module",
  "scripts": {
    "dev": "tsx --watch src/index.ts",
    "typecheck": "tsc --noEmit",
    "lint": "biome check .",
    "test": "vitest",
    "build": "tsc"
  }
}
```

## 디렉터리 (flat)

```
my-svc/
├── package.json
├── tsconfig.json
├── biome.json
├── src/
│   └── index.ts
└── tests/
    └── index.test.ts
```

`services/`·`domain/`·`infra/` 폴더는 파일이 실제로 늘어날 때 나눈다. 처음엔 `src/` 하나.

## 코드 샘플

`src/index.ts`:

```ts
export function greet(name: string): string {
  return `hello, ${name}`;
}

if (import.meta.url === `file://${process.argv[1]}`) {
  console.log(greet(process.argv[2] ?? "world"));
}
```

`tests/index.test.ts`:

```ts
import { expect, test } from "vitest";
import { greet } from "../src/index.ts";

test("greet", () => {
  expect(greet("ohpen")).toBe("hello, ohpen");
});
```

## 피할 것

- `ts-node`·`nodemon` → `tsx --watch`. `jest` → `vitest`. `dotenv` → `node --env-file=.env`.
- 신규에 ESLint+Prettier 2종 세트 → Biome 단일 바이너리.
- `tsconfig` 옵션 수동 나열 → `@tsconfig/node24` extends.

## 출처

- Node.js 릴리스(LTS) — https://nodejs.org/en/about/previous-releases
- tsx — https://tsx.is · Biome — https://biomejs.dev · Vitest — https://vitest.dev
- `@tsconfig/node24` — https://github.com/tsconfig/bases
