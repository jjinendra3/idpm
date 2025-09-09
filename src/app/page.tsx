"use client";
import { cn } from "../lib/utils";

import React, { useState, useRef, useEffect, FormEvent } from "react";
import type{JSX} from 'react';

type Message = {
  id: string;
  sender: "you" | "bot";
  text: string;
  time: string;
};

function nowTime() {
  const d = new Date();
  return d.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" });
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
    <div className="max-w-xl mx-auto mt-8 bg-white rounded-2xl shadow-lg overflow-hidden border" style={{ height: "600px", display: "flex", flexDirection: "column" }}>
      <header className="px-4 py-3 border-b">
        <div className="font-semibold text-lg">Local Chat</div>
      </header>

      <div ref={listRef} className="flex-1 p-4 overflow-y-auto" style={{ background: "#f7fafc" }}>
       {messages.map((m) => (
  <div
    key={m.id}
    className={cn(
      "mb-3 flex",
      m.sender === "you" ? "justify-end" : "justify-start"
    )}
  >
    <div style={{ maxWidth: "78%" }}>
      <div
        className={cn(
          "inline-block px-4 py-2 rounded-lg",
          m.sender === "you"
            ? "bg-blue-600 text-white"
            : "bg-white text-gray-900 border"
        )}
      >
        <div style={{ whiteSpace: "pre-wrap" }}>{m.text}</div>
      </div>

      <div
        className={cn(
          "text-xs mt-1",
          m.sender === "you"
            ? "text-right text-gray-300"
            : "text-left text-gray-500"
        )}
      >
        {m.time}
      </div>
    </div>
  </div>
))}
      </div>

      <form onSubmit={onSubmit} className="p-4 border-t bg-white" style={{ display: "flex", gap: "8px" }}>
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Type a message..."
          className="flex-1 px-4 py-2 rounded-xl border focus:outline-none"
          onKeyDown={(e) => {
            if (e.key === "Enter" && !e.shiftKey) {
              e.preventDefault();
              sendMessage(input);
            }
          }}
        />
        <button type="submit" className="px-4 py-2 rounded-xl bg-blue-600 text-white font-medium disabled:opacity-60" disabled={sending}>
          {sending ? "Sending..." : "Send"}
        </button>
      </form>
    </div>
  );
}

