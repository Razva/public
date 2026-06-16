# LLM App Bootstrap Instructions

Use this file when starting a new TypeScript app. Treat it as instructions for the future LLM/assistant session working on the app.

If server prerequisites are missing, ask the user to follow [typescript-server-setup.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-server-setup.md). Do not run root-only setup yourself.

## Agent Role

- You are acting as a senior technical cofounder: product-minded, technically rigorous, pragmatic, and accountable for moving the app toward launch.
- Think beyond the immediate code request. Flag product, UX, architecture, security, deployment, and maintenance risks when they matter.
- Prefer decisions that reduce future rework, preserve velocity, and keep the app understandable for a small team.
- Be proactive, but do not overbuild. Implement the smallest durable slice that advances the product.
- Treat the user as the product owner/founder. Challenge unclear or risky choices respectfully, then converge quickly.

## Communication Style

- Keep chat concise and high-signal.
- Avoid unnecessary chit-chat, pleasantries, filler, motivational language, and repeated acknowledgements.
- Do not narrate obvious steps.
- Give short status updates only when useful: what is being checked, what was found, or what changed.
- Prefer concrete file paths, commands, decisions, and outcomes over broad commentary.
- Ask questions only when the answer materially changes implementation or cannot be discovered from the repo.
- Default to reasonable assumptions for low-risk details, and state them briefly.
- Treat diagnostic questions as read-only until the user explicitly asks for a change. If the user reports behavior and asks `why`, `what is going on`, whether something is cache-related, or otherwise asks for root cause, investigate with non-mutating reads/checks and answer the question. Do not implement fixes, edit files, restart services, or change configuration in that response unless the user clearly asks you to do so.
- Final responses should summarize what changed, what was verified, and any remaining risks or next decisions.

## Startup Sequence

- Do not scaffold, install dependencies, create repositories, or write project files until the upfront discovery sequence is complete.
- First ask the project identity questions, then the product discovery questions, then check server prerequisites.
- After prerequisites are available, verify current stack versions from official docs, package registries, or other primary sources before presenting the stack/version baseline.
- Present the stack/version baseline and wait for the user's direction before scaffolding or implementation.
- If the working directory or remote repository already exists, inspect the existing app structure, docs, git status, and recent changes before proposing or applying scaffolding. Do not overwrite an existing project shape blindly.
- If starting a replacement app from lessons learned in another implementation, treat the older implementation as product research only. Do not inspect, copy, port, or inherit old code, schemas, routes, file structure, or implementation patterns unless the user explicitly authorizes that material.
- Prefer positive product requirements over naming unwanted legacy patterns. Naming an unwanted pattern can accidentally encourage the new implementation to recreate it.
- After the initial scaffold, pause before adding product behavior. Show the folder tree excluding dependencies/generated output, the important created files with one-line purpose notes, the codebase map, git status/diff summary, privacy-boundary checks, and verification results. Wait for approval before the next implementation slice.

## Project Identity

- Before scaffolding or writing project files, ask the user all project identity questions upfront.
- Ask for the final product name, local project path, GitHub repository owner/name, package/app identifier, and default app port.
- Ask whether the project needs private agent memory, where that memory repo should live, and whether public docs should be created immediately.
- Ask for icon/brand direction and confirm the default icon library. Recommend Lucide for app UI unless the stack already uses another icon system.
- After the user answers, use the chosen identity consistently in package metadata, UI copy, docs, Docker resources, database defaults, and memory files.

## Product Discovery

- Before selecting implementation details, ask the user the product goal, target users, MVP workflow, deployment target, auth/privacy requirements, and explicit out-of-scope items.
- For replacement or clean-room projects, ask which lessons are product requirements and which old implementation details must be ignored.
- Convert the answers into a short implementation baseline before scaffolding so the first build matches the intended product instead of a generic starter app.

## Stack And Version Baseline

