"use client";

import Link from "next/link";
import React from "react";

export default function LandingPage() {
  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-b from-slate-900 via-slate-950 to-black text-slate-100">
      {/* NAV */}
      <nav className="w-full max-w-[1400px] mx-auto px-6 py-5 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="h-10 w-10 rounded-lg bg-gradient-to-br from-cyan-400 to-emerald-400 flex items-center justify-center font-bold text-slate-900 shadow-md">
            ID
          </div>
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

      {/* HERO */}
      <header className="w-full max-w-[1400px] mx-auto px-6 flex-1 flex items-center">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 py-12 w-full items-center">
          {/* Left: text */}
          <div className="space-y-6">
            <div className="inline-flex items-center gap-2 bg-slate-800/40 px-3 py-1 rounded-full text-xs text-cyan-300 w-max">
              <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none">
                <path d="M3 12h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M3 6h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M3 18h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
              Middleware + AI · Real-time
            </div>

            <h1 className="text-4xl md:text-5xl font-extrabold leading-tight">
              Intelligent Data Pipeline Manager
            </h1>

            <p className="text-slate-300 max-w-2xl text-lg">
              Bridge technical and non-technical stakeholders with automated data quality checks,
              anomaly detection, and natural-language conversational queries — all in one middleware layer.
              Real-time, modular, and production-ready.
            </p>

            <div className="flex flex-wrap gap-3 items-center">
              <Link href="/chat" className="inline-flex items-center gap-3 px-5 py-3 rounded-full bg-gradient-to-br from-cyan-500 to-teal-500 text-slate-900 font-semibold shadow-lg">
                Try the chat
              </Link>
              <a href="#features" className="text-sm text-slate-300 hover:underline">Explore features →</a>
            </div>

            {/* quick stats */}
            <div className="flex flex-wrap gap-4 mt-6">
              <div className="bg-slate-800/40 border border-slate-700 rounded-lg px-4 py-3 text-center min-w-[140px]">
                <div className="text-2xl font-bold">99.9%</div>
                <div className="text-xs text-slate-400 mt-1">Uptime & reliability</div>
              </div>
              <div className="bg-slate-800/40 border border-slate-700 rounded-lg px-4 py-3 text-center min-w-[140px]">
                <div className="text-2xl font-bold">Real-time</div>
                <div className="text-xs text-slate-400 mt-1">Data validation & alerts</div>
              </div>
              <div className="bg-slate-800/40 border border-slate-700 rounded-lg px-4 py-3 text-center min-w-[140px]">
                <div className="text-2xl font-bold">NLQ</div>
                <div className="text-xs text-slate-400 mt-1">Conversational queries</div>
              </div>
            </div>
          </div>

          {/* Right: mockup */}
          <div className="flex items-center justify-center">
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

              {/* decorative badges */}
              <div className="absolute -left-4 -top-4 bg-cyan-500/20 border border-cyan-300/10 text-cyan-300 px-2 py-1 rounded-md text-xs">MCP</div>
              <div className="absolute -right-4 -bottom-4 bg-emerald-400/10 border border-emerald-400/10 text-emerald-300 px-2 py-1 rounded-md text-xs">API • DB</div>
            </div>
          </div>
        </div>
      </header>

      {/* FEATURES */}
      <section id="features" className="w-full max-w-[1400px] mx-auto px-6 py-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-slate-800/40 border border-slate-700 rounded-xl p-6">
            <div className="text-cyan-300 font-semibold mb-2">Automated Quality</div>
            <h3 className="text-xl font-bold">Data quality checks</h3>
            <p className="text-slate-300 mt-3">Automatic validation pipelines that detect missing values, schema drift, and outliers with configurable rules and alerts.</p>
          </div>

          <div className="bg-slate-800/40 border border-slate-700 rounded-xl p-6">
            <div className="text-cyan-300 font-semibold mb-2">Anomaly Detection</div>
            <h3 className="text-xl font-bold">Real-time monitoring</h3>
            <p className="text-slate-300 mt-3">Continuous checks feed into models that detect anomalies and notify stakeholders immediately with remediation suggestions.</p>
          </div>

          <div className="bg-slate-800/40 border border-slate-700 rounded-xl p-6">
            <div className="text-cyan-300 font-semibold mb-2">Conversational</div>
            <h3 className="text-xl font-bold">Natural-language interface</h3>
            <p className="text-slate-300 mt-3">Let non-technical users query data, request reports, and get plain-language answers via a chat UI backed by the pipeline and metadata.</p>
          </div>
        </div>

        <div className="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="p-6 bg-slate-800/30 border border-slate-700 rounded-xl">
            <h4 className="font-semibold text-slate-100">Modular backend</h4>
            <p className="text-slate-300 mt-2 text-sm">Microservices for ingestion, validation, ML, and alerting — plug-and-play connectors (DBs, APIs, streaming).</p>
          </div>
          <div className="p-6 bg-slate-800/30 border border-slate-700 rounded-xl">
            <h4 className="font-semibold text-slate-100">Control protocols</h4>
            <p className="text-slate-300 mt-2 text-sm">Modern control protocols (MCP) for resilient orchestration and observability across environments.</p>
          </div>
          <div className="p-6 bg-slate-800/30 border border-slate-700 rounded-xl">
            <h4 className="font-semibold text-slate-100">Secure & auditable</h4>
            <p className="text-slate-300 mt-2 text-sm">Role-based access, audit logs, and traceability ensure governance and compliance for critical pipelines.</p>
          </div>
        </div>
      </section>

      {/* HOW IT WORKS */}
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

      {/* TESTIMONIALS + CTAs */}
      <section id="pricing" className="w-full max-w-[1400px] mx-auto px-6 py-12">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <div className="lg:col-span-2 space-y-4">
            <h3 className="text-2xl font-bold">Trusted by data teams</h3>
            <p className="text-slate-300">Teams use IDPM to turn noisy pipelines into actionable intelligence and understandable results for business users.</p>

            <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="p-4 bg-slate-800/40 border border-slate-700 rounded-lg">
                <div className="text-slate-100 font-semibold">Acme Analytics</div>
                <div className="text-sm text-slate-300 mt-2">"We reduced false positives by 40% and made monitoring accessible to product owners."</div>
                <div className="text-xs text-slate-400 mt-3">— Head of Data</div>
              </div>

              <div className="p-4 bg-slate-800/40 border border-slate-700 rounded-lg">
                <div className="text-slate-100 font-semibold">Nova Retail</div>
                <div className="text-sm text-slate-300 mt-2">"The chat interface made it trivial for managers to ask for daily health reports."</div>
                <div className="text-xs text-slate-400 mt-3">— SRE Lead</div>
              </div>
            </div>
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

      {/* FOOTER */}
      <footer id="contact" className="w-full mt-auto border-t border-slate-800/60">
        <div className="max-w-[1400px] mx-auto px-6 py-8 grid grid-cols-1 md:grid-cols-3 gap-6 text-sm text-slate-300">
          <div>
            <div className="font-semibold text-slate-100">IDPM</div>
            <div className="mt-2">Middleware + AI for trustworthy pipelines. Contact us at <a className="text-cyan-300 hover:underline" href="mailto:hello@idpm.example">hello@idpm.example</a></div>
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
          <div>© {new Date().getFullYear()} IDPM. All rights reserved.</div>
          <div className="flex items-center gap-3">
            <a href="#" className="text-slate-400 hover:text-white">Twitter</a>
            <a href="#" className="text-slate-400 hover:text-white">GitHub</a>
          </div>
        </div>
      </footer>
    </div>
  );
}