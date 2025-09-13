"use client";

import { useState, useRef, useEffect, FormEvent } from "react";
import { cn } from "@/lib/utils";
import { AnimatePresence } from "framer-motion";
import { ChatHeader } from "./ChatHeader";
import { ChatMessage } from "./ChatMessage";
import { ChatInput } from "./ChatInput";
import { Message } from './types';
import { generalStore } from "@/lib/store/store";
import { useRouter, useSearchParams } from "next/navigation";

// Define proper types for store data
interface ConversationData {
  title: string;
  messages: {
    id: number;
    sender: "user" | "bot";
    content: string;
  }[];
}

interface StoreMessage {
  id: number;
  sender: "user" | "bot";
  content: string;
}

export default function ChatApp() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const conversation_id = searchParams.get("id") || "";
  const fetchConversation = generalStore((state: { getConversation: (id: number) => Promise<ConversationData> }) => state.getConversation);
  const sendMessageFunc = generalStore((state: { sendMessage: (message: string, id: number) => Promise<string> }) => state.sendMessage);

  // Theme state
  const [isDark, setIsDark] = useState(true);
  
  // Chat logic state (from useChatLogic)
  const [messages, setMessages] = useState<Message[]>([
    {
      id: "m1",
      sender: "bot",
      text: "Hello! Feel free to ask any questions related to the connected databases.",
    },
  ]);
  const [input, setInput] = useState("");
  const [sending, setSending] = useState(false);
  const [title, setTitle] = useState("New Chat");
  
  // Scroll logic state (from useScrollToBottom)
  const listRef = useRef<HTMLDivElement | null>(null);
  const bottomRef = useRef<HTMLDivElement | null>(null);

  // Scroll functions (from useScrollToBottom)
  const checkIfAtBottom = () => {
    if (!listRef.current) return false;
    const { scrollTop, scrollHeight, clientHeight } = listRef.current;
    return scrollHeight - scrollTop - clientHeight < 50;
  };

  const scrollToBottom = () => {
    if (checkIfAtBottom() && bottomRef.current) {
      bottomRef.current.scrollIntoView({ behavior: "smooth" });
    }
  };

  const handleScroll = () => {
    // Add scroll logic here if needed in future
  };

  // Load conversation effect (from useChatLogic)
  useEffect(() => {
    if (!conversation_id) return;
    
    const loadConversation = async () => {
      try {
        const data = await fetchConversation(Number(conversation_id));
        setTitle(data.title);
        setMessages(
          data.messages.map((msg: StoreMessage) => ({
            id: String(msg.id) + (msg.sender === "user" ? "-u" : "-b"),
            sender: msg.sender === "user" ? "you" : "bot",
            text: msg.content,
          }))
        );
      } catch (error) {
        console.error(error);
        router.push("/");
      }
    };

    loadConversation();
  }, [conversation_id, fetchConversation, router]);

  // Auto-scroll effect (from useChatLogic)
  useEffect(() => {
    const timer = setTimeout(scrollToBottom, 100);
    return () => clearTimeout(timer);
  }, [messages]);

  // Send message function (from useChatLogic)
  const sendMessage = async (text: string) => {
    if (!text.trim() || sending) return;
    
    setSending(true);
    const userMsg: Message = {
      id: `${Date.now()}-u`,
      sender: "you",
      text: text.trim(),
    };

    setMessages(prev => [...prev, userMsg]);
    setInput("");

    const loadingMsg: Message = {
      id: `${Date.now()}-b-loading`,
      sender: "bot",
      text: "",
      isLoading: true,
    };
    
    setMessages(prev => [...prev, loadingMsg]);

    try {
      const response = await sendMessageFunc(text, Number(conversation_id));
      if (!response) throw new Error("Invalid response");
      
      setMessages(prev =>
        prev.map(msg =>
          msg.id === loadingMsg.id
            ? { ...msg, text: response, isLoading: false }
            : msg
        )
      );
    } catch (error) {
      console.error(error);
      setMessages(prev =>
        prev.map(msg =>
          msg.id === loadingMsg.id
            ? { ...msg, text: "Sorry, I encountered an error. Please try again.", isLoading: false }
            : msg
        )
      );
    } finally {
      setSending(false);
    }
  };

  // New chat handler (from useChatLogic)
  const handleNewChat = () => {
    setMessages([
      {
        id: "m1",
        sender: "bot",
        text: "Hello! Feel free to ask any questions related to the connected databases.",
      },
    ]);
    setInput("");
    setSending(false);
  };

  // Form submit handler
  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    sendMessage(input);
  };

  // Theme toggle
  const toggleTheme = () => setIsDark(!isDark);

  return (
    <div className={cn("min-h-screen w-full flex flex-col", isDark ? "bg-slate-900" : "bg-slate-50")}>
      <ChatHeader 
        title={title}
        isDark={isDark} 
        onToggleTheme={toggleTheme} 
        onNewChat={handleNewChat} 
      />

      <div
        ref={listRef}
        onScroll={handleScroll}
        className="flex-1 overflow-y-auto p-6 space-y-4 scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-700"
      >
        <AnimatePresence initial={false}>
          {messages.map((message) => (
            <ChatMessage key={message.id} message={message} isDark={isDark} />
          ))}
        </AnimatePresence>
        <div ref={bottomRef} className="h-1" />
      </div>

      <ChatInput
        value={input}
        onChange={setInput}
        onSubmit={handleSubmit}
        sending={sending}
        isDark={isDark}
      />
    </div>
  );
}