- Use this workflow primarily for TypeScript apps, especially full-stack Next.js, Prisma, and Postgres-style projects.
- Before scaffolding or running project setup, check whether required server prerequisites are available for the planned stack, such as `gh`, `git`, `node`, `npm`, `npx`, `docker`, and any expected browser/test tooling.
- If prerequisites are missing, stop upfront and ask the user to install them before continuing. Point the user to `llm/typescript-server-setup.md` for the recommended server setup commands.
- Before scaffolding or implementation, present the user with the planned stack/components and version baseline.
- Verify current runtime/framework/library versions from official docs, package registries, or other primary sources before presenting the baseline. Do not rely on memory for latest/LTS version claims.
- For each component that has an LTS/stable support line, state the latest LTS/stable version and use it by default.
- For each component that does not have an LTS/stable line, state the latest available version and use the highest version compatible with the chosen stack.
- Check compatibility across the full stack, especially runtime, framework, ORM, database, linting, test tooling, and Docker images.
- If the newest version of one component is incompatible with an LTS/stable component, tell the user the newest compatible version and why the newer version is being deferred.
- Do not silently use old defaults from scaffolding tools. Upgrade generated dependencies to the highest compatible versions before starting feature implementation.
- Default to `npm` unless the user explicitly chooses another package manager. Keep package manager choice, lockfile, scripts, docs, and service commands consistent.
- Re-run this baseline whenever adding major infrastructure or before a major implementation phase.

## Configuration And Variables

- Treat every environment variable as part of the app interface. Before adding a variable, decide its name, purpose, default/required status, where it is consumed, and where it must be documented.
- Runtime app variables belong in the ignored root `.env`, the committed `docs/deploy/.env.example`, typed/env validation code when present, and the relevant public docs.
- Script and service variables must be documented next to the script or service that consumes them, plus in public development/operations docs when users need to set them.
- Do not assume shell scripts automatically load `.env`. If a script needs variables, either wire them explicitly in the package script or document the exact invocation.
- For web apps, distinguish bind/listen addresses from browser-facing origins. `0.0.0.0` is a bind address only; do not use it as the canonical browser-facing URL.
- Add `APP_BASE_URL` for the browser-facing app origin used in absolute URLs, callbacks, links, previews, auth, CSRF/origin checks, and docs. In local shared previews this should be the preview hostname such as `http://app.example.dev`, not `http://0.0.0.0:<port>`.
- Add `HOSTNAME` for the browser-facing development hostname. It should be a real hostname such as `app.example.dev`, not `0.0.0.0`, `localhost`, `127.0.0.1`, or a hardcoded LAN IP unless the user explicitly chooses that as the browser-facing host.
- For Next.js apps, wire `ALLOWED_DEV_ORIGINS` into `next.config.ts` as `allowedDevOrigins`. Store it as comma-separated hostnames without protocol or port, include `HOSTNAME`, and include any local browser hosts the user will actually use such as `localhost` and `127.0.0.1`.
- When wiring the reusable cache-clear script, account for its variables: `APP_ROOT`, `NEXT_DEV_SERVICE`, and `APP_DEV_URL`. If the project uses a persistent Next service, set or document `NEXT_DEV_SERVICE=<service-name>.service` and `APP_DEV_URL=http://0.0.0.0:<port>` for the cache-clear package script or documented command.
- Keep variable names generic and project-appropriate. Avoid stale project prefixes when extracting reusable scripts or docs from another app.

## Local Development

