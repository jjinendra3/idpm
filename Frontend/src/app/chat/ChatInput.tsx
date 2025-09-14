import { FormEvent } from "react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { Loader2 } from "lucide-react";

interface ChatInputProps {
  value: string;
  onChange: (value: string) => void;
  onSubmit: (e: FormEvent) => void;
  sending: boolean;
  isDark: boolean;
}

export const ChatInput = ({ value, onChange, onSubmit, sending, isDark }: ChatInputProps) => {
  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      onSubmit(e as unknown as FormEvent);
    }
  };

  return (
    <form
      onSubmit={onSubmit}
      className={cn(
        "sticky bottom-0 z-40 px-6 py-4 border-t backdrop-blur-md",
        isDark ? "border-slate-700 bg-slate-800/95" : "border-slate-200 bg-slate-100/95"
      )}
    >
      <div className="flex gap-3 items-center">
        <textarea
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder="Type a message with **markdown** support..."
          className={cn(
            "flex-1 min-h-[44px] max-h-32 resize-none rounded-full px-4 py-3 border focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all shadow-sm",
            isDark 
              ? "bg-slate-900/60 border-slate-700 text-slate-100 placeholder:text-slate-500"
              : "bg-white border-slate-300 text-slate-800 placeholder:text-slate-500"
          )}
          onKeyDown={handleKeyDown}
          disabled={sending}
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
              <Loader2 className="w-4 h-4 animate-spin" />
              Sending...
            </>
          ) : (
            "Send"
          )}
        </motion.button>
      </div>
    </form>
  );
};
