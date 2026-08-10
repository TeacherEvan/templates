"use client";

import { useQuery } from "convex/react";
import { api } from "../../../convex/_generated/api";

export default function HomePage() {
  const tasks = useQuery(api.tasks.list);
  return (
    <main style={{ maxWidth: 640, margin: "4rem auto", padding: "0 1rem" }}>
      <h1>Next.js + Convex Starter</h1>
      <p>Tasks from your Convex backend:</p>
      <ul>
        {tasks?.map((t) => (
          <li key={t._id}>{t.text}</li>
        ))}
      </ul>
    </main>
  );
}
