import { memo } from "react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { Message } from "./types";
import { LoaderDots } from "./LoaderDots";
import { MarkdownRenderer } from "./MarkdownRenderer";

interface ChatMessageProps {
  message: Message;
  isDark: boolean;
}

export const ChatMessage = memo(({ message, isDark }: ChatMessageProps) => (
  <motion.div
    className={cn(
      "flex items-end gap-3",
      message.sender === "you" ? "justify-end" : "justify-start"
    )}
    initial={{ opacity: 0, y: 10, scale: 0.98 }}
    animate={{ opacity: 1, y: 0, scale: 1 }}
    exit={{ opacity: 0, y: 16, scale: 0.9 }}
    transition={{ type: "spring", stiffness: 180, damping: 22 }}
    layout
    >
   {message.sender === "bot" && (
    <motion.div
    initial={{ scale: 0.8, opacity: 0 }}
    animate={{ scale: 1, opacity: 1 }}
    className="flex-none"
    whileHover={{ scale: 1.05 }}
    >
    <div className={cn(
      "h-8 w-8 rounded-full flex items-center justify-center text-xs font-medium overflow-hidden",
      isDark 
        ? "bg-gradient-to-br from-slate-600 to-slate-500 text-white/90" 
        : "bg-gradient-to-br from-blue-500 to-blue-600 text-white"
    )}>
      <img 
        src="/idpm_img.jpg" 
        alt="Bot Avatar"
        className="h-full w-full object-cover rounded-full"
      />
    </div>
    </motion.div>
  )}


    <div className="max-w-[78%]">
      <motion.div
        className={cn(
          "inline-block px-4 py-3 rounded-2xl leading-snug break-words shadow-sm",
          message.sender === "you"
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
        {message.isLoading ? (
          <LoaderDots isDark={isDark} />
        ) : (
          <MarkdownRenderer content={message.text} isDark={isDark} />
        )}
      </motion.div>
    </div>

    {message.sender === "you" && (
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
));

ChatMessage.displayName = "ChatMessage";
