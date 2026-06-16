# Dropdowns That Size Correctly

This note documents a dropdown pattern for humans and LLMs building UI primitives. It assumes the UI is built with Tailwind CSS. If you are not using Tailwind, mirror the same layout, measurement, spacing, and interaction rules in your own styling system.

## What This Solves

Dropdowns often break when the open search input decides the component width. The result is a trigger that is too small, a menu that is too wide, or option rows with unexplained empty space.

The desired behavior is simple:

- The dropdown parent is at least as wide as its closed trigger content.
- The dropdown parent is also at least as wide as its widest option.
- If content is huge, the dropdown stops growing at a reasonable max width and visible text truncates.

## Live Demos

- [HTML Demo](https://razva.github.io/public/notes/ui/dropdowns/demo/html/)
- [React Demo](https://razva.github.io/public/notes/ui/dropdowns/demo/tsx/)

Both demos use the same shared CSS contract: [`demo/shared/dropdown-demo.css`](demo/shared/dropdown-demo.css).

Source links:

- [Shared Tailwind dropdown CSS](https://github.com/Razva/public/blob/main/notes/ui/dropdowns/demo/shared/dropdown-demo.css)
- [HTML Source](https://github.com/Razva/public/tree/main/notes/ui/dropdowns/demo/html)
- [React Source](https://github.com/Razva/public/tree/main/notes/ui/dropdowns/demo/tsx)

## Features

The demo dropdown is searchable, keyboard-accessible, and naturally sized. It opens with all options visible, focuses the search input immediately, filters as the user types, supports arrow-key navigation, selects with `Enter`, resets search on reopen, and closes on outside click or `Escape`.

The selected option updates the trigger label and icon. The selected row uses accent text plus a check icon, and that check is rendered only when the option is selected.

Selection and keyboard-active state are intentionally separate. Reopening the dropdown should show the selected row with accent text and a check only; it should not receive the hover/keyboard-active background until the user hovers, presses an arrow key, or types a search query.

## Core Rule

The visible input must not decide dropdown width.

The width should be decided by a hidden measurement layer. The visible trigger, search input, menu, and option rows then fill that measured width.

## The Three-Layer Model

Use three separate responsibilities:

1. **Measurement layer:** invisible content that measures the natural trigger and option widths. It should not truncate.
2. **Visible trigger/search:** the closed trigger or open search input. It fills the measured width.
3. **Visible menu/options:** the open menu and rows. The menu fills the measured width; rows fill the menu.

This separation prevents the search input from stretching the dropdown while still keeping the open state visually aligned.

## Sizing Contract

The wrapper should use natural sizing with a max-width guard. In Tailwind terms, the demo uses a wrapper shaped like `relative inline-grid w-max max-w-sm`.

The hidden measurement layer should include:

- closed trigger content;
- every option row;
- normal menu padding and row padding;
- selected check icon only when it exists.

Hidden option rows should use natural width:

- use `w-max`;
- use `whitespace-nowrap`;
- do not use `truncate`;
- do not use `min-w-0`;
- do not use `flex-1`.

Visible rows should fill the measured menu:

- use `w-full`;
- allow text truncation only after the wrapper reaches its max width;
- do not add reserved checkmark space for unselected rows.

## Interaction Contract

Searchable dropdowns should follow the feature list above. One important detail: when search leaves one result, `Enter` should select that result even if the user did not manually arrow to it.

Non-searchable dropdowns should use the same visual system and row states. They can replace text search with typeahead behavior when useful.

## Visual Contract

The trigger and menu should share the same width. The menu should open directly below the trigger and option rows should fill the menu width.

Use simple row states:

- default row: no visible background;
- hover or keyboard-active row: subtle background and border;
- selected row: accent text/icon plus a check icon.

Menu option text should use the same font size as the trigger text. Avoid making the opened menu feel like a separate UI scale.

The icon, label, and check should stay vertically centered. For short selected options, the check should sit near the label, not at a distant far-right edge caused by artificial width.

## HTML Demo Notes

The HTML demo is for understanding DOM behavior, not for recommending a production framework.

It uses:

- the shared Tailwind CSS source from `demo/shared/dropdown-demo.css`;
- a separate JavaScript file for dropdown behavior;
- a separate SVG sprite for icons.

The HTML demo loads Tailwind in the browser so the same Tailwind-authored CSS contract can be used without a build step.

## React/TSX Demo Notes

The React/Tailwind TSX demo uses the same shared CSS source as the HTML demo.

React owns:

- open/closed state;
- selected value;
- search query;
- keyboard-active index.

The Vite output in `dist` is runtime build output only. It is not the source of truth for the visual contract.

## Production Guidance

Do not copy-paste the full demo into a production app.

Instead:

- build one shared dropdown primitive;
- use the same primitive family for searchable and non-searchable dropdowns;
- treat single-select and multi-select as behavior modes, not separate visual systems;
- keep trigger, menu, row spacing, typography, hover, selected, disabled, and focus states consistent;
- document the primitive before product screens depend on it.

The demo files are useful as reference specimens when an implementation starts drifting.

## Common Mistakes

- Letting the input determine menu width.
- Measuring truncated text.
- Measuring rows with `min-w-0` or `flex-1`.
- Reserving checkmark space for every option.
- Using fixed widths to hide sizing bugs.
- Making hidden measurement rows `w-full`.
- Forgetting outside-click close.
- Creating a new dropdown implementation per feature.

## Acceptance Checklist

Use short, medium, and long option labels when testing the primitive.

The dropdown passes when:

- short, medium, and long options all fit naturally;
- the closed trigger is never narrower than the widest option unless max width is reached;
- the menu has no unexplained empty strip;
- option hover and keyboard-active states cover the intended row area;
- the selected check appears next to the selected label;
- HTML and TSX demos look equivalent.
