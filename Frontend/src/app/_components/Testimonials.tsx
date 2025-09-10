import React from "react";


export default function Testimonials() {
    return (
        <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="p-4 bg-slate-800/40 border border-slate-700 rounded-lg">
                <div className="text-slate-100 font-semibold">Acme Analytics</div>
                <div className="text-sm text-slate-300 mt-2">&quot;We reduced false positives by 40% and made monitoring accessible to product owners.&quot;</div>
                <div className="text-xs text-slate-400 mt-3">— Head of Data</div>
            </div>


            <div className="p-4 bg-slate-800/40 border border-slate-700 rounded-lg">
                <div className="text-slate-100 font-semibold">Nova Retail</div>
                <div className="text-sm text-slate-300 mt-2">&quot;The chat interface made it trivial for managers to ask for daily health reports.&quot;</div>
                <div className="text-xs text-slate-400 mt-3">— SRE Lead</div>
            </div>
        </div>
    );
}