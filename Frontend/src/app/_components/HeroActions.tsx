import Link from "next/link";
import React from "react";


export default function HeroActions() {
return (
<div className="flex flex-wrap gap-3 items-center">
<Link href="/chat" className="inline-flex items-center gap-3 px-5 py-3 rounded-full bg-gradient-to-br from-cyan-500 to-teal-500 text-slate-900 font-semibold shadow-lg">Try the chat</Link>
<a href="#features" className="text-sm text-slate-300 hover:underline">Explore features →</a>
</div>
);
}