import { Nav } from "@/components/Nav";
import { Hero } from "@/components/Hero";
import { KeybindStrip } from "@/components/KeybindStrip";
import { Tools } from "@/components/Tools";
import { Uses } from "@/components/Uses";
import { ClosingCta } from "@/components/ClosingCta";
import { SiteFooter } from "@/components/SiteFooter";

export default function Home() {
  return (
    <>
      <div className="wrap">
        <Nav />
        <Hero />
      </div>
      <div className="wrap">
        <KeybindStrip />
      </div>
      <div className="wrap">
        <Tools />
      </div>
      <div className="wrap">
        <Uses />
      </div>
      <div className="wrap">
        <ClosingCta />
      </div>
      <div className="wrap">
        <SiteFooter />
      </div>
    </>
  );
}
