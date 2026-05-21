async function loadSharedTailwind() {
  const cssUrl = new URL("../shared/dropdown-demo.css", window.location.href);
  const css = await fetch(cssUrl).then((response) => response.text());

  const style = document.createElement("style");
  style.type = "text/tailwindcss";
  style.textContent = css;
  document.head.append(style);

  await new Promise<void>((resolve, reject) => {
    const script = document.createElement("script");
    script.src = "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4";
    script.onload = () => resolve();
    script.onerror = () => reject(new Error("Could not load Tailwind browser runtime."));
    document.head.append(script);
  });
}

await loadSharedTailwind();
await import("./main");

export {};
