export interface Message {
  id: string;
  sender: "you" | "bot";
  text: string;
  isLoading?: boolean;
}

export interface MarkdownComponentProps {
  children?: React.ReactNode;
}

export interface CodeComponentProps extends MarkdownComponentProps {
  inline?: boolean;
  className?: string;
}

export interface LinkComponentProps extends MarkdownComponentProps {
  href?: string;
}
