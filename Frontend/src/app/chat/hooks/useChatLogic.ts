import { useState, useEffect } from 'react';
import { Message } from '../types';
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

export const useChatLogic = (scrollToBottom: () => void) => {
  const router = useRouter();
  const searchParams = useSearchParams();
  const conversation_id = searchParams.get("id") || "";
  const fetchConversation = generalStore((state: { getConversation: (id: number) => Promise<ConversationData> }) => state.getConversation);
  const sendMessageFunc = generalStore((state: { sendMessage: (message: string, id: number) => Promise<string> }) => state.sendMessage);
  
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


  useEffect(() => {
    const timer = setTimeout(scrollToBottom, 100);
    return () => clearTimeout(timer);
  }, [messages, scrollToBottom]);

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

  return {
    messages,
    input,
    setInput,
    sending,
    sendMessage,
    handleNewChat,
    title,
  };
};
