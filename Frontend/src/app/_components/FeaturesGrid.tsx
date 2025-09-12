import React from "react";

export default function FeaturesGrid() {
  return (
    <section id="features" className="w-full max-w-[1400px] mx-auto px-6 py-12">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-slate-800/40 border border-slate-700 rounded-xl p-6">
          <div className="text-cyan-300 font-semibold mb-2">
            Automated Quality
          </div>
          <h3 className="text-xl font-bold">Data quality checks</h3>
          <p className="text-slate-300 mt-3">
            Automatic validation pipelines that detect missing values, schema
            drift, and outliers with configurable rules and alerts.
          </p>
        </div>

        <div className="bg-slate-800/40 border border-slate-700 rounded-xl p-6">
          <div className="text-cyan-300 font-semibold mb-2">
            Anomaly Detection
          </div>
          <h3 className="text-xl font-bold">Real-time monitoring</h3>
          <p className="text-slate-300 mt-3">
            Continuous checks feed into models that detect anomalies and notify
            stakeholders immediately with remediation suggestions.
          </p>
        </div>

        <div className="bg-slate-800/40 border border-slate-700 rounded-xl p-6">
          <div className="text-cyan-300 font-semibold mb-2">Conversational</div>
          <h3 className="text-xl font-bold">Natural-language interface</h3>
          <p className="text-slate-300 mt-3">
            Let non-technical users query data, request reports, and get
            plain-language answers via a chat UI backed by the pipeline and
            metadata.
          </p>
        </div>
      </div>

      <div className="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="p-6 bg-slate-800/30 border border-slate-700 rounded-xl">
          <h4 className="font-semibold text-slate-100">Modular backend</h4>
          <p className="text-slate-300 mt-2 text-sm">
            Microservices for ingestion, validation, ML, and alerting —
            plug-and-play connectors (DBs, APIs, streaming).
          </p>
        </div>
        <div className="p-6 bg-slate-800/30 border border-slate-700 rounded-xl">
          <h4 className="font-semibold text-slate-100">Control protocols</h4>
          <p className="text-slate-300 mt-2 text-sm">
            Modern control protocols (MCP) for resilient orchestration and
            observability across environments.
          </p>
        </div>
        <div className="p-6 bg-slate-800/30 border border-slate-700 rounded-xl">
          <h4 className="font-semibold text-slate-100">Secure & auditable</h4>
          <p className="text-slate-300 mt-2 text-sm">
            Role-based access, audit logs, and traceability ensure governance
            and compliance for critical pipelines.
          </p>
        </div>
      </div>
    </section>
  );
}
