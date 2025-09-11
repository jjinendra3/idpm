"use client";

import React, { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Select, SelectItem } from "@/components/ui/select";
import { Button } from "@/components/ui/button";

type Props = {
  open: boolean;
  onOpenChange: (v: boolean) => void;
};

export default function ChatPrepModal({ open, onOpenChange }: Props) {
  const router = useRouter();
  const [dbType, setDbType] = useState<string>("postgres");
  const [dbLink, setDbLink] = useState<string>("");
  const [error, setError] = useState<string | null>(null);


  useEffect(() => {
    if (!open) return; // only run when modal is opened
    try {
      const raw = sessionStorage.getItem("idpm_db");
      if (raw) {
        const parsed = JSON.parse(raw);
        if (parsed?.type) setDbType(parsed.type);
        if (parsed?.url) setDbLink(parsed.url);
      }
    } catch {
      // ignore
    }
  }, [open]);

  if (!open) return null;


  function validateLink(type: string, link: string) {
    if (!link || link.trim().length < 5) return false;
    if (type === "postgres" && !/^(postgres|postgresql):\/\//i.test(link)) return false;
    if (type === "mysql" && !/^mysql:\/\//i.test(link)) return false;
    return true;
  }

  function handleCancel() {
    setError(null);
    onOpenChange(false);
  }

  function handleContinue() {
    setError(null);

    if (!validateLink(dbType, dbLink)) {
      setError("Please provide a valid database link matching the selected type.");
      return;
    }

    try {
      sessionStorage.setItem("idpm_db", JSON.stringify({ type: dbType, url: dbLink }));
    } catch (err) {
      console.warn("Failed to save DB info to sessionStorage:", err);

      setError("Unable to save configuration locally. Try a different browser or disable strict storage settings.");
      return;
    }

    onOpenChange(false);
    setTimeout(() => router.push("/chat"), 60);
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Connect a database</DialogTitle>
          <DialogDescription>
            Provide a link to your database account and select its type. This will be used for the chat session.
          </DialogDescription>
        </DialogHeader>

        <div className="grid gap-4 py-4">
          <div>
            <Label htmlFor="db-type">Database type</Label>
            <Select value={dbType} onValueChange={(v) => setDbType(v)}>
              <SelectItem value="postgres">Postgres</SelectItem>
            </Select>
          </div>

          <div>
            <Label htmlFor="db-link">Database link</Label>
            <Input
              id="db-link"
              value={dbLink}
              onChange={(ev) => setDbLink(ev.currentTarget.value)}
              placeholder="e.g. postgres://user:pass@host:5432/dbname"
            />
          </div>

          {error && <div className="text-sm text-rose-400">{error}</div>}
        </div>

        <DialogFooter>
          <div className="flex items-center justify-end gap-3 w-full">
            <Button variant="ghost" onClick={handleCancel}>
              Cancel
            </Button>
            <Button onClick={handleContinue}>Continue to chat</Button>
          </div>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
