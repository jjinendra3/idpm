import React from "react";

type DialogProps = {
  open?: boolean;
  onOpenChange?: (v: boolean) => void;
  children: React.ReactNode;
};

export function Dialog(props: DialogProps) {
  return <>{props.children}</>;
}

export function DialogContent({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <div
      className={`fixed inset-0 z-50 flex items-center justify-center p-4 ${className}`}
      role="dialog"
      aria-modal="true"
    >
      <div className="fixed inset-0 bg-black/60 backdrop-blur-sm" aria-hidden />

      <div className="relative z-10 w-full max-w-lg transform rounded-2xl bg-slate-800/90 border border-slate-700 p-6 shadow-xl">
        {children}
      </div>
    </div>
  );
}

export function DialogHeader({ children }: { children: React.ReactNode }) {
  return <div className="mb-3">{children}</div>;
}
export function DialogTitle({ children }: { children: React.ReactNode }) {
  return <h3 className="text-lg font-semibold text-slate-100">{children}</h3>;
}
export function DialogDescription({ children }: { children: React.ReactNode }) {
  return <p className="text-sm text-slate-400 mt-1">{children}</p>;
}
export function DialogFooter({ children }: { children: React.ReactNode }) {
  return <div className="mt-4">{children}</div>;
}
