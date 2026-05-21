const iconHref = (name) => `lucide-sprite.svg#${name}`;

const options = [
  { icon: "icon-align-left", label: "Short" },
  { icon: "icon-align-justify", label: "Very long option" },
  { icon: "icon-align-center", label: "Medium option" },
];

await loadTailwind();
initDropdown(document.querySelector("[data-dropdown]"));

async function loadTailwind() {
  const css = await fetch("../shared/dropdown-demo.css").then((response) => response.text());
  const style = document.createElement("style");
  style.type = "text/tailwindcss";
  style.textContent = css;
  document.head.append(style);

  await new Promise((resolve, reject) => {
    const script = document.createElement("script");
    script.src = "https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4";
    script.onload = resolve;
    script.onerror = reject;
    document.head.append(script);
  });
}

function initDropdown(root) {
  if (!root) return;

  const trigger = root.querySelector("[data-trigger]");
  const search = root.querySelector("[data-search]");
  const input = root.querySelector("[data-input]");
  const menu = root.querySelector("[data-menu]");
  const measureMenu = root.querySelector("[data-measure-menu]");
  const value = root.querySelector("[data-value]");
  const triggerIcon = root.querySelector("[data-trigger-icon] use");
  let activeIndex = null;

  measureMenu.replaceChildren(...options.map((option) => createMeasureRow(option)));
  menu.replaceChildren(...options.map((option) => createOptionRow(option)));

  const rows = [...root.querySelectorAll("[data-option]")];
  const measureRows = [...root.querySelectorAll("[data-measure-option]")];

  trigger.addEventListener("click", openMenu);
  rows.forEach((row) => row.addEventListener("click", () => selectRow(row)));
  document.addEventListener("pointerdown", (event) => {
    if (!root.contains(event.target)) closeMenu();
  });
  input.addEventListener("keydown", handleInputKeydown);
  input.addEventListener("input", handleInput);

  function openMenu() {
    trigger.hidden = true;
    search.classList.remove("dropdown-hidden");
    menu.classList.remove("dropdown-hidden");
    input.value = "";
    rows.forEach((row) => {
      row.hidden = false;
    });
    activeIndex = null;
    renderActiveRow();
    input.focus();
  }

  function closeMenu() {
    trigger.hidden = false;
    search.classList.add("dropdown-hidden");
    menu.classList.add("dropdown-hidden");
  }

  function handleInputKeydown(event) {
    const currentRows = visibleRows();

    if (event.key === "ArrowDown") {
      event.preventDefault();
      if (currentRows.length) {
        activeIndex = activeIndex === null ? 0 : (activeIndex + 1) % currentRows.length;
      }
    }

    if (event.key === "ArrowUp") {
      event.preventDefault();
      if (currentRows.length) {
        activeIndex = activeIndex === null ? currentRows.length - 1 : (activeIndex - 1 + currentRows.length) % currentRows.length;
      }
    }

    if (event.key === "Enter" && activeIndex !== null && currentRows[activeIndex]) {
      event.preventDefault();
      selectRow(currentRows[activeIndex]);
    }

    if (event.key === "Escape") closeMenu();

    renderActiveRow();
  }

  function handleInput() {
    const query = input.value.trim().toLowerCase();
    rows.forEach((row) => {
      row.hidden = query ? !row.dataset.option.toLowerCase().includes(query) : false;
    });
    activeIndex = visibleRows().length ? 0 : null;
    renderActiveRow();
  }

  function selectRow(row) {
    value.textContent = row.dataset.option;
    value.classList.remove("dropdown-placeholder");
    triggerIcon.setAttribute("href", iconHref(row.dataset.icon));
    measureRows.forEach((item) => {
      setCheck(item, item.dataset.measureOption === row.dataset.option);
    });
    rows.forEach((item) => {
      const selected = item === row;
      item.setAttribute("aria-selected", String(selected));
      item.classList.toggle("dropdown-option-selected", selected);
      setCheck(item, selected);
    });
    closeMenu();
  }

  function renderActiveRow() {
    rows.forEach((row) => {
      row.removeAttribute("aria-current");
      row.classList.remove("dropdown-option-active");
    });

    if (activeIndex === null) return;

    const activeRow = visibleRows()[activeIndex];
    if (!activeRow) return;

    activeRow.setAttribute("aria-current", "true");
    activeRow.classList.add("dropdown-option-active");
  }

  function visibleRows() {
    return rows.filter((row) => !row.hidden);
  }
}

function createMeasureRow(option) {
  const row = document.createElement("span");
  row.className = "dropdown-measure-option";
  row.dataset.measureOption = option.label;
  row.append(createIcon(option.icon), createText(option.label));
  return row;
}

function createOptionRow(option) {
  const row = document.createElement("button");
  row.className = "dropdown-option";
  row.dataset.icon = option.icon;
  row.dataset.option = option.label;
  row.type = "button";
  row.setAttribute("aria-selected", "false");
  row.append(createIcon(option.icon), createText(option.label, "dropdown-row-text"));
  return row;
}

function createIcon(name, marker) {
  const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute("class", "dropdown-icon");
  svg.setAttribute("aria-hidden", "true");
  if (marker) svg.dataset[marker] = "";

  const use = document.createElementNS("http://www.w3.org/2000/svg", "use");
  use.setAttribute("href", iconHref(name));
  svg.append(use);
  return svg;
}

function createText(text, className) {
  const span = document.createElement("span");
  if (className) span.className = className;
  span.textContent = text;
  return span;
}

function setCheck(row, checked) {
  const existingCheck = row.querySelector("[data-check]");
  if (checked && !existingCheck) {
    row.append(createIcon("icon-check", "check"));
  }
  if (!checked && existingCheck) {
    existingCheck.remove();
  }
}