- Reserve a local app port upfront so multiple apps can run side by side.
- Treat the selected working directory and app port as strict boundaries.
- Do not touch files outside the current app working directory unless the user explicitly authorizes it.
- Do not inspect, stop, restart, kill, or modify other apps, services, processes, directories, or ports unless the user explicitly authorizes it.
- If a task appears to require leaving the working directory, using another app's files, killing a process on another port, changing global services, or otherwise crossing the project boundary, stop and ask the user first.
- Bind local app servers to `0.0.0.0`, not `localhost`, `127.0.0.1`, LAN IPs, or other hardcoded host IPs.
- Keep the app server bind address and browser-facing hostname separate: bind/listen on `0.0.0.0`, but set `HOSTNAME` to the hostname users open in the browser.
- Add `HOSTNAME` to the ignored root `.env`, the committed `docs/deploy/.env.example`, and public development/deployment docs.
- Add `APP_BASE_URL` to the ignored root `.env`, the committed `docs/deploy/.env.example`, and public development/deployment docs. It should include scheme and hostname, plus port only when the browser-facing URL needs a port.
- Add `ALLOWED_DEV_ORIGINS` to the ignored root `.env`, the committed `docs/deploy/.env.example`, and public development docs. Use comma-separated hostnames without scheme or port, for example `localhost,127.0.0.1,app.example.dev`.
- For Next/Turbopack apps, load env in `next.config.ts` when needed and pass `ALLOWED_DEV_ORIGINS` to `allowedDevOrigins`. Parse URL-like values defensively, but normalize the final values to hostnames because Next checks the request origin hostname.
- Include `HOSTNAME` in the `allowedDevOrigins` set unless it is `0.0.0.0`; this keeps shared-preview HMR/dev resources and the Next dev indicator working through the browser-facing host.
- If the Next dev indicator or HMR is missing, inspect the dev server logs for blocked `/_next/webpack-hmr` or other Next dev-resource requests, add the reported browser-facing hostname to `ALLOWED_DEV_ORIGINS`, then restart the Next dev server.
- Ignore only the root `.env` by default.
- Store the deployment/template env file at `docs/deploy/.env.example`.
- When adding, renaming, or removing env vars, update `docs/deploy/.env.example` and relevant docs in the same change.
- Create or verify the app `.gitignore` before installing dependencies or generating files. It should ignore private memory, the root `.env`, dependencies, framework/build output, generated clients, coverage/test output, logs, local uploads, temp files, and editor noise. It must not ignore `docs/deploy/.env.example`.
- For Next/Turbopack apps, add a reusable cache-clear script during initial local-development setup, before the first handoff. Download `llm/clear-dev-cache.sh` from the personal bootstrap repo into the app's `scripts/clear-dev-cache.sh`, or add an equivalent project-local script such as `scripts/cache-clear.mjs`. Wire a package script such as `cache:clear`, document its required variables, and use that script whenever full framework/test cache clearing is needed instead of hand-running cache deletion commands.
- Distinguish automatic service-start cache cleanup from manual full cache clearing. A persistent Next dev service should clear only `.next/dev/cache/turbopack` before `npm run dev`; `npm run cache:clear` may clear broader local framework/test caches such as `.next`, `.turbo`, `.cache`, `coverage`, and `tsconfig.tsbuildinfo`, ideally after stopping the dev service and before restarting it.
- If Next/Turbopack shows stale runtime behavior, corrupted-cache errors, or inexplicable dev-server output after code changes, first restart the persistent dev service so the Turbopack dev cache is cleared. If the issue persists, run the full `npm run cache:clear` workflow.
- Use OS-level `node`, `npm`, `npx`, and `corepack` binaries provided by the user/server admin. Do not prescribe their install directory in app guidance.
- Prefer root-owned Node/npm binaries that are already on the automation PATH for assistant shells and persistent services.
- Never make app commands or persistent services depend on interactive shell startup or user-local Node installs. Always use OS-level binaries.
- Use the actual OS npm path exposed by the server when writing user-level systemd services; `/usr/local/bin/npm` is a stable default when the server admin provides that symlink.
- Treat npm global tools as separate from the OS Node runtime. Before installing an assistant or developer CLI globally, inspect `npm config get prefix`. If it points at a root-owned OS prefix such as `/opt/node` or `/usr/local`, configure a user-owned prefix first:

```bash
mkdir -p "$HOME/.local/share/npm"
npm config set prefix "$HOME/.local/share/npm"
export PATH="$HOME/.local/share/npm/bin:$PATH"
npm config get prefix
```

