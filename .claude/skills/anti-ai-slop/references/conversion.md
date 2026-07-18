# Anti-Slop: 문서 변환 & 편집

문서를 포맷 간 변환할 때(Markdown ↔ DOCX/PDF/HTML/LaTeX/슬라이드), 그리고 기존 문서를 편집·리팩터링할 때 적용한다.

## 여기서 슬롭이란

문서를 조용히 망가뜨리는 모든 변환: 내용을 누락하거나, 의미 구조를 뭉개거나, 변환 왕복(round-trip)에서 손실을 내는 것 — 그리고 작은 수정을 요청받았는데 통째로 다시 쓰거나, 구조화된 포맷을 파싱하지 않고 정규식으로 후벼 파는 것. 결과물은 그럴듯해 보이지만 조용히 틀려 있다.

## 징후 (안티패턴)

- 파서 대신 HTML·Markdown 구조에 정규식/찾아바꾸기 — 코드블록 안의 `#`, Setext 헤딩, 중첩 태그, 산문 속 `$` vs 수식에서 깨진다.
- 최소한의 span 단위 수정을 요청받았는데 통째로 재작성 — diff 대신 파일 전체를 반환.
- 변환 시 각주·병합된 표 셀·상호참조·YAML frontmatter·코드블록 언어 태그를 누락하거나 인라인으로 뭉갬.
- 헤딩 계층을 평탄화(H2/H3 → 굵은 글씨)하거나 중첩 리스트를 접어버림.
- 섹션 이동·이름변경 후 내부 링크·앵커·목차(TOC)를 깨뜨림.
- 편집 중간에 저자의 목소리를 바꿈 — 축약형 "교정", 특이한 대소문자 손대기, 문단 재배열; 그대로 둬야 할 인용문이나 코드를 편집.
- 검증 없음 — 출력을 원본과 diff하지도, 결과 파일을 열어보지도 않음.
- 스크린샷/래스터 기반 PDF(예: html2pdf.js) — 선택·검색 불가한 텍스트, 러닝 헤더·실제 페이지네이션 없음.

## 규칙 (이렇게 하라)

- 구조화된 포맷은 AST/파서 도구(Pandoc, remark/rehype)를 쓴다 — HTML/Markdown 구조를 정규식으로 변환하지 않는다.
- 의미 요소를 보존한다: 헤딩, 리스트 중첩, 표, 각주, 링크, 코드블록 언어, 메타데이터/frontmatter.
- 재작성보다 최소 diff를 택한다 — 지적된 span만 제자리에서 고치고, 멀쩡한 부분은 건드리지 않는다.
- 진실의 소스는 하나(예: Markdown)로 두고 나머지를 생성한다 — 병렬 사본을 손으로 관리하지 않는다.
- 완료 선언 전에 출력을 원본 대비 검증한다 — diff, 왕복 변환, 또는 파일 열어보기.
- 변환을 멱등(idempotent)하게 만든다 — 다시 돌려도 추가 변경이 없어야 한다.
- 편집 시 저자의 목소리를 보존한다 — 인용문·코드·출처 표기 텍스트는 손대지 말고 대신 플래그만 남긴다.
- 구조 편집 후 상호참조·앵커·목차를 갱신한다.
- 변환은 본질적으로 손실이 있다고 전제한다(Pandoc의 AST는 최소공통분모다) — 손실을 숨기지 말고 누락된 요소를 플래그한다.
- 기계적 포맷팅은 산문을 다시 쓰지 말고 결정론적 린터로 강제한다.

## 도구 & 표준

- **Pandoc** — 범용 reader→AST→writer 변환기; Lua/JSON **필터**가 텍스트가 아니라 구조를 변환한다; `--to native`로 AST가 무엇을 남기고 버렸는지 확인.
- **Typst** — 빠른 Rust 조판기, Markdown 유사 문법; LaTeX 대안 `--pdf-engine`.
- **WeasyPrint** — CSS Paged Media로 HTML/CSS→PDF(러닝 헤더·각주·실제 페이지네이션); 선택 가능한 텍스트, 스크린샷 없음.
- **remark / rehype** — unified mdast/hast AST 파이프라인(parse→transform→stringify); 정규식 말고 `unist-util-visit` 사용.
- **markdownlint** — 결정론적 Markdown 구조/스타일 린팅; 산문을 건드리지 않고 헤딩·공백 드리프트를 잡는다.

## 출처

- Pandoc — Filters — https://pandoc.org/filters.html
- Pandoc — User's Guide (conversion is not lossless) — https://pandoc.org/MANUAL.html
- Transforming Markdown with remark & rehype — https://ryanfiller.com/blog/remark-and-rehype-plugins
- Modifying nodes in an AST (CSS-Tricks) — https://css-tricks.com/how-to-modify-nodes-in-an-abstract-syntax-tree/
- WeasyPrint vs. other PDF generators — https://weasyprint.com/
- Typst as a fast (Xe)LaTeX alternative — https://slhck.info/software/2025/10/25/typst-pdf-generation-xelatex-alternative.html
