import ReactMarkdown from "react-markdown";
import { cn } from "@/lib/utils";
import { MarkdownComponentProps, CodeComponentProps, LinkComponentProps } from "./types";

interface MarkdownRendererProps {
  content: string;
  isDark: boolean;
}

export const MarkdownRenderer = ({ content, isDark }: MarkdownRendererProps) => {
  const components = {
    h1: ({ children }: MarkdownComponentProps) => (
      <h1 className="text-lg font-bold mb-2 mt-1">{children}</h1>
    ),
    h2: ({ children }: MarkdownComponentProps) => (
      <h2 className="text-base font-semibold mb-1 mt-1">{children}</h2>
    ),
    h3: ({ children }: MarkdownComponentProps) => (
      <h3 className="text-sm font-medium mb-1">{children}</h3>
    ),
    p: ({ children }: MarkdownComponentProps) => (
      <p className="mb-2 last:mb-0">{children}</p>
    ),
    strong: ({ children }: MarkdownComponentProps) => (
      <strong className="font-semibold">{children}</strong>
    ),
    em: ({ children }: MarkdownComponentProps) => (
      <em className="italic">{children}</em>
    ),
    code: ({ children, inline, className }: CodeComponentProps) => (
      <code className={cn(
        inline ? "px-1 py-0.5 rounded text-xs font-mono" : "block p-3 rounded-md text-xs font-mono overflow-x-auto my-2",
        isDark ? "bg-slate-800 text-cyan-300" : "bg-slate-200 text-blue-600",
        className
      )}>
        {children}
      </code>
    ),
    pre: ({ children }: MarkdownComponentProps) => (
      <pre className={cn(
        "p-3 rounded-md text-xs font-mono overflow-x-auto my-2",
        isDark ? "bg-slate-800 text-slate-200" : "bg-slate-200 text-slate-800"
      )}>
        {children}
      </pre>
    ),
    blockquote: ({ children }: MarkdownComponentProps) => (
      <blockquote className={cn(
        "border-l-4 pl-3 my-2 italic",
        isDark ? "border-cyan-400 text-slate-300" : "border-blue-400 text-slate-600"
      )}>
        {children}
      </blockquote>
    ),
    ul: ({ children }: MarkdownComponentProps) => (
      <ul className="list-disc list-inside mb-2 space-y-1">{children}</ul>
    ),
    ol: ({ children }: MarkdownComponentProps) => (
      <ol className="list-decimal list-inside mb-2 space-y-1">{children}</ol>
    ),
    li: ({ children }: MarkdownComponentProps) => (
      <li className="text-sm">{children}</li>
    ),
    a: ({ href, children }: LinkComponentProps) => (
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
  };

  return (
    <div className="text-sm prose prose-sm max-w-none">
      <ReactMarkdown components={components}>
        {content}
      </ReactMarkdown>
    </div>
  );
};
