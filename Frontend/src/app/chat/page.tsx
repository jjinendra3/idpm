"use client";

import { cn } from "@/lib/utils";
import dayjs from "dayjs";
import React, { useState, useRef, useEffect, FormEvent } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Moon, Sun } from "lucide-react";

type Message = {
  id: string;
  sender: "you" | "bot";
  text: string;
  time: string;
  isLoading?: boolean;
};

function nowTime() {
  return dayjs().format("HH:mm");
}

export default function ChatApp() {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: "m1",
      sender: "bot",
      text: "Hello! This is a local chat. Type a message and press Send.",
      time: nowTime(),
    },
  ]);
  const [input, setInput] = useState("");
  const [sending, setSending] = useState(false);

  const [settingsOpen, setSettingsOpen] = useState(false);
  const [isDark, setIsDark] = useState(true);

  const listRef = useRef<HTMLDivElement | null>(null);
  const bottomRef = useRef<HTMLDivElement | null>(null);
  const [shouldAutoScroll, setShouldAutoScroll] = useState(true);

 
  const checkIfAtBottom = () => {
    if (!listRef.current) return false;
    const { scrollTop, scrollHeight, clientHeight } = listRef.current;
    return scrollHeight - scrollTop - clientHeight < 50; 
  };

  const handleScroll = () => {
    setShouldAutoScroll(checkIfAtBottom());
  };

  const scrollToBottom = () => {
    if (shouldAutoScroll && bottomRef.current) {
      bottomRef.current.scrollIntoView({ behavior: "smooth" });
    }
  };


  useEffect(() => {
    const timer = setTimeout(() => {
      scrollToBottom();
    }, 100);
    
    return () => clearTimeout(timer);
  }, [messages, shouldAutoScroll]);

  const sendMessage = async (text: string) => {
    if (!text.trim()) return;
    setSending(true);

    const userMsg: Message = {
      id: String(Date.now()) + "-u",
      sender: "you",
      text: text.trim(),
      time: nowTime(),
    };

    setMessages((m) => [...m, userMsg]);
    setInput("");
    setShouldAutoScroll(true);

    const loadingBotMsg: Message = {
      id: String(Date.now()) + "-b-loading",
      sender: "bot",
      text: "",
      time: nowTime(),
      isLoading: true,
    };

    setMessages((m) => [...m, loadingBotMsg]);

    setTimeout(() => {

      setMessages((m) =>
        m.map((msg) =>
          msg.id === loadingBotMsg.id
            ? {
                ...msg,
                text: `Got your message: "${text.trim()}"`,
                isLoading: false,
              }
            : msg
        )
      );
      setSending(false);
    }, 1100);
  };

  const onSubmit = (e: FormEvent) => {
    e.preventDefault();
    sendMessage(input);
  };

  const LoaderDots = () => (
    <div className="flex space-x-1 p-2">
      {[0, 1, 2].map((i) => (
        <motion.span
          key={i}
          className="block w-2 h-2 rounded-full bg-slate-300"
          initial={{ opacity: 0.2, y: 0 }}
          animate={{ opacity: [0.2, 1, 0.2], y: [0, -3, 0] }}
          transition={{
            repeat: Infinity,
            duration: 1,
            delay: i * 0.2,
          }}
        />
      ))}
    </div>
  );

  const ThemeToggle = () => (
    <div className="flex items-center gap-2">
      <Sun className={cn("h-4 w-4", isDark ? "text-slate-400" : "text-amber-500")} />
      <motion.div
        className={cn(
          "relative w-12 h-6 rounded-full cursor-pointer transition-colors duration-300",
          isDark ? "bg-slate-700" : "bg-slate-300"
        )}
        onClick={() => setIsDark(!isDark)}
        whileTap={{ scale: 0.95 }}
      >
        <motion.div
          className="absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow-sm"
          animate={{
            x: isDark ? 24 : 0,
          }}
          transition={{
            type: "spring",
            stiffness: 500,
            damping: 30,
          }}
        />
      </motion.div>
      <Moon className={cn("h-4 w-4", isDark ? "text-slate-200" : "text-slate-400")} />
    </div>
  );

  return (
    <div className={cn("min-h-screen w-full flex flex-col", isDark ? "bg-slate-900" : "bg-gray-50")}>

      <header className={cn(
        "relative flex items-center justify-between gap-4 px-6 py-4 border-b backdrop-blur-sm",
        isDark ? "border-slate-700 bg-slate-800/60" : "border-blue-100 bg-blue-50/80"
      )}>
        <div>
          <div className={cn("font-semibold text-lg", isDark ? "text-slate-100" : "text-slate-800")}>
            ChatBot
          </div>
        </div>
        <div className="flex items-center gap-3">
          <button
            className={cn(
              "hidden sm:inline-flex items-center gap-2 px-3 py-1 rounded-md text-sm transition-colors",
              isDark 
                ? "bg-slate-700/50 text-slate-200 hover:bg-slate-700" 
                : "bg-blue-100 text-slate-700 hover:bg-blue-200"
            )}
            type="button"
            onClick={() => {
              setMessages([
                {
                  id: "m1",
                  sender: "bot",
                  text: "Hello! This is a local chat. Type a message and press Send.",
                  time: nowTime(),
                },
              ]);
              setInput("");
              setSending(false);
              setShouldAutoScroll(true);
            }}
          >
            New chat
          </button>
          <ThemeToggle />
        </div>
      </header>
 <div
        ref={listRef}
        onScroll={handleScroll}
        className="flex-1 overflow-y-auto p-6 space-y-4 scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-700"
      >
        <AnimatePresence initial={false}>
          {messages.map((m) => (
            <motion.div
              key={m.id}
              className={cn(
                "flex items-end gap-3",
                m.sender === "you" ? "justify-end" : "justify-start"
              )}
              initial={{ opacity: 0, y: 10, scale: 0.98 }}
              animate={{ opacity: 1, y: 0, scale: 1 }}
              exit={{ opacity: 0, y: 16, scale: 0.9 }}
              transition={{ type: "spring", stiffness: 180, damping: 22 }}
              layout
            >
              {m.sender === "bot" && (
                <motion.div
                  initial={{ scale: 0.8, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  className="flex-none"
                  whileHover={{ scale: 1.05 }}
                >
                  <div className={cn(
                    "h-8 w-8 rounded-full flex items-center justify-center text-xs font-medium",
                    isDark 
                      ? "bg-gradient-to-br from-slate-600 to-slate-500 text-white/90" 
                      : "bg-gradient-to-br from-blue-500 to-blue-600 text-white"
                  )}>
                    B
                  </div>
                </motion.div>
              )}

              <div className="max-w-[78%]">
                <motion.div
                  className={cn(
                    "inline-block px-4 py-3 rounded-2xl leading-snug break-words shadow-sm",
                    m.sender === "you"
                      ? isDark
                        ? "bg-gradient-to-br from-cyan-500 to-teal-600 text-white rounded-br-md"
                        : "bg-gradient-to-br from-blue-500 to-blue-600 text-white rounded-br-md"
                      : isDark 
                        ? "bg-slate-700/60 text-slate-100 border border-slate-700 rounded-bl-md"
                        : "bg-slate-50 text-slate-800 border border-slate-200 rounded-bl-md"
                  )}
                  layout
                  whileHover={{ scale: 1.02 }}
                >
                  {m.isLoading ? (
                    <LoaderDots />
                  ) : (
                    <div className="whitespace-pre-wrap text-sm">{m.text}</div>
                  )}
                </motion.div>
                <div
                  className={cn(
                    "mt-2 text-[11px] select-none",
                    m.sender === "you"
                      ? isDark ? "text-slate-300 text-right" : "text-slate-600 text-right"
                      : isDark ? "text-slate-400 text-left" : "text-slate-600 text-left"
                  )}
                >
                  {m.time}
                </div>
              </div>

              {m.sender === "you" && (
                <motion.div
                  initial={{ scale: 0.85, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  className="flex-none"
                  whileHover={{ scale: 1.04 }}
                >
                  <div className={cn(
                    "h-8 w-8 rounded-full flex items-center justify-center text-xs font-semibold",
                    isDark 
                      ? "bg-gradient-to-br from-cyan-400 to-cyan-600 text-slate-900/95"
                      : "bg-gradient-to-br from-blue-400 to-blue-500 text-white"
                  )}>
                    Y
                  </div>
                </motion.div>
              )}
            </motion.div>
          ))}
        </AnimatePresence>
        <div ref={bottomRef} className="h-1" />
      </div>

      <form
        onSubmit={onSubmit}
        className={cn(
          "px-6 py-4 border-t backdrop-blur-sm",
          isDark ? "border-slate-700 bg-slate-800/60" : "border-amber-200 bg-gradient-to-r from-blue-50/80 to-amber-50/80"
        )}
      >
        <div className="flex gap-3 items-center">
          <textarea
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type a message..."
            className={cn(
              "flex-1 min-h-[44px] max-h-32 resize-none rounded-full px-4 py-3 border focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all shadow-sm",
              isDark 
                ? "bg-slate-900/60 border-slate-700 text-slate-100 placeholder:text-slate-500"
                : "bg-blue-50/80 border-blue-200 text-slate-800 placeholder:text-slate-500"
            )}
            onKeyDown={(e) => {
              if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                sendMessage(input);
              }
            }}
          />
          <motion.button
            type="submit"
            disabled={sending}
            whileTap={{ scale: 0.97 }}
            className={cn(
              "inline-flex items-center gap-2 px-4 py-2 rounded-full font-medium shadow-lg disabled:opacity-60 disabled:cursor-not-allowed transition-all",
              isDark
                ? "bg-gradient-to-br from-cyan-500 to-teal-600 text-slate-900"
                : "bg-gradient-to-br from-blue-500 to-blue-600 text-white hover:from-blue-600 hover:to-blue-700"
            )}
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
                    stroke="currentColor"
                    strokeOpacity="0.25"
                    strokeWidth="4"
                  />
                  <path
                    d="M22 12a10 10 0 00-10-10"
                    stroke="currentColor"
                    strokeWidth="4"
                    strokeLinecap="round"
                  />
                </svg>
                Sending...
              </>
            ) : (
              "Send"
            )}
          </motion.button>
        </div>
      </form>
    </div>
  );
}
