// 키바인드 범례 = 제품 진실(키보드 구동)을 구조에 인코딩. 장식 아님.
const KEYS: Array<[string, string]> = [
  ["⌘⇧D", "캔버스 켜기/끄기"],
  ["P", "포인터"],
  ["W", "글쓰기"],
  ["L", "라인"],
  ["B", "박스"],
  ["E", "지우기"],
  ["Esc", "원래 화면으로"],
];

export function KeybindStrip() {
  return (
    <div className="keys">
      {KEYS.map(([cap, label]) => (
        <div className="key" key={cap}>
          <span className="cap">{cap}</span> {label}
        </div>
      ))}
    </div>
  );
}
