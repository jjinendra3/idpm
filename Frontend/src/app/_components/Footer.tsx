import dayjs from "dayjs";
import React from "react";


export default function Footer() {
return (
<footer id="contact" className="w-full mt-auto border-t border-slate-800/60">
<div className="max-w-[1400px] mx-auto px-6 py-8 grid grid-cols-1 md:grid-cols-3 gap-6 text-sm text-slate-300">
<div>
<div className="font-semibold text-slate-100">IDPM</div>
<div className="mt-2">Middleware + AI for trustworthy pipelines.</div>
</div>


<div>
<div className="font-semibold text-slate-100">Resources</div>
<ul className="mt-2 space-y-2">
<li><a href="#" className="hover:underline">Docs</a></li>
<li><a href="#" className="hover:underline">GitHub</a></li>
<li><a href="#" className="hover:underline">API reference</a></li>
</ul>
</div>


<div>
<div className="font-semibold text-slate-100">Legal</div>
<ul className="mt-2 space-y-2">
<li><a href="#" className="hover:underline">Privacy</a></li>
<li><a href="#" className="hover:underline">Terms</a></li>
</ul>
</div>
</div>


<div className="max-w-[1400px] mx-auto px-6 pb-6 text-xs text-slate-500 flex items-center justify-between">
<div>© {dayjs().year()} IDPM. All rights reserved.</div>
<div className="flex items-center gap-3">
<a href="#" className="text-slate-400 hover:text-white">Twitter</a>
<a href="#" className="text-slate-400 hover:text-white">GitHub</a>
</div>
</div>
</footer>
);
}