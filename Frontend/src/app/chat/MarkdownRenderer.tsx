import ReactMarkdown from "react-markdown";
import { cn } from "@/lib/utils";
import type { Components } from "react-markdown";
import { MarkdownComponentProps, CodeComponentProps, LinkComponentProps } from "./types";

interface MarkdownRendererProps {
  content: string;
  isDark: boolean;
}

export const MarkdownRenderer = ({ content, isDark }: MarkdownRendererProps) => {
  const components: Components = {
    h1: ({ children }) => <h1 className="text-lg font-bold mb-2 mt-1">{children}</h1>,
    h2: ({ children }) => <h2 className="text-base font-semibold mb-1 mt-1">{children}</h2>,
    h3: ({ children }) => <h3 className="text-sm font-medium mb-1">{children}</h3>,
    p: ({ children }) => <p className="mb-2 last:mb-0">{children}</p>,
    strong: ({ children }) => <strong className="font-semibold">{children}</strong>,
    em: ({ children }) => <em className="italic">{children}</em>,

    code: ({ children, className, ...props }) => {
  const isInline = !className; 
  return isInline ? (
    <code
      className={cn(
        "px-1 py-0.5 rounded text-xs font-mono",
        isDark ? "bg-slate-800 text-cyan-300" : "bg-slate-200 text-blue-600"
      )}
      {...props}
    >
      {children}
    </code>
  ) : (
    <code
      className={cn(
        "block p-3 rounded-md text-xs font-mono overflow-x-auto my-2",
        isDark ? "bg-slate-800 text-cyan-300" : "bg-slate-200 text-blue-600",
        className
      )}
      {...props}
    >
      {children}
    </code>
  );
},
    pre: ({ children }) => (
      <pre
        className={cn(
          "p-3 rounded-md text-xs font-mono overflow-x-auto my-2",
          isDark ? "bg-slate-800 text-slate-200" : "bg-slate-200 text-slate-800"
        )}
      >
        {children}
      </pre>
    ),
  

    blockquote: ({ children }) => (
      <blockquote
        className={cn(
          "border-l-4 pl-3 my-2 italic",
          isDark ? "border-cyan-400 text-slate-300" : "border-blue-400 text-slate-600"
        )}
      >
        {children}
      </blockquote>
    ),

    ul: ({ children }) => <ul className="list-disc list-inside mb-2 space-y-1">{children}</ul>,
    ol: ({ children }) => <ol className="list-decimal list-inside mb-2 space-y-1">{children}</ol>,
    li: ({ children }) => <li className="text-sm">{children}</li>,

    a: ({ href, children }) => (
      <a
        href={href}
        target="_blank"
        rel="noopener noreferrer"
        className={cn(
          "underline hover:no-underline transition-colors",
          isDark ? "text-cyan-400 hover:text-cyan-300" : "text-blue-600 hover:text-blue-700"
        )}
      >
        {children}
      </a>
    ),

    img: ({ src, alt, ...props }) => (
      <img
        src={src || ""}
        alt={alt || ""}
        {...props}
          className="max-h-60 max-w-full w-auto rounded-lg my-3 border border-slate-300 dark:border-slate-700 object-contain"
          style={{ maxWidth: "300px" }}
      />
    ),
  };

  return (
    <div className="text-sm prose prose-sm max-w-none">
      <ReactMarkdown components={components}>{content}</ReactMarkdown>
    </div>
  );
};
