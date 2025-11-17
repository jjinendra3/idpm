"use client";

import { useState } from "react";

interface ChatInputProps {
  value: string;
  onChange: (value: string) => void;
  onSubmit: (e: React.FormEvent) => void;
  sending: boolean;
  isDark: boolean;
  listening: boolean;
  onMicClick: () => void;
  onCancelMic: () => void;
}

export const ChatInput = ({
  value,
  onChange,
  onSubmit,
  sending,
  isDark,
  listening,
  onMicClick,
  onCancelMic,
}: ChatInputProps) => {
  const [focused, setFocused] = useState(false);

  return (
    <form
      onSubmit={onSubmit}
      className={`flex items-center space-x-3 p-4 border-t ${
        isDark ? "bg-slate-800 border-slate-700" : "bg-white border-slate-200"
      }`}
    >
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        className={`flex-1 p-3 rounded-lg outline-none transition-all ${
          isDark
            ? "bg-slate-700 text-white placeholder:text-slate-400"
            : "bg-slate-100 text-slate-900 placeholder:text-slate-500"
        } ${focused ? "ring-2 ring-blue-500" : ""}`}
        placeholder={listening ? "Listening..." : "Type a message..."}
        disabled={sending || listening}
      />

      <button
        type="button"
        onClick={listening ? onCancelMic : onMicClick}
        className={`p-3 rounded-full transition ${
          listening
            ? "bg-red-500 text-white hover:bg-red-600"
            : isDark
            ? "bg-slate-700 hover:bg-slate-600 text-white"
            : "bg-slate-200 hover:bg-slate-300 text-slate-900"
        }`}
        disabled={sending}
      >
        {listening ? "❌" : "🎤"}
      </button>

      <button
        type="submit"
        disabled={sending || !value.trim() || listening}
        className={`p-3 rounded-lg font-semibold ${
          sending
            ? "bg-gray-400 text-white"
            : "bg-blue-600 hover:bg-blue-700 text-white"
        }`}
      >
        {sending ? "Sending..." : "Send"}
      </button>
    </form>
  );
};
