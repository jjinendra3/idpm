import { create } from "zustand";
import type { GeneralStore } from "./types";
import axios from "axios";
const BACKEND_URL =
  process.env.NEXT_PUBLIC_BACKEND_URL || "http://localhost:8000";
export const generalStore = create<GeneralStore>()(
  (set, get) => ({
    createConversation: async (dbUrls: string[]) => {
      const response = await axios.post(`${BACKEND_URL}/conversation`, {
        dbUrls,
      });
      if (response.status !== 200)
        throw new Error("Failed to create conversation");
      return response.data.id as number;
    },
    getConversation: async (id: number) => {
      const response = await axios.get(`${BACKEND_URL}/conversation/${id}`);

      if (response.status !== 200 || !response.data)
        throw new Error("Failed to get conversation");
      return response.data;
    },
    sendMessage: async (message: string, conversationId: number) => {
      try {
        console.log("Sending message to backend:", { message, conversationId });
        const response = await axios.post(
          `${BACKEND_URL}/message/${conversationId}?message=${encodeURIComponent(
            message
          )}`
        )
        if (response.status !== 200)
          throw new Error("Failed to send message");
        return response.data.content;
      } catch (error) {
        console.error("Error sending message:", error);
        throw error;
      }
    },
  }),

);
