import { Nibs } from "@/components/Nibs";

export function SiteFooter() {
  return (
    <footer>
      <div className="brand" style={{ color: "var(--muted)" }}>
        <Nibs /> OhPen
      </div>
      <div>macOS 12+ · Apple Silicon &amp; Intel · © 2026</div>
    </footer>
  );
}