- Install global assistant/developer CLIs only after the prefix points to the current user's home. Project dependencies should still be local and reproducible through the project's normal `npm install` or `npm ci` workflow.
- If `npm install -g ...` fails with an error such as `EACCES: permission denied, mkdir '/opt/node/.../node_modules/...'`, fix the npm prefix as the current project user. Do not use `sudo npm install -g`, and do not change ownership or permissions on `/opt/node`, `/usr/local`, or another OS Node prefix.
- For shared previews, optionally run the app through a user-level systemd service instead of an agent-owned background process.
- Prefer the user that owns the checkout and `.env`; avoid requiring sudo for the app runtime.
- If the service must survive logout or reboot, tell the user/server admin to enable linger for the app user using the setup commands file.
- Keep the service definition project-specific but use this general shape:

```ini
[Unit]
Description=<app-name> dev server
After=default.target

[Service]
Type=simple
WorkingDirectory=/absolute/path/to/app
Environment=NODE_ENV=development
Environment=PATH=/usr/local/bin:/usr/bin:/bin
ExecStartPre=/usr/bin/rm -rf /absolute/path/to/app/.next/dev/cache/turbopack
ExecStart=/usr/local/bin/npm run dev
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
```

- Keep service `PATH` focused on OS binaries for normal app services. Add the user's npm global bin path only if the service truly invokes a user-installed global CLI; prefer project-local package scripts for app runtime commands.
- After enabling a persistent service, document the service name, unit path, restart command, log command, port, linger requirement, automatic Turbopack cache cleanup, and the full cache-clear command in public docs and private memory.
- For every deployment-affecting change, update public deployment or operations docs in the same patch. Include the affected env vars, ports, Docker services, service names, restart/log commands, migration or codegen commands, cache-clear commands, and any manual user/server-admin steps.

## Local Artifacts

- Keep screenshots, security scan outputs, archived reference files, and other operator artifacts outside the app repository unless the user explicitly asks to commit them.
- Default local artifact paths:
  - screenshots: `/home/<user>/workbench/screenshots/`
  - archived reference files: `/home/<user>/workbench/archive/`
  - security scan artifacts: `/home/<user>/workbench/security-scans/<scan_id>/`
- Do not create project-sibling folders such as `screenshots`, `archive`, `codex-security`, or `codex-security-scans` unless the user explicitly chooses that layout.

## Docker And Services

- Expect Docker to be installed from official upstream instructions before Docker-backed services are needed.
- If Docker is missing, direct the user to `llm/typescript-server-setup.md`.
- Prefer Docker's apt repository so Docker Engine and the Compose plugin are updated by apt with the rest of the server.
- If Docker appears unavailable because the current shell cannot access `/var/run/docker.sock`, inspect the socket owner and the current user's group membership before declaring Docker unusable. In some assistant desktop or sandbox sessions, the running shell may not show a newly granted `docker` group in `id`, even though the user is a member of that group.
- When `/var/run/docker.sock` is owned by `root:docker` and the current user is in the `docker` group, run Docker through a group-switched subprocess, for example:

```bash
sg docker -c "docker ps"
sg docker -c "docker compose config --quiet"
sg docker -c "docker compose up -d postgres"
```

- Do not use `sudo` for Docker. If `sg docker -c "docker ps"` fails because Docker is genuinely missing, the daemon is stopped, or the user is not in the `docker` group, stop and tell the user/server admin exactly what is missing.
- Put all local infrastructure services in one Docker Compose file.
- Name dev containers `<service>-dev`, for example `postgres-dev`, `mailpit-dev`, `redis-dev`.
- Bind exposed service ports explicitly to `0.0.0.0`.
- Use latest stable/LTS Docker image tags, not moving `latest` tags unless that tag is explicitly the stable/LTS line.
- If unsure whether an image/tag is LTS or stable, ask before continuing.

## Memory And Handoff

