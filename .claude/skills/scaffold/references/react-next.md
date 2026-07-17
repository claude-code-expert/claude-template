# Scaffold: React (Next.js)

React 웹앱은 Next.js App Router로 시작한다. SPA만 필요하면 대신 Vite + React를 쓰되, 대부분의 신규 웹앱은 Next.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **Next.js 16.x** — Turbopack 기본 번들러, React 19.2, App Router 표준. Pages Router는 유지보수 모드(신규 금지).
- 서버 컴포넌트가 기본. `"use client"`는 브라우저 API·상호작용이 필요할 때만.

## 스캐폴드

```bash
npx create-next-app@latest my-web
```

프롬프트에서 **"use recommended defaults"** 선택 → TypeScript · Tailwind · ESLint(또는 Biome) · App Router · Turbopack · `@/*` 별칭 · `AGENTS.md`. 버전은 스캐폴더가 최신으로 채운다(하드코딩 금지).

## 디렉터리 (App Router)

```
my-web/
├── package.json
├── next.config.ts
├── tsconfig.json
├── public/                # 정적 자산 (/foo.png → public/foo.png)
└── src/                   # 선택: 코드와 설정 분리
    └── app/
        ├── layout.tsx     # 공통 셸 (header/nav/footer)
        ├── page.tsx       # /
        └── loading.tsx    # 스켈레톤
```

`app/` 안의 규칙 파일: `page`(라우트), `layout`(공통 UI), `loading`, `error`, `route`(API). 폴더 = URL 세그먼트. `components/`·`lib/`·`hooks/`는 실제로 재사용이 생길 때 만든다.

## 코드 샘플

`src/app/page.tsx` — 서버 컴포넌트가 기본:

```tsx
export default async function Home() {
  const now = new Date().toISOString();
  return (
    <main>
      <h1>OhPen</h1>
      <p>서버에서 렌더된 시각: {now}</p>
    </main>
  );
}
```

상호작용이 필요할 때만 클라이언트로:

```tsx
"use client";
import { useState } from "react";

export function Counter() {
  const [n, setN] = useState(0);
  return <button onClick={() => setN(n + 1)}>{n}</button>;
}
```

## 피할 것

- **Create React App** — 죽음. SPA는 `npm create vite@latest`.
- 신규에 **Pages Router** — Server Actions·Cache Components 등 신기능은 App Router 전용.
- 옛 멘탈모델(모든 걸 `/components`·`/pages`로) — App Router에서 깨진다. "SSR 할까?"가 아니라 "브라우저 API가 필요한가?"로 판단.

## 출처

- create-next-app — https://nextjs.org/docs/app/api-reference/cli/create-next-app
- 프로젝트 구조 — https://nextjs.org/docs/app/getting-started/project-structure
- App Router 시작 — https://nextjs.org/docs/app/getting-started
