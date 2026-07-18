# Scaffold: Vue

Vue 3 앱은 `create-vue`(Vite 기반)로 시작한다. `create-vite`의 vue 템플릿은 barebones(테스트·lint 없음)라 공식 스타터인 `create-vue`를 쓴다.

## 버전 / 도구 (2026-07 · 확인 후 사용)

- **Vue 3 + Vite**, `<script setup lang="ts">` 스타일, 상태관리는 **Pinia**, 테스트는 **Vitest**, E2E는 Cypress/Playwright.
- IDE 확장은 **"Vue - Official"** (Vetur 아님).

## 스캐폴드

```bash
npm create vue@latest my-app
```

프롬프트에서 TypeScript · Vue Router · Pinia · Vitest 선택. 스캐폴더가 Vite·플러그인·설정을 채운다.

## 디렉터리

```
my-app/
├── index.html
├── vite.config.ts
├── package.json
├── public/
└── src/
    ├── main.ts
    ├── App.vue
    ├── components/
    ├── views/          # 라우트가 있을 때
    ├── router/         # Router 선택 시
    └── stores/         # Pinia 선택 시
```

`views/`·`router/`·`stores/`는 해당 기능을 켰을 때만 생긴다. 단일 페이지면 `App.vue` + `components/`로 충분.

## 코드 샘플

`src/components/PenButton.vue` — `<script setup>`:

```vue
<script setup lang="ts">
import { ref } from "vue";

const strokes = ref(0);
</script>

<template>
  <button @click="strokes++">그린 획: {{ strokes }}</button>
</template>
```

`src/stores/canvas.ts` — Pinia:

```ts
import { defineStore } from "pinia";
import { ref } from "vue";

export const useCanvas = defineStore("canvas", () => {
  const active = ref(false);
  const toggle = () => (active.value = !active.value);
  return { active, toggle };
});
```

## 피할 것

- **Vue CLI(`@vue/cli`)** — 유지보수 모드, 신규 금지. webpack 대신 Vite.
- **Vetur** — `Vue - Official` 확장으로 대체.
- `create-vite`의 vue 템플릿으로 신규 앱 — 테스트/lint가 없다. `create-vue` 사용.
- Options API 기본 — 신규는 `<script setup>` + Composition API.

## 출처

- create-vue — https://github.com/vuejs/create-vue
- Vue 툴링 가이드 — https://vuejs.org/guide/scaling-up/tooling.html
- Vue 3 마이그레이션 권장 — https://v3-migration.vuejs.org/recommendations
