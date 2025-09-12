"use client";
import React,{useState} from "react";
import Nav from "./_components/Nav";
import Hero from "./_components/Hero";
import StatCard from "./_components/StatCard";
import ConsoleMock from "./_components/ConsoleMock";
import FeaturesGrid from "./_components/FeaturesGrid";
import HowSection from "./_components/HowSection";
import PricingPanel from "./_components/PricingPanel";
import Footer from "./_components/Footer";
import ChatPrepModal from "./_components/ChatPrepModal";


export default function LandingPage() {
  const [open, setOpen] = useState(false);


function openChatModal() {
setOpen(true);
}

  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-b from-slate-900 via-slate-950 to-black text-slate-100">
      <Nav onOpenChat={openChatModal} />
 
      <ChatPrepModal open={open} onOpenChange={setOpen} />

      <header className="w-full max-w-[1400px] mx-auto px-6 flex-1 flex items-center">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 py-12 w-full items-center">
          <div className="space-y-6">
            <Hero onOpenChat={openChatModal} />

            <h1 className="text-4xl md:text-5xl font-extrabold leading-tight">Intelligent Data Pipeline Manager</h1>
            <p className="text-slate-300 max-w-2xl text-lg">Bridge technical and non-technical stakeholders with automated data quality checks, anomaly detection, and natural-language conversational queries — all in one middleware layer. Real-time, modular, and production-ready.</p>

            <div className="flex flex-wrap gap-4 mt-6">
              <StatCard title="99.9%" subtitle="Uptime & reliability" />
              <StatCard title="Real-time" subtitle="Data validation & alerts" />
              <StatCard title="NLQ" subtitle="Conversational queries" />
            </div>
          </div>


          <div className="flex items-center justify-center">
            <ConsoleMock />
          </div>
        </div>
      </header>


      <FeaturesGrid />
      <HowSection />
      <PricingPanel onOpenChat={openChatModal}/>
      <Footer />
    </div>
  );
}