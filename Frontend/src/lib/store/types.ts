/* eslint-disable @typescript-eslint/no-explicit-any */
export type GeneralStore = {
  createConversation: (dbUrls: string[]) => Promise<number>;
  getConversation: (id: number) => Promise<any>;
  sendMessage: (message: string, conversationId: number) => Promise<string>;
};
