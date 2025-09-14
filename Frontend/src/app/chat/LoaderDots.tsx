import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

interface LoaderDotsProps {
  isDark: boolean;
}

export const LoaderDots = ({ isDark }: LoaderDotsProps) => (
  <div className="flex space-x-1 p-2">
    {[0, 1, 2].map((i) => (
      <motion.span
        key={i}
        className={cn(
          "block w-2 h-2 rounded-full",
          isDark ? "bg-slate-300" : "bg-slate-600"
        )}
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
