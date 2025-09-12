"use client";

import { cn } from "@/lib/utils";
import dayjs from "dayjs";
import React, { useState, useRef, useEffect, FormEvent } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { RiMoonClearFill, RiSunFill } from "react-icons/ri";

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

const themes = [
  { name: "Dark", value: "dark", class: "bg-gradient-to-b from-slate-900 via-slate-950 to-black" },
  { name: "Light", value: "light", class: "bg-gradient-to-b from-slate-100 via-slate-200 to-white" },
  { name: "Ocean", value: "ocean", class: "bg-gradient-to-br from-cyan-600 via-blue-700 to-teal-900" },
  { name: "Violet", value: "violet", class: "bg-gradient-to-br from-violet-700 via-purple-800 to-fuchsia-900" },
  { name: "Rainbow", value: "rainbow", class: "bg-gradient-to-r from-pink-500 via-yellow-500 via-green-400 via-blue-400 to-purple-500" },
  { name: "Sunset", value: "sunset", class: "bg-gradient-to-br from-orange-400 via-pink-500 to-red-600" },
  { name: "Aqua", value: "aqua", class: "bg-gradient-to-bl from-teal-300 via-cyan-400 to-blue-500" },
  { name: "Rose", value: "rose", class: "bg-gradient-to-tr from-rose-400 via-fuchsia-500 to-pink-600" },
];

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

  const [theme, setTheme] = useState("dark");
  const [settingsOpen, setSettingsOpen] = useState(false);

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

  const ThemeSwitcher = () => {
    const isDark = theme === "dark";
    return (
      <motion.button
        whileTap={{ scale: 0.92 }}
        className={cn(
          "flex items-center justify-center w-10 h-10 rounded-full transition-colors",
          isDark ? "bg-slate-700/70" : "bg-slate-300"
        )}
        onClick={() =>
          setTheme((prev) => (prev === "dark" ? "light" : "dark"))
        }
        title="Toggle dark/light"
      >
        <motion.div
          key={isDark ? "moon" : "sun"}
          initial={{ rotate: 180, opacity: 0 }}
          animate={{ rotate: 0, opacity: 1 }}
          exit={{ rotate: -180, opacity: 0 }}
          transition={{ type: "spring", stiffness: 300, damping: 20 }}
        >
          {isDark ? (
            <RiMoonClearFill className="h-6 w-6 text-slate-200" />
          ) : (
            <RiSunFill className="h-6 w-6 text-yellow-400" />
          )}
        </motion.div>
      </motion.button>
    );
  };

  const SettingsDropdown = () => (
    <AnimatePresence>
      {settingsOpen && (
        <motion.div
          initial={{ opacity: 0, y: -15, scale: 0.95 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={{ opacity: 0, y: -12, scale: 0.98 }}
          transition={{ duration: 0.18 }}
          className="absolute right-4 top-14 z-50 min-w-[200px] rounded-md bg-slate-800/95 shadow-lg border border-slate-700"
        >
          <div className="py-2">
            <div className="px-4 py-2 text-xs text-slate-400">Themes</div>
            {themes.map((t) => (
              <button
                key={t.value}
                onClick={() => {
                  setTheme(t.value);
                  setSettingsOpen(false);
                }}
                className={cn(
                  "block w-full text-left px-4 py-2 text-sm rounded hover:bg-slate-700 text-slate-100 transition",
                  t.value === theme && "bg-cyan-600/40 font-semibold"
                )}
              >
                {t.name}
              </button>
            ))}
            <hr className="my-2 border-slate-700" />
            <ThemeSwitcher />
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );

  return (
    <div
      className={cn(
        "min-h-screen w-full flex flex-col transition-all duration-700",
        themes.find((t) => t.value === theme)?.class
      )}
    >
      <header className="relative flex items-center justify-between gap-4 px-6 py-4 border-b border-slate-700 bg-slate-800/60 backdrop-blur-sm">
        <div>
          <div className="text-slate-100 font-semibold text-lg">ChatBot</div>
        </div>
        <div className="flex items-center gap-3">
          <button
            className="hidden sm:inline-flex items-center gap-2 px-3 py-1 rounded-md bg-slate-700/50 text-slate-200 text-sm hover:bg-slate-700"
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
          <div className="relative">
            <motion.button
              whileTap={{ scale: 0.93 }}
              className="rounded-full p-2 hover:bg-slate-700 bg-slate-800 text-slate-100"
              title="Settings"
              onClick={() => setSettingsOpen((v) => !v)}
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <motion.path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M12 6v6m0 0v6m0-6h6m-6 0H6"
                  initial={{ rotate: 45 }}
                  animate={{ rotate: settingsOpen ? 0 : 45 }}
                  transition={{ duration: 0.23 }}
                />
              </svg>
            </motion.button>
            <SettingsDropdown />
          </div>
        </div>
      </header>

      <div
        ref={listRef}
        onScroll={handleScroll}
        className="flex-1 overflow-y-auto p-6 space-y-4 scrollbar-thin scrollbar-thumb-slate-700 scrollbar-track-slate-900"
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
                  <div className="h-8 w-8 rounded-full bg-gradient-to-br from-slate-600 to-slate-500 flex items-center justify-center text-xs text-white/90 font-medium">
                    B
                  </div>
                </motion.div>
              )}

              <div className="max-w-[78%]">
                <motion.div
                  className={cn(
                    "inline-block px-4 py-3 rounded-2xl leading-snug break-words",
                    m.sender === "you"
                      ? "bg-gradient-to-br from-cyan-500 to-teal-600 text-white rounded-br-md shadow-md"
                      : "bg-slate-700/60 text-slate-100 border border-slate-700 rounded-bl-md"
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
                      ? "text-slate-300 text-right"
                      : "text-slate-400 text-left"
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
                  <div className="h-8 w-8 rounded-full bg-gradient-to-br from-cyan-400 to-cyan-600 flex items-center justify-center text-xs text-slate-900/95 font-semibold">
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
          <motion.button
            type="submit"
            disabled={sending}
            whileTap={{ scale: 0.97 }}
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
          </motion.button>
        </div>
      </form>
    </div>
  );
}
