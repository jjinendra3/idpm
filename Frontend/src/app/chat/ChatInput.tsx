"use client";

import { useState, useEffect } from "react";

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

  const [imagePreview, setImagePreview] = useState<string | null>(null);

  useEffect(() => {
    const detectImage = async () => {
      if (!value.trim()) {
        setImagePreview(null);
        return;
      }

      const urlMatch = value.match(/https?:\/\/\S+/);
      if (!urlMatch) {
        setImagePreview(null);
        return;
      }

      const url = urlMatch[0];

      try {
 
        const response = await fetch(url, { method: "HEAD" });

        const contentType = response.headers.get("Content-Type");

        if (contentType && contentType.startsWith("image/")) {
          setImagePreview(url);
        } else {
          setImagePreview(null);
        }
      } catch {
        setImagePreview(null);
      }
    };

    detectImage();
  }, [value]);

  return (
    <form
      onSubmit={onSubmit}
      className={`flex items-center space-x-3 p-4 border-t ${
        isDark ? "bg-slate-800 border-slate-700" : "bg-white border-slate-200"
      }`}
    >

      {imagePreview && (
        <div className="relative">
          <div className="w-20 h-20 rounded-md overflow-hidden border border-slate-400">
            <img src={imagePreview} className="w-full h-full object-cover" />
          </div>

          <button
            type="button"
            onClick={() => onChange("")}
            className="absolute top-0 right-0 translate-x-2 -translate-y-2 
                       bg-red-600 text-white text-xs rounded-full w-5 h-5
                       flex items-center justify-center shadow"
          >
            ✕
          </button>
        </div>
      )}

      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={listening ? "Listening..." : "Type a message..."}
        disabled={sending || listening}
        className={`flex-1 p-3 rounded-lg outline-none transition-all ${
          isDark
            ? "bg-slate-700 text-white placeholder:text-slate-400"
            : "bg-slate-100 text-slate-900 placeholder:text-slate-500"
        }`}
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
