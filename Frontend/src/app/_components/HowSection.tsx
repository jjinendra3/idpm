import React from "react";


export default function HowSection() {
    return (
        <section id="how" className="w-full max-w-[1400px] mx-auto px-6 py-12">
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
                <div className="lg:col-span-2">
                    <h3 className="text-2xl font-bold">How IDPM works</h3>
                    <p className="text-slate-300 mt-3 max-w-2xl">IDPM connects data sources, runs configurable validations and ML models in the pipeline, exposes insights to dashboards and a conversational interface, and triggers alerts/automations via integrations.</p>


                    <div className="mt-6 space-y-4">
                        <div className="flex gap-4 items-start">
                            <div className="h-10 w-10 rounded-lg bg-cyan-600/20 flex items-center justify-center text-cyan-300 font-semibold">1</div>
                            <div>
                                <div className="font-semibold">Connect & ingest</div>
                                <div className="text-sm text-slate-300 mt-1">Connect databases, APIs, and streams using secure connectors — map schemas and ingestion cadence.</div>
                            </div>
                        </div>


                        <div className="flex gap-4 items-start">
                            <div className="h-10 w-10 rounded-lg bg-cyan-600/20 flex items-center justify-center text-cyan-300 font-semibold">2</div>
                            <div>
                                <div className="font-semibold">Validate & detect</div>
                                <div className="text-sm text-slate-300 mt-1">Run validation rules and ML detectors in near real-time to find anomalies and quality regressions.</div>
                            </div>
                        </div>


                        <div className="flex gap-4 items-start">
                            <div className="h-10 w-10 rounded-lg bg-cyan-600/20 flex items-center justify-center text-cyan-300 font-semibold">3</div>
                            <div>
                                <div className="font-semibold">Explain & act</div>
                                <div className="text-sm text-slate-300 mt-1">Provide plain-language explanations, remediation steps, and let users trigger automations or chat with the data.</div>
                            </div>
                        </div>
                    </div>
                </div>


                <aside className="bg-slate-800/30 border border-slate-700 p-6 rounded-xl">
                    <h4 className="font-semibold">Integrations</h4>
                    <ul className="mt-3 text-sm text-slate-300 space-y-2">
                        <li>Postgres / MySQL / Snowflake</li>
                        <li>REST & GraphQL APIs</li>
                        <li>Prometheus / Grafana</li>
                        <li>Slack / Email alerts</li>
                        <li>Custom webhooks & MCP</li>
                    </ul>
                </aside>
            </div>
        </section>
    );
}