export function Hero() {
  return (
    <section className="hero">
      <div>
        <div className="eyebrow">macOS 슬라이드 포인터</div>
        <h1>
          키 하나.
          <br />
          화면이 <span className="draw">칠판</span>이 된다.
        </h1>
        <p className="lede">
          슬라이드든 브라우저든 코드든, OhPen은 그 <b>위에 바로 그린다.</b> 버그에
          동그라미, 버튼에 박스, 중요한 숫자에 밑줄 — 앱을 벗어나지 않고, 발표
          도중에.
        </p>
        <div className="actions">
          <a className="primary" href="#get">
            macOS용 다운로드
          </a>
          <a className="textlink" href="#tools">
            그리는 걸 직접 보기 ↓
          </a>
        </div>
        <span className="os">⌘⇧D 를 누르면 지금 이 화면에도 그릴 수 있습니다</span>
      </div>

      {/* 실제 화면 목업 + 손그림 잉크 주석 (전부 SVG, 로드 시 draw 애니메이션) */}
      <svg
        className="screen"
        viewBox="0 0 640 430"
        role="img"
        aria-label="코드 에디터 화면 위에 OhPen이 빨간 동그라미, 틸 박스, 형광펜, 화살표를 손으로 그린 모습"
      >
        {/* window */}
        <rect x="34" y="26" width="572" height="378" rx="14" fill="#0F131A" stroke="#232936" />
        <rect x="34" y="26" width="572" height="38" rx="14" fill="#171C25" />
        <rect x="34" y="52" width="572" height="12" fill="#171C25" />
        <circle cx="58" cy="45" r="5" fill="#FF5F57" />
        <circle cx="76" cy="45" r="5" fill="#FEBC2E" />
        <circle cx="94" cy="45" r="5" fill="#28C840" />
        <text x="320" y="49" textAnchor="middle" fontSize="12.5" fill="#5A6473">
          deploy.yaml — checkout
        </text>
        {/* code */}
        <g fontSize="16.5" fill="#C7CEDB">
          <text x="70" y="112">
            <tspan fill="#7C86F5">service</tspan>: checkout
          </text>
          <text x="70" y="146">
            {"  region: "}
            <tspan fill="#8FE388">us-east-1</tspan>
          </text>
          <text x="70" y="180">
            {"  replicas: "}
            <tspan fill="#FFB86B">3</tspan>
          </text>
          <text x="70" y="214">
            {"  latency_p95: "}
            <tspan fill="#FFB86B">812ms</tspan>
          </text>
          <text x="70" y="248">
            {"  status: "}
            <tspan fill="#8FE388">shipping</tspan>
          </text>
        </g>
        {/* deploy button */}
        <rect x="430" y="322" width="128" height="44" rx="9" fill="#1F6FEB" />
        <text className="btn-label" x="494" y="350" textAnchor="middle" fontWeight="600" fontSize="15" fill="#fff">
          Deploy
        </text>

        {/* INK: 형광펜(812ms) */}
        <rect className="hl" x="196" y="200" width="96" height="20" rx="3" fill="#FFC24B" opacity="0.42" />
        {/* INK: 틸 박스 (replicas 줄) */}
        <path
          className="ink"
          style={{ stroke: "var(--teal)", strokeWidth: 3 }}
          d="M66 166 C 180 161, 300 162, 300 168 C 304 182, 299 192, 294 194 C 190 198, 96 197, 66 195 C 61 188, 60 174, 66 166"
        />
        {/* INK: 빨간 동그라미 (Deploy) */}
        <path
          className="ink i2"
          style={{ stroke: "var(--red)", strokeWidth: 3.4 }}
          d="M410 344 C 404 320, 470 312, 502 313 C 560 316, 586 332, 578 346 C 568 366, 500 372, 458 369 C 414 366, 398 356, 408 336 C 412 328, 424 324, 432 322"
        />
        {/* INK: 화살표 812ms -> */}
        <path className="ink i3" style={{ stroke: "var(--red)", strokeWidth: 3 }} d="M368 246 C 350 238, 336 226, 320 214" />
        <path className="ink i3" style={{ stroke: "var(--red)", strokeWidth: 3 }} d="M320 214 L 334 216 M320 214 L 322 228" />
        {/* 손글씨 라벨 */}
        <text className="scribble label-hand" x="372" y="262" fontWeight="700" fontSize="25" fill="#FF4D3D" transform="rotate(-4 372 262)">
          p95 튀는 중
        </text>
      </svg>
    </section>
  );
}
