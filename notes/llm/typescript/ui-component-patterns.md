# UI Component Patterns

This file is a reusable reference for product-quality TypeScript UI primitives. Consult it during [typescript-app-bootstrap.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-app-bootstrap.md), adopt the relevant contracts into the app’s local UI documentation, and then treat that project-local contract as canonical.

This public file is a seed for new apps, not a remote override for established applications.

## Adoption And Precedence

- Adopt only patterns relevant to the product and chosen UI stack.
- Record accepted defaults and project-specific deviations in the app’s local UI contract.
- Once adopted, change the local primitive and local documentation together.
- Do not silently change an established app because this reusable reference later changes.
- When the app already has an approved primitive, extend it coherently instead of creating a competing implementation inside a feature.

## Shared Primitive Baseline

- Repeated interactions belong in shared primitives rather than feature-local markup.
- Components in the same family should share typography, spacing, radius, borders, shadows, focus treatment, disabled/loading behavior, and keyboard conventions.
- Use the project’s established styling approach. The concrete examples below use Tailwind utilities; map them to the app’s accepted tokens or styling system when needed.
- Prefer additive primitive changes with unchanged defaults. Do not change DOM structure, width behavior, hidden measurement nodes, or keyboard behavior to solve one caller unless the shared behavior itself is intentionally changing.
- Include accessible names, visible focus, semantic roles, and understandable loading, disabled, empty, and error states from the first implementation.

## Tooltips And Overlay Positioning

- Do not use native `title` attributes for product tooltips.
- Use a shared tooltip primitive with consistent delay, styling, placement, and accessible labeling.
- Do not rely on z-index alone when an ancestor can clip overflow.
- When a parent uses `overflow-hidden`, `overflow-auto`, scrolling, transforms, or another clipping boundary, render floating content through a portal or fixed-position overlay outside that boundary, commonly attached to `document.body`.
- Apply the same overlay strategy to dropdowns, menus, popovers, and other floating primitives.

## Dropdowns

### Principle

Dropdowns are shared primitives. Build or approve the primitive once, then use it everywhere.

Do not create a new dropdown implementation inside a feature merely because its list differs. Extend the shared contract when the new need is broadly valid; otherwise configure the existing primitive through an explicit supported mode.

### Families

Use two behavior families:

- searchable dropdowns for long, dynamic, or user-filterable lists;
- non-searchable dropdowns for short or static lists.

Single-select and multi-select are modes inside those families, not separate visual systems.

Avatar, profile, workspace, and settings menus may use menu semantics, headings, and separators, but actionable rows should retain the shared visual and keyboard rhythm.

### Shared Visual Contract

Both dropdown families should:

- keep trigger and menu widths aligned;
- use natural/content-driven or layout-constrained width rather than arbitrary fixed pixels;
- avoid resizing the menu while it is open;
- use the same text size in options and the trigger/button;
- default to spacing such as `h-9`, `px-3`, `p-1.5`, and `gap-1` when that matches the adopted design system;
- keep a stable border box so hover/highlight borders do not shift layout;
- distinguish selection from keyboard/search highlight;
- preserve the app’s established radius, shadow, focus, and disabled treatment.

The reusable Tailwind reference uses:

- default/selected row surface: `border-transparent bg-white`;
- hover/search-highlight row surface: `border-slate-200 bg-slate-50`;
- `border border-transparent` on default rows to prevent layout shift;
- optional success-colored selected text/checkmark without a separate selected fill unless the product asks for it.

Do not copy these classes over an established local token contract; translate the behavior into the app’s canonical design system.

### Searchable Behavior

Searchable dropdowns should:

- show all options immediately when opened;
- focus the input on open and select its current text when appropriate;
- filter only after the user types;
- keep the menu open while filtering;
- close on outside click without selecting;
- close on `Escape`;
- use `ArrowDown` and `ArrowUp` to move the highlighted row;
- use `Enter` to select the highlighted row;
- select the sole visible result on `Enter` even when the user has not arrowed to it;
- keep selected/current styling separate from keyboard/search highlight state;
- use the shared overlay strategy when a parent can clip overflow.

### Non-Searchable Behavior

Non-searchable dropdowns should:

- open to all options;
- close on outside click without selecting;
- close on `Escape`;
- use `ArrowDown` and `ArrowUp` to move the highlighted row;
- use `Enter` to select the highlighted row;
- support first-letter typeahead;
- move to the next lower match and wrap when the same first letter is pressed repeatedly;
- use the app’s focus-visible treatment instead of an unstyled browser-default outline.

### Menu-Style Behavior

For menu-style dropdowns:

- exclude headings and separators from keyboard navigation;
- include all actionable rows in one ordered typeahead/navigation list;
- keep row spacing and hover/highlight treatment aligned with dropdown primitives;
- close non-wired mock actions rather than simulating unapproved external behavior;
- allow selectable mock rows to update local state only when that behavior is part of the accepted prototype.

### Accessibility Checklist

Before considering a dropdown primitive finished:

- icon-only triggers have accessible names;
- keyboard users can open, navigate, select, and close;
- outside click and `Escape` close the menu;
- focus remains visible and follows app styling;
- selection is not communicated by color alone;
- headings and separators are excluded from option navigation;
- active-descendant, listbox/menu, and multiselect semantics match the actual interaction model;
- clipped parents are handled through the shared overlay strategy;
- browser automation or screenshots are used only when explicitly requested by the active task’s verification policy.

### Anti-Patterns

Avoid:

- hand-rolling dropdowns per screen;
- mixing row heights or font sizes across the family;
- arbitrary fixed pixel widths for content-sized menus;
- letting an open search input resize the menu;
- accidentally coupling hover and keyboard-highlight state;
- competing selected, hover, and active background classes on the same row;
- requiring users to click the trigger again to close;
- mouse-only selection or navigation;
- duplicating this detailed contract inside app-bootstrap or session prompts.
