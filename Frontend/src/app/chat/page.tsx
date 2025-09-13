"use client";

import { useState, FormEvent } from "react";
import { cn } from "@/lib/utils";
import { AnimatePresence } from "framer-motion";
import { ChatHeader } from "./ChatHeader";
import { ChatMessage } from "./ChatMessage";
import { ChatInput } from "./ChatInput";
import { useChatLogic } from "./hooks/useChatLogic";
import { useScrollToBottom } from "./hooks/useScrollToBottom";

export default function ChatApp() {
  const [isDark, setIsDark] = useState(true);
  const { listRef, bottomRef, scrollToBottom, handleScroll } = useScrollToBottom();
  const { 
    messages, 
    input, 
    setInput, 
    sending, 
    sendMessage, 
    handleNewChat, 
    title 
  } = useChatLogic(scrollToBottom);

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    sendMessage(input);
  };

  const toggleTheme = () => setIsDark(!isDark);

  return (
    <div className={cn("min-h-screen w-full flex flex-col", isDark ? "bg-slate-900" : "bg-slate-50")}>
      <ChatHeader 
        title={title}
        isDark={isDark} 
        onToggleTheme={toggleTheme} 
        onNewChat={handleNewChat} 
      />

      <div
        ref={listRef}
        onScroll={handleScroll}
        className="flex-1 overflow-y-auto p-6 space-y-4 scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-700"
      >
        <AnimatePresence initial={false}>
          {messages.map((message) => (
            <ChatMessage key={message.id} message={message} isDark={isDark} />
          ))}
        </AnimatePresence>
        <div ref={bottomRef} className="h-1" />
      </div>

      <ChatInput
        value={input}
        onChange={setInput}
        onSubmit={handleSubmit}
        sending={sending}
        isDark={isDark}
      />
    </div>
  );
}
