import React from "react";


type Props = { title: React.ReactNode; subtitle: string };
export default function StatCard({ title, subtitle }: Props) {
return (
<div className="bg-slate-800/40 border border-slate-700 rounded-lg px-4 py-3 text-center min-w-[140px]">
<div className="text-2xl font-bold">{title}</div>
<div className="text-xs text-slate-400 mt-1">{subtitle}</div>
</div>
);
}