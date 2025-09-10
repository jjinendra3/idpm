import Link from "next/link";
import React from "react";


export default function Nav() {
return (
<nav className="w-full max-w-[1400px] mx-auto px-6 py-5 flex items-center justify-between">
<div className="flex items-center gap-3">
<div className="h-10 w-10 rounded-lg bg-gradient-to-br from-cyan-400 to-emerald-400 flex items-center justify-center font-bold text-slate-900 shadow-md">ID</div>
<div>
<div className="font-semibold text-lg">IDPM</div>
<div className="text-xs text-slate-400 -mt-1">Intelligent Data Pipeline Manager</div>
</div>
</div>


<div className="hidden md:flex items-center gap-6 text-sm">
<a href="#features" className="hover:text-white/90">Features</a>
<a href="#how" className="hover:text-white/90">How it works</a>
<a href="#pricing" className="hover:text-white/90">Plans</a>
<a href="#contact" className="hover:text-white/90">Contact</a>


<Link href="/chat" className="ml-4 inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-br from-cyan-500 to-teal-500 text-slate-900 font-semibold shadow-lg">
Try chat
</Link>
</div>


<div className="md:hidden">
<Link href="/chat" className="inline-flex items-center px-3 py-1.5 rounded-full bg-cyan-500 text-slate-900 text-sm font-medium">Chat</Link>
</div>
</nav>
);
}