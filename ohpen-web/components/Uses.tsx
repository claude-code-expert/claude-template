const USES = [
  {
    w: "발표",
    h: "지금 이 줄을 보게 만든다",
    p: '스무 개 불릿 중 하나에 동그라미. 말로 "세 번째 항목요"라고 반복하지 않는다.',
  },
  {
    w: "강의",
    h: "판서를 슬라이드 위에서",
    p: "칠판과 프로젝터를 오가지 않는다. 예제 풀이를 자료 위에 바로 적는다.",
  },
  {
    w: "데모",
    h: "클릭할 곳을 손으로 짚듯",
    p: '"여기 이 버튼"을 화면에 박스로. 라이브 데모에서 길 잃는 청중을 붙잡는다.',
  },
];

export function Uses() {
  return (
    <section className="sec" id="uses" style={{ paddingTop: 0 }}>
      <h2 className="sechead">발표 · 강의 · 데모</h2>
      <svg className="uline" width="220" height="12" viewBox="0 0 220 12" fill="none" aria-hidden="true">
        <path d="M3 8 C 60 3, 160 3, 217 7" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
      </svg>
      <p className="subhead">
        화면을 공유하는 자리라면 어디든. 잉크는 창 위에 뜨고, 원본 파일은 그대로다.
      </p>
      <div className="uses">
        {USES.map((u) => (
          <div className="use" key={u.w}>
            <div className="w">{u.w}</div>
            <h4>{u.h}</h4>
            <p>{u.p}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
