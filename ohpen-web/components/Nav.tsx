import { Nibs } from "@/components/Nibs";

export function Nav() {
  return (
    <nav>
      <div className="brand">
        <Nibs /> OhPen
      </div>
      <div className="navlinks">
        <a href="#tools">펜</a>
        <a href="#uses">쓰는 곳</a>
        <a href="#get">다운로드</a>
      </div>
      <a className="ghost" href="#get">
        macOS용 받기
      </a>
    </nav>
  );
}
