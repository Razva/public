import { StrictMode, useEffect, useRef, useState } from "react";
import { createRoot } from "react-dom/client";
import {
  AlignCenter,
  AlignJustify,
  AlignLeft,
  Check,
  ChevronDown,
  Search,
  type LucideIcon,
} from "lucide-react";

type Option = {
  Icon: LucideIcon;
  label: string;
  value: string;
};

const options: Option[] = [
  { Icon: AlignLeft, label: "Short", value: "short" },
  { Icon: AlignJustify, label: "Very long option", value: "very-long-option" },
  { Icon: AlignCenter, label: "Medium option", value: "medium-option" },
];

function cn(...classes: Array<string | false | null | undefined>) {
  return classes.filter(Boolean).join(" ");
}

function filterOptions(query: string) {
  const normalizedQuery = query.trim().toLowerCase();
  return normalizedQuery
    ? options.filter((option) => option.label.toLowerCase().includes(normalizedQuery))
    : options;
}

function Dropdown() {
  const [open, setOpen] = useState(false);
  const [value, setValue] = useState<string | null>(null);
  const [query, setQuery] = useState("");
  const [activeIndex, setActiveIndex] = useState<number | null>(null);
  const rootRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);
  const selected = options.find((option) => option.value === value) ?? null;
  const visibleOptions = filterOptions(query);
  const TriggerIcon = selected?.Icon ?? Search;
  const triggerLabel = selected?.label ?? "Type/Select";

  function selectOption(option: Option) {
    setValue(option.value);
    setOpen(false);
  }

  function openMenu() {
    setOpen(true);
    setQuery("");
    setActiveIndex(null);
    window.requestAnimationFrame(() => inputRef.current?.focus());
  }

  useEffect(() => {
    if (!open) return;

    function handlePointerDown(event: PointerEvent) {
      if (!rootRef.current?.contains(event.target as Node)) {
        setOpen(false);
      }
    }

    document.addEventListener("pointerdown", handlePointerDown);
    return () => document.removeEventListener("pointerdown", handlePointerDown);
  }, [open]);

  return (
    <div className="dropdown-root" ref={rootRef}>
      <div aria-hidden="true" className="dropdown-measure">
        <button className="dropdown-trigger">
          <TriggerIcon className="dropdown-icon" />
          <span className="dropdown-text">{triggerLabel}</span>
          <ChevronDown className="dropdown-icon" />
        </button>

        <div className="dropdown-measure-menu-frame">
          <div className="dropdown-measure-menu">
            {options.map((option) => (
              <span
                className="dropdown-measure-option"
                key={option.value}
              >
                <option.Icon className="dropdown-icon" />
                <span>{option.label}</span>
                {option.value === value ? <Check className="dropdown-icon" /> : null}
              </span>
            ))}
          </div>
        </div>
      </div>

      <button
        aria-expanded={open}
        className="dropdown-trigger"
        hidden={open}
        onClick={openMenu}
        type="button"
      >
        <TriggerIcon className="dropdown-icon" />
        <span className={cn("dropdown-text", !selected && "dropdown-placeholder")}>
          {triggerLabel}
        </span>
        <ChevronDown className="dropdown-icon" />
      </button>

      {open ? (
        <label className="dropdown-search">
          <Search className="dropdown-icon" />
          <input
            aria-label="Search views"
            className="dropdown-input"
            onChange={(event) => {
              const nextQuery = event.target.value;
              const nextVisibleOptions = filterOptions(nextQuery);
              setQuery(nextQuery);
              setActiveIndex(nextVisibleOptions.length ? 0 : null);
            }}
            onKeyDown={(event) => {
              if (event.key === "ArrowDown" && visibleOptions.length > 0) {
                event.preventDefault();
                setActiveIndex((current) => (
                  current === null ? 0 : (current + 1) % visibleOptions.length
                ));
              }
              if (event.key === "ArrowUp" && visibleOptions.length > 0) {
                event.preventDefault();
                setActiveIndex((current) => (
                  current === null
                    ? visibleOptions.length - 1
                    : (current - 1 + visibleOptions.length) % visibleOptions.length
                ));
              }
              if (event.key === "Enter" && activeIndex !== null && visibleOptions[activeIndex]) {
                event.preventDefault();
                selectOption(visibleOptions[activeIndex]);
              }
              if (event.key === "Escape") setOpen(false);
            }}
            ref={inputRef}
            value={query}
          />
          <ChevronDown className="dropdown-icon" />
        </label>
      ) : null}

      {open ? (
        <div className="dropdown-menu">
          {visibleOptions.map((option, index) => {
            const isSelected = option.value === value;
            const isActive = activeIndex !== null && index === activeIndex;
            return (
              <button
                aria-current={isActive ? "true" : undefined}
                className={cn(
                  "dropdown-option",
                  isActive && "dropdown-option-active",
                  isSelected && "dropdown-option-selected",
                )}
                key={option.value}
                onClick={() => selectOption(option)}
                type="button"
              >
                <option.Icon className="dropdown-icon" />
                <span className="dropdown-row-text">{option.label}</span>
                {isSelected ? (
                  <Check className="dropdown-icon" />
                ) : null}
              </button>
            );
          })}
        </div>
      ) : null}
    </div>
  );
}

function App() {
  return (
    <main className="demo-page">
      <h1 className="demo-title">React/Tailwind Dropdown Demo</h1>
      <p className="demo-copy">
        For more information about building these dropdowns, see{" "}
        <a
          className="demo-link"
          href="https://github.com/Razva/public/blob/main/notes/ui/dropdowns/README.md"
        >
          Dropdowns That Size Correctly
        </a>
        .
      </p>
      <Dropdown />
    </main>
  );
}

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
