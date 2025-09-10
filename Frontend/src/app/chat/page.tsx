"use client";
import { cn } from "@/lib/utils";
import dayjs from 'dayjs';
import React, { useState, useRef, useEffect, FormEvent } from "react";
import type { JSX } from 'react';

type Message = {
  id: string;
  sender: "you" | "bot";
  text: string;
  time: string;
};

function nowTime() {
  return dayjs().format("HH:mm");
}

export default function ChatApp(): JSX.Element {
  const [messages, setMessages] = useState<Message[]>([
    { id: "m1", sender: "bot", text: "Hello! This is a local chat. Type a message and press Send.", time: nowTime() },
  ]);
  const [input, setInput] = useState("");
  const [sending, setSending] = useState(false);
  const listRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    if (listRef.current) {
      listRef.current.scrollTop = listRef.current.scrollHeight;
    }
  }, [messages]);

  const sendMessage = async (text: string) => {
    if (!text.trim()) return;
    setSending(true);

    const userMsg: Message = { id: String(Date.now()) + "-u", sender: "you", text: text.trim(), time: nowTime() };
    setMessages((m) => [...m, userMsg]);
    setInput("");

    setTimeout(() => {
      const botMsg: Message = { id: String(Date.now()) + "-b", sender: "bot", text: `Got your message: "${text.trim()}"`, time: nowTime() };
      setMessages((m) => [...m, botMsg]);
      setSending(false);
    }, 600);
  };

  const onSubmit = (e: FormEvent) => {
    e.preventDefault();
    sendMessage(input);
  };

  return (
    <div className="min-h-screen w-full flex flex-col bg-gradient-to-b from-slate-900 via-slate-950 to-black">
     
      <header className="flex items-center justify-between gap-4 px-6 py-4 border-b border-slate-700 bg-slate-800/60 backdrop-blur-sm">
        <div>
          <div className="text-slate-100 font-semibold text-lg">ChatBot</div>
        </div>
        <div className="flex items-center gap-3">
          <button
            className="hidden sm:inline-flex items-center gap-2 px-3 py-1 rounded-md bg-slate-700/50 text-slate-200 text-sm hover:bg-slate-700"
            type="button"
            onClick={() => {
              setMessages([
                { id: "m1", sender: "bot", text: "Hello! This is a local chat. Type a message and press Send.", time: nowTime() },
              ]);
              setInput("");
              setSending(false);
            }}
          >
            New chat
          </button>
          <div className="text-slate-400 text-sm">v1.0</div>
        </div>
      </header>


      <div
        ref={listRef}
        className="flex-1 overflow-y-auto p-6 space-y-4 scrollbar-thin scrollbar-thumb-slate-700 scrollbar-track-slate-900"
      >
        {messages.map((m) => (
          <div
            key={m.id}
            className={cn(
              "flex items-end gap-3",
              m.sender === "you" ? "justify-end" : "justify-start"
            )}
          >
            {m.sender === "bot" && (
              <div className="flex-none">
                <div className="h-8 w-8 rounded-full bg-gradient-to-br from-slate-600 to-slate-500 flex items-center justify-center text-xs text-white/90 font-medium">
                  B
                </div>
              </div>
            )}

            <div className="max-w-[78%]">
              <div
                className={cn(
                  "inline-block px-4 py-3 rounded-2xl leading-snug break-words",
                  m.sender === "you"
                    ? "bg-gradient-to-br from-cyan-500 to-teal-600 text-white rounded-br-md shadow-md"
                    : "bg-slate-700/60 text-slate-100 border border-slate-700 rounded-bl-md"
                )}
              >
                <div className="whitespace-pre-wrap text-sm">{m.text}</div>
              </div>
              <div
                className={cn(
                  "mt-2 text-[11px] select-none",
                  m.sender === "you"
                    ? "text-slate-300 text-right"
                    : "text-slate-400 text-left"
                )}
              >
                {m.time}
              </div>
            </div>

            {m.sender === "you" && (
              <div className="flex-none">
                <div className="h-8 w-8 rounded-full bg-gradient-to-br from-cyan-400 to-cyan-600 flex items-center justify-center text-xs text-slate-900/95 font-semibold">
                  Y
                </div>
              </div>
            )}
          </div>
        ))}
      </div>

      <form
        onSubmit={onSubmit}
        className="px-6 py-4 border-t border-slate-700 bg-slate-800/60 backdrop-blur-sm"
      >
        <div className="flex gap-3 items-center">
          <textarea
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type a message..."
            className="flex-1 min-h-[44px] max-h-32 resize-none rounded-full px-4 py-3 bg-slate-900/60 border border-slate-700 text-slate-100 placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-transparent transition-shadow"
            onKeyDown={(e) => {
              if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                sendMessage(input);
              }
            }}
          />
          <button
            type="submit"
            disabled={sending}
            className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-br from-cyan-500 to-teal-600 text-slate-900 font-medium shadow-lg disabled:opacity-60 disabled:cursor-not-allowed"
          >
            {sending ? (
              <>
                <svg
                  className="w-4 h-4 animate-spin"
                  viewBox="0 0 24 24"
                  fill="none"
                >
                  <circle
                    cx="12"
                    cy="12"
                    r="10"
                    stroke="white"
                    strokeOpacity="0.15"
                    strokeWidth="4"
                  />
                  <path
                    d="M22 12a10 10 0 00-10-10"
                    stroke="white"
                    strokeWidth="4"
                    strokeLinecap="round"
                  />
                </svg>
                Sending...
              </>
            ) : (
              "Send"
            )}
          </button>
        </div>
      </form>
    </div>
  );
}