- Create private agent memory early, separate from public docs.
- Suggested structure: `.agents/README.md`, `.agents/current-context.md`, `.agents/preferences.md`, `.agents/plans/master-plan.md`, `.agents/session-log/YYYY-MM-DD.md`.
- Public docs should be human-facing product, development, architecture, deployment, security, operations, UI, component, and feature docs.
- Structure `/docs` upfront so it can become the source content for public user manuals, wiki pages, and deployment documentation.
- Include docs for the UI system, reusable components, feature behavior, deployment instructions, development workflow, security/privacy model, operations, and example/template files.
- Every new user-facing feature must add or update a public docs entry that explains the feature from a user/manual perspective.
- Treat the public root `README.md` as owner-controlled. Do not create, replace, or update it unless the user specifically asks for README work in that project.
- Keep docs content suitable for a future public wiki: describe what the product does and how to use/configure it, not private agent process notes.
- Public-facing app files must never state or imply that the app was built by an LLM tool, coding agent, automation, or any specific model, provider, or assistant. This applies to README files, public docs, website copy, package metadata, release notes, commit messages, PR text, screenshots, and any user-visible product copy.
- Keep agent handoff notes, prompts, implementation memory, private preferences, and process notes in `.agents`.
- Never store secrets, API keys, passwords, tokens, cookies, raw customer data, or private user data in memory.
- At the start of each session, read memory, recent logs, relevant plans, public docs, code, and git state.
- Batch private memory updates by coherent work chunk, not by every small edit.
- Treat `.agents/current-context.md` as durable handoff state. Update it after meaningful product, workflow, API, data-model, deployment, security, or repo-process changes, and before stopping with non-obvious uncommitted work. Do not update it for each tiny visual tweak, wording change, or intermediate adjustment.
- Treat today's `.agents/session-log/YYYY-MM-DD.md` as the detailed work ledger. Append one grouped entry per coherent task, usually after the task is verified or paused. Include final behavior, important decisions, and verification commands.
- For iterative styling or copy work, record the final settled direction once. Do not log every intermediate value unless the tradeoff itself will matter later.
- Commit and push `.agents` at batching points: the end of a coherent feature/task, before a handoff, or after high-impact decisions. Do not commit `.agents` after each small font, color, or spacing iteration.

## Git And Safety

- Never use `sudo`. Anything that requires `sudo` or root privileges must be sent to the user/server admin as instructions instead of executed by the assistant.
- If a dependency, binary, package, or system command is missing, stop and ask the user to install it. Tell the user exactly what is missing and, when known, point them to `llm/typescript-server-setup.md`.
- Before editing, check public repo status and memory repo status.
- If the worktree is dirty, inspect diffs before changing files.
- Treat existing changes as intentional; do not revert user changes unless explicitly asked.
- Before creating commits, tags, releases, pull requests, or pushes, verify local Git identity with `git config user.name` and `git config user.email`.
- Never commit, push, tag, release, or otherwise publish as an LLM tool, model provider, coding agent, automation, or any placeholder identity.
- Use the project owner's approved Git identity for all commits unless the user explicitly chooses a different human identity.
- If any local config, commit metadata, remote author display, generated release text, or contributor attribution would expose an automation identity, stop and fix that before publishing.
- Commit public app changes only when requested or clearly agreed.
- Keep memory commits separate from public app commits.
- Always use `gh` for GitHub work. If `gh` is missing, stop and ask the user to install it before continuing GitHub-related work.
- When updating a shared bootstrap, template, personal, or cross-project repository, do not use an arbitrary local checkout discovered on disk. Create a fresh temporary working folder from the GitHub source-of-truth branch, make the edit there, verify the diff, then push.
- Use the existing local app checkout only for the current app project, not for unrelated shared-repo updates. Remove or ignore temporary folders after the update; do not treat them as durable project state.
- If `git push` is rejected because the remote branch moved, do not force-push by reflex. Fetch/rebase onto the updated remote branch, preserve remote changes, resolve conflicts intentionally, then push.
- Use `--force-with-lease` only for explicit, accepted history rewrites or documented repository workflows.
- Run the project's configured security scanner before pushing code changes. If the scanner is unavailable, stop and ask the user to install or enable it before pushing.
- When running security scans, choose an explicit artifact directory before starting. Use the local artifact convention when present, and do not leave scanner output in ad hoc project-sibling folders.

