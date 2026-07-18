# 결정 기록 (Decision Log)

되돌리기 어려운 결정과 그 근거를 시간순(최신 먼저)으로 남긴다. 코드가 "무엇을" 하는지는 git이 안다. 여기 적는 건 "왜 이 선택인가". append-only — 과거 항목은 고치지 않고, 뒤집히면 새 항목으로 남긴다.

## 2026-07-17 — OhPen 랜딩을 Next.js(App Router)로 스캐폴드
- **결정**: `ohpen-web/`를 `create-next-app`으로 생성. Next 16 App Router + React 19, 폰트는 `next/font`(Space Grotesk/Inter/Caveat), Tailwind 미사용(순수 CSS 토큰 유지), 전 섹션 서버 컴포넌트.
- **이유**: 정적 HTML 랜딩(`demo/ohpen-anti-slop.html`)을 실제 제품 코드베이스로 승격. App Router 서버 컴포넌트로 랜딩 전체를 정적 프리렌더(제로 JS). 공식 스캐폴더 사용으로 버전 하드코딩 회피(`@latest` → 16.2.10 / react 19.2.4).
- **대안**: (1) 정적 HTML 유지 → 재사용·확장 불가로 탈락. (2) Vite + React SPA → SSR/정적 프리렌더 이점이 없어 탈락. (3) Tailwind 추가 → 랜딩이 커스텀 CSS 토큰 시스템이라 미사용, 의존성만 늘어 탈락.
- **영향**: 새 워크스페이스 `ohpen-web/`(Next·React 의존성 추가). SVG 텍스트는 `next/font` 해시 폰트명 때문에 프레젠테이션 속성 대신 CSS 변수로 배선 필요. 브라우저 확장의 루트 속성 주입 대비 `<html suppressHydrationWarning>` 적용.
