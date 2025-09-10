import React from "react";


export default function ConsoleMock() {
    return (
        <div className="relative w-full max-w-md">
            <div className="rounded-2xl bg-gradient-to-br from-slate-800/70 to-slate-900 border border-slate-700 shadow-xl p-4">
                <div className="flex items-center justify-between pb-3 border-b border-slate-700">
                    <div className="text-sm font-medium">IDPM Console</div>
                    <div className="text-xs text-slate-400">connected</div>
                </div>


                <div className="mt-4 space-y-3">
                    <div className="text-xs text-slate-400">Live alerts</div>
                    <div className="bg-slate-800/60 border border-slate-700 rounded-lg p-3 flex flex-col gap-2">
                        <div className="flex items-center justify-between text-sm">
                            <div className="text-slate-200">Anomaly detected — sales_data</div>
                            <div className="text-xs text-amber-400">HIGH</div>
                        </div>
                        <div className="text-xs text-slate-400">Rule: missing values is greater than 10%</div>
                    </div>


                    <div className="text-xs text-slate-400 pt-2">Conversational query</div>
                    <div className="bg-slate-900/50 border border-slate-700 rounded-lg p-3">
                        <div className="text-sm text-slate-100">User: Show last 24h anomalies</div>
                        <div className="text-xs text-slate-400 mt-2">Bot: 3 anomalies — sales_data, inventory, logs</div>
                    </div>
                </div>


                <div className="mt-4 flex items-center justify-between text-xs text-slate-400">
                    <div>CPU 28% • Memory 62%</div>
                    <div>Last check: 30s</div>
                </div>
            </div>


            <div className="absolute -left-4 -top-4 bg-cyan-500/20 border border-cyan-300/10 text-cyan-300 px-2 py-1 rounded-md text-xs">MCP</div>
            <div className="absolute -right-4 -bottom-4 bg-emerald-400/10 border border-emerald-400/10 text-emerald-300 px-2 py-1 rounded-md text-xs">API • DB</div>
        </div>
    );
}