import { useRef } from 'react';

export const useScrollToBottom = () => {
  const listRef = useRef<HTMLDivElement | null>(null);
  const bottomRef = useRef<HTMLDivElement | null>(null);

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

  };

  return {
    listRef,
    bottomRef,
    scrollToBottom,
    handleScroll,
  };
};
