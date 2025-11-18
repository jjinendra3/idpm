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
import AudioChat from "./Audiochat"; 

interface ConversationData {
  title: string;
  id: number;
  messages: {
    id: number;
    sentBy: "human" | "ai";
    content: string;
    conversation_id: number;
  }[];
}

export default function ChatApp() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const conversation_id = searchParams.get("id") || "";
  const fetchConversation = generalStore((state: { getConversation: (id: number) => Promise<ConversationData> }) => state.getConversation);
  const sendMessageFunc = generalStore((state: { sendMessage: (message: string, id: number,  source?: "text" | "voice") => Promise<string> }) => state.sendMessage);

  const [isDark, setIsDark] = useState(true);

  const [messages, setMessages] = useState<Message[]>(
    conversation_id
      ? []
      : [
          {
            id: "m1",
            sender: "bot",
            text: "Hello! Feel free to ask any questions related to the connected databases.",
          },
        ]
  );

  const [bootstrapped, setBootstrapped] = useState<boolean>(!conversation_id);

  const [input, setInput] = useState("");
  const [sending, setSending] = useState(false);
  const [title, setTitle] = useState("New Chat");

  const listRef = useRef<HTMLDivElement | null>(null);
  const bottomRef = useRef<HTMLDivElement | null>(null);

  // ✅ NEW STATE
  const [showAudioChat, setShowAudioChat] = useState(false);
  const [listening, setListening] = useState(false);

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

  const handleScroll = () => {};

  useEffect(() => {
    if (!conversation_id) return;

    let alive = true;

    (async () => {
      try {
        const data = await fetchConversation(Number(conversation_id));
        if (!alive) return;

        setTitle(data.title);

        const mapped: Message[] = data.messages.map((msg) => ({
          id: String(msg.id) + (msg.sentBy === "human" ? "-u" : "-b"),
          sender: msg.sentBy === "human" ? "you" : "bot",
          text: msg.content,
        }));

        setMessages(
          mapped.length > 0
            ? mapped
            : [
                {
                  id: "m1",
                  sender: "bot",
                  text:
                    "Hello! Feel free to ask any questions related to the connected database.",
                },
              ]
        );
      } catch (error) {
        console.error(error);
        router.push("/");
      } finally {
        setBootstrapped(true);
      }
    })();

    return () => {
      alive = false;
    };
  }, [conversation_id, fetchConversation, router]);

  useEffect(() => {
    const timer = setTimeout(scrollToBottom, 100);
    return () => clearTimeout(timer);
  }, [messages]);

  const sendMessage = async (text: string) => {
    if (!text.trim() || sending) return;

    setSending(true);
    const userMsg: Message = {
      id: `${Date.now()}-u`,
      sender: "you",
      text: text.trim(),
    };

    setMessages((prev) => [...prev, userMsg]);
    setInput("");

    const loadingMsg: Message = {
      id: `${Date.now()}-b-loading`,
      sender: "bot",
      text: "",
      isLoading: true,
    };

    setMessages((prev) => [...prev, loadingMsg]);

    try {
      const response = await sendMessageFunc(text, Number(conversation_id));
      if (!response) throw new Error("Invalid response");

      setMessages((prev) =>
        prev.map((msg) =>
          msg.id === loadingMsg.id
            ? { ...msg, text: response, isLoading: false }
            : msg
        )
      );
    } catch (error) {
      console.error(error);
      setMessages((prev) =>
        prev.map((msg) =>
          msg.id === loadingMsg.id
            ? {
                ...msg,
                text: "Sorry, I encountered an error. Please try again.",
                isLoading: false,
              }
            : msg
        )
      );
    } finally {
      setSending(false);
    }
  };

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

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    sendMessage(input);
  };

   useEffect(() => {
  const handler = (e: Event) => {
    const customEvent = e as CustomEvent<string>;
    sendMessage(customEvent.detail);
  };

  window.addEventListener("VOICE_TEXT_READY", handler);
  return () => window.removeEventListener("VOICE_TEXT_READY", handler);
}, []);



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
        {bootstrapped && (
          <AnimatePresence initial={false}>
            {messages.map((message) => (
              <ChatMessage key={message.id} message={message} isDark={isDark} />
            ))}
          </AnimatePresence>
        )}
        <div ref={bottomRef} className="h-1" />
      </div>

      <ChatInput
        value={input}
        onChange={setInput}
        onSubmit={handleSubmit}
        sending={sending}
        isDark={isDark}
        onMicClick={() => {
          setListening(true);   
        }}  
       onCancelMic={() => {
          setListening(false);
          setInput("");
        }}
        listening={listening} 
      />

      {listening && 
      ( <AudioChat
         onInterimTextChange={(interimText) => {
         setInput(interimText);
         }}
         onTextCapture= {(text: string) => { 
          setInput(text); 
          setTimeout(()=> sendMessageFunc(text, Number(conversation_id), "voice"), 50);
          sendMessage(text); 
          setListening(false); 
          console.log("FROM CHILD:", text); }} 
          onClose={() => setListening(false)}
          />
          )}
    </div>
  );
}
