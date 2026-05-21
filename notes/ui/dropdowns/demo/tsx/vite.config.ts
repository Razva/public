import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";

export default defineConfig({
  base: "./",
  build: {
    cssMinify: false,
    minify: false,
    rollupOptions: {
      input: "source.html",
      output: {
        assetFileNames: "assets/dropdown-demo[extname]",
        chunkFileNames: "assets/dropdown-demo.js",
        entryFileNames: "assets/dropdown-bootstrap.js",
      },
    },
  },
  plugins: [react()],
});