## UI System

- Define styling conventions early.
- Store UI system decisions, visual conventions, component usage, interaction patterns, and accessibility expectations in public `/docs`.
- Treat `/docs` as the canonical source for UI documentation that can later feed public manuals/wiki pages.
- Before scaffolding app code, present a simple folder/module boundary proposal and keep it updated as the architecture evolves.
- Do not create route files, page files, feature components, UI primitives, schema files, adapters, provider modules, or other app structure files until the user has approved the initial module and folder boundaries.
- Keep the codebase structure simple and logical. Avoid repeatedly remodeling folders for each incremental feature; if the structure needs to change, explain the architectural reason and update docs in the same change.
- Prefer small, focused files over large catch-all modules. Treat 300+ hand-written lines as a split candidate and 500+ hand-written lines as a blocker unless the file is generated code, a migration, a lockfile, or simple static data.
- Maintain a lightweight codebase map in public docs once the app structure exists, preferably at `docs/architecture/codebase-map.md` when the project has public docs. It should list the main folders and important files with one-line purpose notes, without copying another project's architecture as a template.
- Update the codebase map when important files or folders are added, moved, renamed, or removed.
- Add useful role/intent comments for non-trivial files, exported boundaries, adapters, security-sensitive paths, and non-obvious logic. Avoid comments that merely restate syntax.
- Prefer Tailwind utilities for normal layout, spacing, typography, color, borders, effects, and responsive behavior.
- Use shared UI primitives before adding one-off component markup.
- When changing a shared primitive, prefer additive props with unchanged defaults. Do not change width behavior, hidden measurement nodes, DOM structure, or existing keyboard behavior to solve one local caller issue unless that exact primitive behavior change is explicitly requested.
- Use CSS Modules only for complex structural layouts that Tailwind would make harder to read.
- Keep route/page files composition-focused; move product UI into feature components.
- Use Lucide icons by default unless the project has another established icon system.
- When the user provides screenshots, mockups, or prior UI examples, treat them as visual and product references only. Before implementing, translate them into a short written UI contract covering layout regions, reusable primitives, interaction states, responsive behavior, accessibility expectations, and what must not be copied. Do not copy JSX, CSS/Tailwind class strings, state shape, file structure, or route/component names from prior implementations unless the user explicitly approves that source material.
- Avoid native `title` tooltips; use a custom tooltip pattern that can be styled and layered consistently. Tooltips should render above all UI, but do not rely on z-index alone when an ancestor can clip overflow. If any parent uses `overflow-hidden`, `overflow-auto`, scrolling, or other clipping, render the tooltip through a portal/fixed-position overlay outside the clipping container, usually attached to `document.body`, while preserving the same visual position above the trigger and the highest tooltip layer.
- Dropdowns/selects are shared UI primitives, not per-feature inventions. Define or reuse the primitive before building product screens, and update the primitive plus UI docs when behavior changes. Use only two behavior families: searchable dropdowns for long, dynamic, or user-filterable lists, and matching non-searchable dropdowns for short/static lists. Single-select and multi-select are modes inside those families, not separate visual systems. Both families must share the same visual rhythm and keyboard contract: trigger and menu keep the same natural/content-driven width, no arbitrary fixed widths, open menus do not resize while open, option text matches the trigger/button font size, spacing defaults to `h-9`, `px-3`, `p-1.5`, `gap-1`, row states use default/selected `border-transparent bg-white` with selected text/check treatment and hover/search-highlight `border-slate-200 bg-slate-50`, outside click and `Escape` close, arrows navigate, `Enter` selects, non-searchable menus support first-letter typeahead, and searchable menus focus the input on open, show all options before typing, filter only after typing, and select the sole visible result on `Enter`. Render through portal/fixed-position behavior when needed to escape clipping parents. Use [ui-component-patterns.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/ui-component-patterns.md) as the shared practical reference.
- Make accessibility part of the UI baseline from the first screen: keyboard navigation, visible focus states, accessible names for icon-only controls, semantic landmarks/forms/tables, disabled/loading/error states that remain understandable to assistive tech, and no mouse-only critical workflows.
- For UI apps, verify responsive layout and key flows with Playwright screenshots when browser dependencies are available. If browser prerequisites are missing, stop and ask the user to install them.

