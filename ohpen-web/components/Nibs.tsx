// 브랜드 마크: 빨강·앰버·틸 마커 세 자루. nav + footer 재사용.
export function Nibs() {
  return (
    <span className="nibs">
      <span className="nib" style={{ background: "var(--red)" }} />
      <span className="nib" style={{ background: "var(--amber)" }} />
      <span className="nib" style={{ background: "var(--teal)" }} />
    </span>
  );
}
