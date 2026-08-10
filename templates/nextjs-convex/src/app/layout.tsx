import type { ReactNode } from "react";
import "./globals.css";

export const metadata = {
  title: "Next.js + Convex Starter",
  description: "Practical full-stack starter.",
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