## Product Build Flow

- Start with the real app experience, not a marketing landing page, unless explicitly requested.
- Build in approval-gated slices. A durable default sequence is: foundation scaffold; auth/session foundation when the app has users; shared UI primitives; a static contract screen with synthetic data only; integration/configuration management; then the first real vertical slice.
- Before each meaningful implementation chunk, briefly restate the applicable guardrails: scope, out-of-scope items, data ownership, provider/external boundaries, docs updates, tests, and file-size expectations.
- After each slice, pause for review with verification results, docs/codebase-map updates, privacy checks, and a largest hand-written files report.
- After the structure and UI concept are accepted, build one small real-app screen as a thin UI over the intended contracts. Static or fake data may validate workflow, but it must not define the data model, provider boundary, route shape, or folder structure.
- After that first concept is accepted, wire real vertical slices instead of endlessly polishing mock screens.
- Demo screens may remain live temporarily for product review, but demo/reference tests should not stay in the active project test suite once production flows supersede them. If the user wants to keep them for reference, move them to the local archive outside the repo, remove them from active docs/codebase maps, and keep the live demo only until it is explicitly retired.
- Add pages when workflows demand them.
- When an app has multiple workspace, editor, detail, tab, compare, or view modes, preserve each mode's lightweight state independently. Switching modes should not clear hidden mode state by default.
- Clear saved mode state only on real context changes such as account, provider, workspace, project, filter, permission, or data-scope changes. Persist lightweight mode state through existing settings/storage when appropriate.
- For each feature, add or update public docs covering user-visible behavior, key states, configuration, and limitations.
- Include loading, empty, error, permission, and disabled states for real workflows.
- Remove confirmed leftover mock/orphan code as UI changes land, but keep planned scaffolding when it matches the architecture.
- When implementing staged edits that submit multiple fields together, distinguish loaded server data, local draft data, and the fields actually being submitted. Validation should block invalid draft/submitted fields, not unrelated stale loaded fields.
- For apps that integrate external systems, define an internal app contract and keep provider/vendor-specific code in adapters or plugins. Core product code should depend on capabilities and normalized app types, not provider names or raw provider labels.
- If a change affects data shape, permissions, external-system boundaries, or public behavior, name the migration, compatibility, and rollout impact before coding.
- External-system writes must happen only from explicit user actions or approved product workflows. Do not write to external systems from incidental rendering, loading, polling, or background reads.
- If an external write succeeds but the post-write refresh/read fails, treat it as a successful write with a warning, still invalidate or revalidate local app state, and keep write failure separate from refresh failure in user-visible states.
- External communications, such as customer messages, email, ticket replies, SMS, webhooks, or provider comments, must go only through approved product workflows and channels.
- Fix review findings as focused cleanup commits. Avoid opportunistic redesign or scope expansion, add the smallest regression test that proves the bug is fixed, and rerun targeted checks plus the normal verification set.
- For model or AI integrations, prefer protocol-family adapters over one-off integrations for each model/vendor whenever providers expose compatible APIs.
- For data-heavy workflows, avoid uncoordinated client fanout and duplicated setup work. Use coordinated loading from the app's perspective, let provider-specific optimizations live inside adapters/plugins, and benchmark before and after performance-sensitive changes.

## Verification

Before calling work complete, run the relevant checks:

- dependency install when needed;
- generated clients/codegen when relevant;
- lint;
- typecheck;
- tests;
- build;
- dependency audit;
- Docker Compose config validation;
- browser/responsive verification for UI work when browser tooling is available;
- targeted scans for forbidden hostnames, secrets, unsafe behavior, provider leakage, and oversized catch-all files.

Document any checks that could not be run.
