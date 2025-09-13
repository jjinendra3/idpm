import { motion } from "framer-motion";
import { Moon, Sun } from "lucide-react";
import { cn } from "@/lib/utils";

interface ThemeToggleProps {
  isDark: boolean;
  onToggle: () => void;
}

export const ThemeToggle = ({ isDark, onToggle }: ThemeToggleProps) => (
  <div className="flex items-center gap-2">
    <Sun className={cn("h-4 w-4", isDark ? "text-slate-400" : "text-amber-500")} />
    <motion.div
      className={cn(
        "relative w-12 h-6 rounded-full cursor-pointer transition-colors duration-300",
        isDark ? "bg-slate-700" : "bg-slate-300"
      )}
      onClick={onToggle}
      whileTap={{ scale: 0.95 }}
    >
      <motion.div
        className="absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow-sm"
        animate={{ x: isDark ? 24 : 0 }}
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
