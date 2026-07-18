import type { Metadata } from "next";
import { Space_Grotesk, Inter, Caveat } from "next/font/google";
import "./globals.css";

// 원본 랜딩의 3역할 타이포. <link> 대신 next/font 로 self-host + 해시된 CSS 변수 노출.
const spaceGrotesk = Space_Grotesk({ subsets: ["latin"], variable: "--font-mono" });
const inter = Inter({ subsets: ["latin"], variable: "--font-sans" });
const caveat = Caveat({ subsets: ["latin"], variable: "--font-hand" });

export const metadata: Metadata = {
  title: "OhPen — 키 하나로 화면이 칠판이 된다",
  description:
    "슬라이드·브라우저·코드 위에 바로 그리는 macOS 슬라이드 포인터. 포인터 강조, 글쓰기, 라인, 박스.",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html
      lang="ko"
      className={`${spaceGrotesk.variable} ${inter.variable} ${caveat.variable}`}
      // 브라우저 확장(예: Trancy)이 <html>에 속성을 주입해 발생하는 하이드레이션 경고 억제.
      // 이 요소의 속성 차이만 억제할 뿐 하위 실제 불일치는 그대로 보고됨.
      suppressHydrationWarning
    >
      <body>{children}</body>
    </html>
  );
}
