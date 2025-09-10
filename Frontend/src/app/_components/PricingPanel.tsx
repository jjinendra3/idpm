import Link from "next/link";
import React from "react";
import Testimonials from "./Testimonials";


export default function PricingPanel() {
return (
<section id="pricing" className="w-full max-w-[1400px] mx-auto px-6 py-12">
<div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
<div className="lg:col-span-2 space-y-4">
<h3 className="text-2xl font-bold">Trusted by data teams</h3>
<p className="text-slate-300">Teams use IDPM to turn noisy pipelines into actionable intelligence and understandable results for business users.</p>


<Testimonials />
</div>


<div className="p-6 bg-gradient-to-br from-cyan-600/10 to-teal-500/6 border border-slate-700 rounded-xl">
<div className="text-lg font-semibold">Get started</div>
<p className="text-slate-300 text-sm mt-2">Try IDPM locally or deploy a demo to your environment. Includes connectors, pipeline templates, and conversational UI.</p>
<div className="mt-4 flex flex-col gap-3">
<Link href="/chat" className="inline-flex items-center justify-center px-4 py-2 rounded-full bg-cyan-500 text-slate-900 font-semibold">Try chat</Link>
<a href="#contact" className="text-sm text-slate-300 text-center">Request a demo</a>
</div>
<div className="mt-6 text-xs text-slate-400">No credit card • Self-host or cloud</div>
</div>
</div>
</section>
);
}