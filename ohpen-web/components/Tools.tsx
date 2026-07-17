import type { ReactNode } from "react";

type Tool = { key: string; name: string; desc: string; icon: ReactNode };

const TOOLS: Tool[] = [
  {
    key: "P",
    name: "포인터 강조",
    desc: "주변을 어둡게 죽이고 지금 이 지점만 밝게. 청중 200명의 시선을 한 점으로 모은다.",
    icon: (
      <svg width="60" height="40" viewBox="0 0 60 40" aria-hidden="true">
        <circle cx="30" cy="20" r="6" fill="var(--red)" />
        <circle cx="30" cy="20" r="13" fill="none" stroke="var(--red)" strokeWidth="2" opacity=".45" />
      </svg>
    ),
  },
  {
    key: "W",
    name: "글쓰기",
    desc: "슬라이드 위에 바로 필기. 예정에 없던 질문에 즉석으로 답을 적는다.",
    icon: (
      <svg width="60" height="40" viewBox="0 0 60 40" aria-hidden="true">
        <path d="M5 30 C 18 8, 24 34, 36 16 S 52 24, 56 12" stroke="var(--teal)" strokeWidth="3" fill="none" strokeLinecap="round" />
      </svg>
    ),
  },
  {
    key: "L",
    name: "라인 긋기",
    desc: 'A와 B를 잇는 곧은 선. 흐름도, 관계, "여기서 저기로"를 한 획에.',
    icon: (
      <svg width="60" height="40" viewBox="0 0 60 40" aria-hidden="true">
        <path d="M6 28 L 54 12" stroke="var(--amber)" strokeWidth="3" fill="none" strokeLinecap="round" />
      </svg>
    ),
  },
  {
    key: "B",
    name: "박스 치기",
    desc: '버튼, 오탈자, 숫자 하나를 사각형으로 가둔다. "이것"이라고 말하는 대신 보여준다.',
    icon: (
      <svg width="60" height="40" viewBox="0 0 60 40" aria-hidden="true">
        <rect x="10" y="9" width="40" height="22" rx="3" fill="none" stroke="var(--red)" strokeWidth="3" />
      </svg>
    ),
  },
  {
    key: "H",
    name: "형광펜",
    desc: "한 줄을 반투명하게 덮어 강조. 코드 리뷰에서 문제의 그 줄만.",
    icon: (
      <svg width="60" height="40" viewBox="0 0 60 40" aria-hidden="true">
        <rect x="8" y="15" width="44" height="12" rx="2" fill="var(--amber)" opacity=".5" />
      </svg>
    ),
  },
  {
    key: "E",
    name: "지우기",
    desc: "자국은 임시다. E 한 번이면 화면은 원래대로. 슬라이드 파일은 손대지 않는다.",
    icon: (
      <svg width="60" height="40" viewBox="0 0 60 40" aria-hidden="true">
        <path d="M14 26 L 40 26 L 46 14" stroke="var(--muted)" strokeWidth="3" fill="none" strokeLinecap="round" />
        <path d="M40 26 L 34 14" stroke="var(--muted)" strokeWidth="3" strokeLinecap="round" />
      </svg>
    ),
  },
];

export function Tools() {
  return (
    <section className="sec" id="tools">
      <h2 className="sechead">펜 여섯 자루</h2>
      <svg className="uline" width="150" height="12" viewBox="0 0 150 12" fill="none" aria-hidden="true">
        <path d="M3 8 C 40 3, 110 3, 147 7" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
      </svg>
      <p className="subhead">
        마우스를 흔들지 않는다. 키를 누르고, 화면에 직접 표시한다. 손을 떼면 자국이 남는다.
      </p>
      <div className="tools">
        {TOOLS.map((t) => (
          <div className="tool" key={t.key}>
            {t.icon}
            <h3>{t.name}</h3>
            <p>{t.desc}</p>
            <span className="kk">{t.key}</span>
          </div>
        ))}
      </div>
    </section>
  );
}
