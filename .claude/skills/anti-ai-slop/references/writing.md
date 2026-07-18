# Anti-Slop: 문서 & 기술 글쓰기

산문에 적용한다: 문서, README, 리포트, PR/커밋 본문, 코드 주석, 채팅 답변.

## 여기서 슬롭이란

유창하고 구조가 균일하지만 정보를 더하지 않고 단어만 늘리는 글. 구체적 주장에 헌신하는 대신 얼버무리고, 되풀이하고, 치장한다. 매끄럽게 읽히지만 하는 말이 없다.

## 징후 (안티패턴)

한국어 글이라도 아래의 논리·구조 징후는 그대로 적용된다. 영어 단어 목록은 영어 산출물에서 grep으로 걸러낼 실제 표적이므로 원문 그대로 둔다.

- **남용 어휘 — grep 목록:** delve, leverage, utilize, robust, seamless, streamline, foster, harness, underscore, embark, comprehensive, crucial, pivotal, nuanced, multifaceted, realm, landscape, tapestry, ecosystem, navigate, unprecedented, resonate, spearhead. (한국어: "원활한", "견고한", "포괄적인", "혁신적인" 같은 상투어)
- **"Not just X, but Y" / "It isn't X, it's Y":** 부정 후 정정으로 얻지 못한 강조를 노림; LLM은 문단당 대략 하나씩 뱉는다. (한국어: "단순한 X가 아니라 Y")
- **3의 법칙(rule of three):** 짝 맞춘 삼중구("빠르고, 안정적이고, 저렴한") — 항상 셋, 둘도 넷도 아니다.
- **"From X to Y":** 거짓 범위 프레이밍("스타트업부터 대기업까지").
- **목청 가다듬기 서두:** "In today's rapidly evolving landscape," "In an era of," "It's important to note that," "It's worth noting that." (한국어: "오늘날 빠르게 변화하는 환경에서", "~라는 점에 주목할 필요가 있다")
- **부풀린 결론:** "At the end of the day," "Moving forward," "Ultimately" — 뻔한 심오함으로의 전환("broader implications"). (한국어: "결국", "앞으로 나아가")
- **굵은 라벨 불릿:** 모든 리스트 항목이 `**문구:**`로 시작 — 산문이어야 할 곳에 리스트 뼈대가 새어나옴.
- **빈 얼버무리기 / 거짓 균형:** "it depends," "both approaches have merit," 편을 고르지 않으면서 뉘앙스를 연기하는 수식어. (한국어: "상황에 따라 다르다", "둘 다 나름의 장점이 있다")
- **채우기 부사:** importantly, essentially, fundamentally, inherently, increasingly, particularly. (한국어: "중요하게도", "본질적으로", "점점 더", "특히")
- **상투 은유:** double-edged sword, tip of the iceberg, north star, game-changer, perfect storm. (한국어: "양날의 검", "빙산의 일각", "판도를 바꾸는")
- **포맷 버릇:** 모든 쉼표를 em-dash로 대체; 헤딩의 장식용 이모지; 다음 줄에서 스스로 답하는 수사적 질문.
- **아첨:** "Great question!", "You're absolutely right." (한국어: "좋은 질문입니다", "정확히 맞습니다")
- **낮은 버스티니스:** 전편에 걸쳐 균일한 문장 길이와 3~5문장 문단.

## 규칙 (이렇게 하라)

- 결론을 먼저 낸다; 훑어보는 독자가 필요한 단어를 앞에 배치한다.
- 불필요한 단어를 뺀다 — 정보를 나르지 않는 단어는 잘라낸다(Strunk).
- 긴 단어보다 짧은 일상어를 택한다(Orwell 규칙 2).
- 능동태를 쓴다; 행위 주체를 명시한다(Google 스타일; Orwell 규칙 4).
- 추상을 구체 명사·숫자·이름 있는 예시로 바꾼다.
- 문장 하나에 아이디어 하나; 리듬만 채우는 복문을 쪼갠다.
- 문장·문단 길이를 의도적으로 변주한다.
- 소리 내어 읽는다; 동료에게 말하지 않을 문장이면 다시 쓴다(Graham).
- 프롬프트나 바로 앞 문장을 되풀이만 하는 문장은 지운다.
- 말하지 말고 보여준다: 형용사가 아니라 명령·지표·실패 양상을 준다.
- 지시문에서 반사적 "부디", "물론", 얼버무리기를 잘라낸다.
- 정말로 야만적인 문장을 쓰느니 여기 규칙 아무거나 깨라(Orwell 규칙 6).

## 도구 & 표준

- **Google developer documentation style guide** — 능동태, 2인칭, 지시 앞에 조건.
- **Microsoft Writing Style Guide** — "따뜻하고 편안하게, 명료하고 분명하게"; 훑기 좋게 쓰고; 요점으로 바로.
- **Strunk & White, *The Elements of Style*** — 간결, 능동태, "모든 단어가 값을 하게 하라".
- **Orwell, "Politics and the English Language"** — 진부한 은유·긴 단어·수동태·전문용어에 맞선 여섯 규칙.
- **Vale** — 설정 가능한 산문 린터; Google/Microsoft/proselint/write-good 팩 포함; 수동태·모호어·금지어를 잡는다.
- **proselint** — 얼버무리기·중복·클리셰·현학에 대한 휴리스틱.
- **write-good** — 수동태·모호어·장황한 표현을 잡는다.

## 출처

- Google developer documentation style guide — https://developers.google.com/style/highlights
- Microsoft Writing Style Guide, Top 10 tips — https://learn.microsoft.com/en-us/style-guide/top-10-tips-style-voice
- Orwell's six rules (Duke Scientific Writing) — https://sites.duke.edu/scientificwriting/orwells-6-rules/
- Paul Graham, "Write Simply" — https://paulgraham.com/simply.html
- LLM prose tells catalog — https://git.eeqj.de/sneak/prompts/src/branch/main/prompts/LLM_PROSE_TELLS.md
- Vale — https://vale.sh/ · proselint — https://github.com/amperser/proselint
