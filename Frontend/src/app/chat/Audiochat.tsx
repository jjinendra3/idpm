"use client";

import { useState, useEffect, useRef } from "react";

interface AudioChatProps {
  onTextCapture: (text: string) => void;
  onInterimTextChange: (text: string) => void;
  onClose: () => void;
}

export default function Audiochat({ onTextCapture, onInterimTextChange, onClose }: AudioChatProps) {
  const [text, setText] = useState<string>("");

  const recognitionRef = useRef<SpeechRecognition | null>(null);
  const silenceTimerRef = useRef<NodeJS.Timeout | null>(null);
  const latestTextRef = useRef<string>("");

  const clearSilenceTimer = () => {
    if (silenceTimerRef.current) {
      clearTimeout(silenceTimerRef.current);
      silenceTimerRef.current = null;
    }
  };

  const stopListening = () => {
    recognitionRef.current?.stop();
    clearSilenceTimer();
  };

  useEffect(() => {
    const SpeechRecognitionClass =
      (window as unknown as Window & {
        SpeechRecognition: new () => SpeechRecognition;
        webkitSpeechRecognition: new () => SpeechRecognition;
      }).SpeechRecognition ??
      (window as unknown as Window & {
        SpeechRecognition: new () => SpeechRecognition;
        webkitSpeechRecognition: new () => SpeechRecognition;
      }).webkitSpeechRecognition;

    if (!SpeechRecognitionClass) {
      alert("Your browser does not support Speech Recognition.");
      return;
    }

    const recognition = new SpeechRecognitionClass();
    recognition.lang = "en-US";
    recognition.interimResults = true;
    recognition.continuous = true;

    recognition.onresult = (event: SpeechRecognitionEvent) => {
      let combined = "";

      for (let i = 0; i < event.results.length; i++) {
        combined += event.results[i][0].transcript + " ";
      }

      combined = combined.trim();
      setText(combined);
      latestTextRef.current = combined;

      onInterimTextChange(combined);

      // Optional custom final result if added to d.ts
      recognition.finalTranscript = combined;

      clearSilenceTimer();
      silenceTimerRef.current = setTimeout(() => {
        stopListening();
        const finalText =
          recognition.finalTranscript || latestTextRef.current || "";
        if (finalText.trim()) {
          onTextCapture(finalText);
        } else {
          onClose();
        }
      }, 5000);
    };

    recognition.onerror = (err: SpeechRecognitionErrorEvent) => {
      console.error("Speech recognition error:", err);
    };

    recognitionRef.current = recognition;
  }, []);

  const startListening = () => {
    if (!recognitionRef.current) return;
    clearSilenceTimer();
    latestTextRef.current = "";
    setText("");
    recognitionRef.current.start();
  };

  useEffect(() => {
    startListening();
    return () => {
      stopListening();
    };
  }, []);

  return null;
}
