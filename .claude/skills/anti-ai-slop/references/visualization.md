# Anti-Slop: 시각화 & 이미지

차트·그래프·다이어그램, 그리고 문서에 넣는 모든 이미지에 적용한다.

## 여기서 슬롭이란

인코딩하지 않고 장식만 하는 차트 — 기본 색상, 잘못된 차트 유형, 요점을 가리는 잡동사니 — 그리고 실제 스크린샷이나 직접 만든 다이어그램이 들어가야 할 자리에 그 특유의 "AI 느낌"을 풍기는 생성 래스터 이미지.

## 차트 징후 (안티패턴)

- 연속 데이터에 무지개/jet 컬러맵(지각적으로 불균일해 없는 띠를 만들어냄). 대신 지각 균일 맵(viridis)을 쓴다.
- 3D 파이 차트, 그리고 슬라이스 ~3개를 넘는 파이 차트 전반 — 각도/면적은 정확도 위계에서 낮다.
- 막대 차트의 y축 잘라내기(차이를 과장); 명시 없는 이중 y축(보이지 않은 상관을 암시).
- 차트정크: 진한 격자선·테두리·배경·그라데이션 채우기·그림자·3D 돌출 — 아무것도 인코딩하지 않는 잉크.
- 한 차트에 시리즈 과다(>6 라인/범주); 대신 스몰 멀티플로 나눈다.
- 라인/막대에 직접 라벨을 달면 될 걸, 독자가 왔다갔다해야 하는 범례.
- 정렬 안 된 범주형 막대(자연 순서가 없으면 값으로 정렬).
- 라벨·단위 없는 축; 발견이 아니라 주제만 적은 제목의 차트.
- 문장 하나가 더 잘 전달할 정보를 더하지 못하는 장식용 차트.

## AI 이미지 징후 (피하고, 실제 자산을 우선하라)

"AI 느낌": 밀랍처럼 과하게 매끈한 피부, 뒤틀린 손/손가락 개수 오류, 이미지 속 뭉개진 텍스트, 좌우대칭 죽, 과채도·HDR 후광, 불가능한 조명/그림자, 녹아내리거나 반복되는 배경, 뻔한 스톡 사진 느낌.

**규칙:** 문서에는 생성 래스터 이미지보다 실제 스크린샷, SVG/Mermaid 다이어그램, 또는 직접 만든 차트를 우선한다. 생성 이미지는 주제가 예시적이고 실제 자산이 없을 때만 문서에 넣는다 — 그때조차 쓰기 전에 위 징후를 점검한다.

## 규칙 (이렇게 하라)

- 지각 순서로 차트를 데이터에 맞춘다: **위치 > 길이 > 각도 > 면적 > 색상**(Cleveland & McGill). 정밀 비교에는 막대/점/산점도.
- 범주형 색상: 색맹 안전 정성 팔레트(**Okabe-Ito**, 8개 초과면 Paul Tol)에서 시작; 색상은 ≤6개로.
- 색조만 말고 명도를 바꿔 회색조에서도 살아남게 한다; 빨강/초록·파랑/보라 쌍을 피한다.
- 순차 데이터 → 순차 맵; 중심/발산 데이터 → 발산 맵; 범주 → 정성 팔레트. 이걸 뒤섞지 않는다.
- 가능하면 시리즈에 직접 라벨; 범주형 막대는 값으로 정렬; 막대 축은 0에서 시작.
- 데이터-잉크를 최대화한다: 아무것도 인코딩 안 하는 격자선·테두리·배경을 지운다(Tufte) — 적정 선에서.
- 통찰을 차트 위에 주석으로 단다; 제목은 주제가 아니라 발견을 말한다.
- 색상에만 의존하지 않는다 — 모양·라벨·패턴을 더한다(WCAG 1.4.1).
- 항상 "차트"가 아니라 발견을 설명하는 alt 텍스트를 쓴다.

## 도구 & 표준

- **Cleveland & McGill** — 인코딩 선택을 위한 지각 정확도 위계.
- **Tufte** — 데이터-잉크 비율과 차트정크.
- **Okabe-Ito / Paul Tol / ColorBrewer** — 색맹 안전 정성·순차 팔레트.
- **viridis** — 지각 균일 연속 컬러맵(matplotlib 기본).
- **WCAG 2.2** — 대비(1.4.3)와 색상 사용(1.4.1).
- **Vega-Lite / Datawrapper** — 그래픽 문법, 뉴스룸급 차트 기본값.

## 출처

- Cleveland-McGill hierarchy — https://www.textbookofusability.com/glossary/cleveland-mcgill-hierarchy.html
- Practitioners' perspectives on chartjunk / data-ink (Tufte) — https://arxiv.org/pdf/2009.02634
- Okabe-Ito palette (hex + usage; = Wong, Nature Methods) — https://conceptviz.app/blog/okabe-ito-palette-hex-codes-complete-reference
- ColorBrewer — https://colorbrewer2.org · matplotlib colormaps — https://matplotlib.org/stable/users/explain/colors/colormaps.html
- WCAG 2.2 — Use of Color (1.4.1) & Contrast (1.4.3) — https://www.w3.org/WAI/WCAG22/Understanding/use-of-color.html
- Spotting AI-generated images (tells) — https://insight.kellogg.northwestern.edu/article/ai-photos-identification
