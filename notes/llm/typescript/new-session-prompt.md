# Source Of Truth

Before doing implementation work, read the current source-of-truth materials for this project:

- current product brief or master brief;
- current UI/UX contract, if one exists;
- current architecture/codebase map;
- current deployment/env docs;
- private memory/current-context files, if the project uses private memory;
- latest relevant session logs or roadmap notes;
- current app repository state and git status.

Use the project’s canonical source locations. If a file is unavailable, inaccessible, or ambiguous, stop and ask for the missing source instead of guessing.

Do not use stale browser copies, unrelated local checkouts, old repositories, copied code from previous apps, or memory from another project unless explicitly authorized in this session.

If older notes conflict with newer current-context, roadmap, docs, or session logs, prefer the newest/current source and call out the conflict.

# Session Identity

This is a continuation of the current project, not a greenfield app, unless the user explicitly says otherwise.

Use only:

- the current app repository;
- the current project source-of-truth docs;
- the current private memory repo, if present;
- current session instructions;
- files, screenshots, credentials, and prompts explicitly provided in this session.

Do not inspect, inherit, reuse, or copy old implementation files, route names, schemas, component names, state shapes, Tailwind class strings, or file structure from older apps unless explicitly authorized.

If provided references are visual only, translate them into a short implementation contract. Do not copy source code unless explicitly approved.

# First Response

The first response must not include code changes, file edits, dependency installation, scaffolding, route creation, or implementation unless the user explicitly asks for implementation.

First:

1. Summarize the current product brief.
2. Summarize the UI/UX contract, if available.
3. Summarize current architecture and repo state.
4. Summarize current private memory or roadmap state, if available.
5. Identify remaining decisions or blockers for the next task.
6. Restate the guardrails that apply to the current task.

If the first user message is diagnostic, investigate and answer only. Do not mutate code, config, services, or data unless explicitly asked.

# Repo, Git, And Identity Rules

Before editing:

- check app repo git status;
- check private memory repo git status, if present;
- inspect relevant diffs before touching files;
- never overwrite, revert, or clean up user changes unless explicitly asked;
- keep public app commits and private memory commits separate;
- use the project’s approved Git identity for commits;
- never commit as an assistant, bot, automation, model, or placeholder identity.

Before pushing or opening a PR, confirm:

- branch;
- target branch;
- git identity;
- working-tree status;
- relevant checks.

For shared templates, bootstrap repos, or external repos, use a fresh temporary checkout from the canonical source branch instead of an arbitrary local copy.

# Architecture Guardrails

Prefer the project’s existing structure and patterns.

- Keep route/page files thin and composition-focused.
- Split UI, data access, validation, adapters, state, routing, and mapping into named modules.
- Keep provider/vendor-specific code inside provider/adaptor boundaries.
- Core product code should depend on internal contracts and normalized app types, not vendor labels.
- Avoid one-off provider checks in core UI or feature code.
- Treat files over roughly 300 handwritten lines as split candidates.
- Treat files over roughly 500 handwritten lines as architecture smells unless generated, static data, migrations, or explicitly exempted.
- Add short role/intent comments for non-trivial boundaries, adapters, security-sensitive code, or non-obvious branches.
- When adding a capability, update all affected layers coherently: contract/types, implementation, UI handling, tests, and docs.

# UI Guardrails

Use the existing approved UI system and primitives.

- Use shared primitives for buttons, dropdowns, tooltips, tabs, menus, tables, forms, and recurring behavior.
- Match the current app’s visual rhythm: spacing, typography, colors, radius, shadows, density, and interaction states.
- Use the project’s chosen icon library consistently.
- Use Tailwind utilities unless the project explicitly permits another styling approach.
- Do not create custom CSS classes unless the project’s UI system allows them.
- Preserve independent lightweight UI state across view/mode/context switches unless a real context change requires reset.
- Include loading, empty, error, disabled, permission, and focus states for real workflows.
- For UI work, verify relevant desktop/mobile viewports visually before calling it done. If browser tooling is unavailable, say so.

# Data, Provider, And Security Guardrails

- External/provider writes must happen only from explicit user actions or approved workflows.
- Never write to external systems from rendering, loading, polling, background reads, or incidental state changes.
- Keep customer/user communications inside approved product workflows and channels.
- If a change affects data shape, permissions, external boundaries, or public behavior, state migration, compatibility, and rollout impact before coding.
- Avoid uncoordinated client fanout, repeated provider setup, and blocking primary UI on non-critical secondary data.
- Verify current third-party APIs/libraries from primary sources before building around them.
- Do not log secrets, credentials, tokens, cookies, private payloads, customer data, message bodies, recipient addresses, or sensitive identifiers.
- Implement the smallest durable slice that solves the current request. Challenge scope if it expands beyond the agreed task.

# Docs, Env, And Memory

- Update architecture/codebase-map docs when important files or folders are added, moved, renamed, or removed.
- Update public docs for user-facing behavior, configuration, env vars, architecture, deployment, operations, and limitations.
- When adding or changing env vars, update env validation, `.env.example`, deployment docs, and relevant operations docs in the same change.
- Do not hardcode origins, ports, bind hosts, credentials, service URLs, or provider settings in code. Route them through the project’s env/config system.
- Keep public docs human-facing. Do not mention assistant workflow, model usage, or automation in public app files.
- Keep private process notes, handoff context, and implementation memory in private memory, not public docs.
- Do not create or update the public README unless explicitly asked.
- Batch private memory updates by coherent work chunk, not every small edit.
- Never store secrets, credentials, raw customer data, tokens, cookies, or private payloads in memory.

# Verification

Run checks appropriate to the task.

Default expectations:

- run focused tests for changed behavior;
- run lint and typecheck before completion;
- run build for app or framework changes;
- run dependency audit when dependencies change;
- validate Docker/Compose config when service config changes;
- run browser/responsive verification for UI changes;
- run security or secret scans when required by the workflow or before publishing.

Before reporting completion, state:

- files changed;
- checks run and results;
- screenshots or browser verification, if UI changed;
- dependency/security audit result, if relevant;
- largest handwritten files when the change is broad;
- known risks or checks that could not be run;
- working-tree status when relevant.

Do not call work complete if required checks failed unless clearly reporting the failure and the remaining blocker.
