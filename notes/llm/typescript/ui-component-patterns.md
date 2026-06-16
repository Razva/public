# UI Component Patterns

This file captures reusable UI interaction contracts for TypeScript apps. Treat these as product-quality primitive rules, not one-off screen styling notes.

## Dropdown Principle

Dropdowns are shared primitives. Build or approve the primitive once, then use it everywhere.

Do not create a fresh dropdown implementation inside a feature just because the list is slightly different. If a new dropdown need appears, extend the primitive and update this document before using it in product screens.

## Dropdown Families

Use only two behavior families:

- Searchable dropdown: for long, dynamic, or user-filterable lists.
- Non-searchable dropdown: for short or static lists.

Single-select and multi-select are modes inside those families. They are not separate visual systems.

## Shared Visual Contract

Both families should share the same rhythm:

- trigger and menu use the same width;
- width is natural/content-driven or layout-constrained, not arbitrary fixed pixels;
- open menus do not resize while open;
- option text uses the same size as the trigger/button text;
- default spacing: `h-9`, `px-3`, `p-1.5`, `gap-1`;
- default/selected row surface: `border-transparent bg-white`;
- selected row may use success-colored text/checkmark, but not a separate fill unless the product explicitly asks for it;
- hover/search-highlight row surface: `border-slate-200 bg-slate-50`;
- keep `border border-transparent` on default rows so hover/highlight borders do not shift layout;
- use Tailwind classes for spacing, color, border, radius, shadow, and focus treatment.

Do not use custom pixel widths for ordinary dropdown sizing. Use Tailwind layout constraints only when the surrounding layout requires a max width.

## Searchable Dropdown Behavior

Searchable dropdowns should:

- show all options immediately when opened;
- focus the input on open and select the current text;
- filter only after the user types;
- keep the menu open while filtering;
- close on outside click without selecting;
- close on `Escape`;
- use `ArrowDown` and `ArrowUp` to move the highlighted row;
- use `Enter` to select the highlighted row;
- if filtering leaves exactly one visible row, use `Enter` to select that row even when the user has not arrowed to it;
- keep selected/current styling separate from keyboard highlight behavior;
- render through portal/fixed-position behavior when a parent can clip overflow.

## Non-Searchable Dropdown Behavior

Non-searchable dropdowns should:

- open to all options;
- close on outside click without selecting;
- close on `Escape`;
- use `ArrowDown` and `ArrowUp` to move the highlighted row;
- use `Enter` to select the highlighted row;
- support first-letter typeahead;
- repeated first-letter presses move to the next lower matching option and wrap;
- use a neutral focus-visible ring on the trigger rather than browser-default blue outlines.

## Menu-Style Dropdown Behavior

Avatar, profile, workspace, and settings menus may use menu semantics, headings, and separators, but the actionable rows should still follow the dropdown row contract.

For menu-style dropdowns:

- exclude headings and separators from keyboard navigation;
- include all actionable rows in one ordered typeahead list;
- in mockups, activating selectable rows may update local state;
- non-wired mock action rows may simply close the menu;
- keep the same row spacing and hover/highlight treatment as the dropdown primitives.

## Accessibility Checklist

Before considering a dropdown primitive finished:

- icon-only triggers have accessible names;
- menus close on outside click and `Escape`;
- keyboard users can open, navigate, and select;
- focus remains visible but uses app styling;
- row highlighting does not rely on color alone when selection state matters;
- native `title` attributes are not used for tooltips;
- clipped parents are handled with portal/fixed-position rendering where needed.

## Anti-Patterns

Avoid:

- hand-rolling dropdowns per screen;
- mixing different row heights or font sizes across dropdowns;
- fixed pixel widths for content-sized menus;
- menu width being controlled by an open search input;
- hover and keyboard highlight sharing hidden state accidentally;
- putting selected, hover, and active states on competing background classes in the same row;
- requiring users to click the same trigger to close a dropdown;
- mouse-only selection or navigation.
