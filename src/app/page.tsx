"use client";
import React,{ useState, useRef, useEffect, FormEvent } from 'react';
import  type{JSX} from 'react';


type Message = {
id: string;
sender: 'you' | 'bot';
text: string;
time: string;
};


function nowTime() {
const d = new Date();
return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}


export default function ChatApp(): JSX.Element {
  const [messages, setMessages] = useState<Message[]>([
{ id: 'm1', sender: 'bot', text: 'Hello! This is a local chat. Type a message and press Send.', time: nowTime() },
]);
  const [input, setInput] = useState('');
  const [sending, setSending] = useState(false);
  const listRef = useRef<HTMLDivElement | null>(null);


useEffect(() => {
 if (listRef.current) {
 listRef.current.scrollTop = listRef.current.scrollHeight;
}
}, [messages]);


const sendMessage = async (text: string) => {
if (!text.trim()) return;
setSending(true);


const userMsg: Message = { id: String(Date.now()) + '-u', sender: 'you', text: text.trim(), time: nowTime() };
setMessages((m) => [...m, userMsg]);
setInput('');

setTimeout(() => {
const botMsg: Message = { id: String(Date.now()) + '-b', sender: 'bot', text: `Got your message: "${text.trim()}"`, time: nowTime() };
setMessages((m) => [...m, botMsg]);
setSending(false);
}, 600);
};


const onSubmit = (e: FormEvent) => {
e.preventDefault();
sendMessage(input);
};


