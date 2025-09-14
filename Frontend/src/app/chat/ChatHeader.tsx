import { cn } from "@/lib/utils";
import { ThemeToggle } from "./ThemeToggle";

interface ChatHeaderProps {
  title: string;
  isDark: boolean;
  onToggleTheme: () => void;
  onNewChat: () => void;
}

export const ChatHeader = ({ title, isDark, onToggleTheme, onNewChat }: ChatHeaderProps) => (
  <header className={cn(
    "sticky top-0 z-50 flex items-center justify-between gap-4 px-6 py-4 border-b backdrop-blur-md",
    isDark ? "border-slate-700 bg-slate-800/95" : "border-slate-200 bg-slate-100/95"
  )}>
    <div className={cn("font-semibold text-lg truncate", isDark ? "text-slate-100" : "text-slate-900")}>
      {title}
    </div>
    <div className="flex items-center gap-3">
      <button
        className={cn(
          "hidden sm:inline-flex items-center gap-2 px-3 py-1 rounded-md text-sm transition-colors",
          isDark 
            ? "bg-slate-700/50 text-slate-200 hover:bg-slate-700" 
            : "bg-slate-200 text-slate-700 hover:bg-slate-300"
        )}
        onClick={onNewChat}
      >
        New chat
      </button>
      <ThemeToggle isDark={isDark} onToggle={onToggleTheme} />
    </div>
  </header>
);
