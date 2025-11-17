export {};

declare global {
  interface SpeechRecognitionEvent extends Event {
    readonly resultIndex: number;
    readonly results: SpeechRecognitionResultList;
  }

  interface SpeechRecognitionResultList {
    readonly length: number;
    item(index: number): SpeechRecognitionResult;
    [index: number]: SpeechRecognitionResult;
  }

  interface SpeechRecognitionResult {
    readonly length: number;
    readonly isFinal: boolean;
    item(index: number): SpeechRecognitionAlternative;
    [index: number]: SpeechRecognitionAlternative;
  }

  interface SpeechRecognitionAlternative {
    readonly transcript: string;
    readonly confidence: number;
  }

  interface SpeechRecognition extends EventTarget {
    continuous: boolean;
    interimResults: boolean;
    lang: string;
    maxAlternatives: number;

    onaudiostart: ((ev: Event) => void) | null;
    onsoundstart: ((ev: Event) => void) | null;
    onspeechstart: ((ev: Event) => void) | null;
    onspeechend: ((ev: Event) => void) | null;
    onsoundend: ((ev: Event) => void) | null;
    onaudioend: ((ev: Event) => void) | null;
    onresult: ((ev: SpeechRecognitionEvent) => void) | null;
    onnomatch: ((ev: Event) => void) | null;
    onerror: ((ev: SpeechRecognitionErrorEvent) => void) | null;
    onstart: ((ev: Event) => void) | null;
    onend: ((ev: Event) => void) | null;

    abort(): void;
    start(): void;
    stop(): void;
  }

  interface SpeechRecognitionErrorEvent extends Event {
    readonly error:
      | "no-speech"
      | "aborted"
      | "audio-capture"
      | "network"
      | "not-allowed"
      | "service-not-allowed"
      | "bad-grammar"
      | "language-not-supported";
    readonly message: string;
  }
  interface Window {
    SpeechRecognition?: typeof window.SpeechRecognition;
    webkitSpeechRecognition?: typeof window.SpeechRecognition;
  }
}

