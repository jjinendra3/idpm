import React from "react";
import Link from "next/link";

export default function Hero() {
return (
<div>
<div className="inline-flex items-center gap-2 bg-slate-800/40 px-3 py-1 rounded-full text-xs text-cyan-300 w-max">
<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" aria-hidden>
<path d="M3 12h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
<path d="M3 6h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
<path d="M3 18h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
</svg>
Middleware + AI · Real-time
</div>


<div className="mt-4 flex flex-wrap gap-3 items-center">
<Link href="/chat" className="inline-flex items-center gap-3 px-5 py-3 rounded-full bg-gradient-to-br from-cyan-500 to-teal-500 text-slate-900 font-semibold shadow-lg">Try the chat</Link>
<a href="#features" className="text-sm text-slate-300 hover:underline">Explore features →</a>
</div>
</div>
);
}