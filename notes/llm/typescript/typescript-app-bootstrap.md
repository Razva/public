# TypeScript App Bootstrap

Use this file once when creating a new TypeScript application. It consumes a prepared development environment, establishes the app’s initial contracts, creates the first verified scaffold, and then hands ongoing work to [new-session.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/new-session.md).

If machine or user prerequisites are missing, stop and direct the user or server administrator to [typescript-server-setup.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-server-setup.md). Do not perform root-level provisioning from this workflow.

Use [ui-component-patterns.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/ui-component-patterns.md) as a reusable UI reference during bootstrap. Once the app adopts and documents its own UI contract, the project-local contract becomes canonical.

## Lifecycle Boundary

This bootstrap owns:

- initial product and project discovery;
- server-readiness verification;
- stack and version selection;
- repository and app scaffolding;
- initial architecture, configuration, documentation, and private memory;
- project Docker Compose services;
- an optional app-specific user-systemd unit;
- initial verification and handoff.

This bootstrap does not own:

- operating-system, Node, Docker, npm-prefix, SSH, or user provisioning;
- recurring implementation policy after the initial handoff;
- detailed reusable component contracts already owned by `ui-component-patterns.md`;
- ongoing server monitoring or maintenance.

## Bootstrap Role

- Act as a pragmatic senior technical cofounder during discovery and scaffold creation.
- Challenge unclear product, architecture, privacy, deployment, and maintenance assumptions when they materially affect the foundation.
- Prefer the smallest durable foundation that can support the first real product slice.
- Do not build product behavior during bootstrap unless the user explicitly expands the scope.
- Treat diagnostic questions as read-only until the user explicitly requests a change.

## Startup Sequence

Do not scaffold, install dependencies, create repositories, or write project files until these steps are complete:

1. Collect project identity.
2. Collect the product baseline.
3. Verify the server-readiness contract.
4. Verify the planned stack and compatible versions from primary sources.
5. Present the proposed stack, folder/module boundaries, bootstrap scope, and excluded work.
6. Wait for the user’s approval before scaffolding.

If a local directory or remote repository already exists, inspect its structure, docs, Git status, and recent changes first. Do not overwrite an existing project shape blindly.

For replacement or clean-room apps, treat older implementations as product research only. Do not inspect, copy, port, or inherit old source code, schemas, routes, state shapes, class strings, or file structures unless the user explicitly authorizes that source material.

## Project Identity

Ask all identity questions together:

- final product name;
- local project path;
- GitHub owner and repository name;
- package/app identifier;
- default development port;
- deployment target;
- whether private agent memory is needed and where it should live;
- whether public docs should be created immediately;
- initial icon/brand direction and icon library.

Use the accepted identity consistently in package metadata, UI copy, docs, Docker resources, database defaults, service names, and private memory.

## Product Baseline

Before choosing implementation details, establish:

- product goal and target users;
- MVP workflow;
- authentication and privacy requirements;
- required external systems;
- deployment and operational constraints;
- explicit out-of-scope items;
- replacement-project lessons that are genuine product requirements rather than legacy implementation details.

Convert the answers into a short product and implementation baseline before scaffolding.

## Verify Server Readiness

Verify capabilities; do not repair machine/user provisioning here.

```bash
command -v git
command -v gh
command -v rg
command -v jq
command -v node
command -v npm
command -v npx
command -v corepack
git --version
gh --version
gh auth status
node --version
npm --version
npx --version
corepack --version
npm config get prefix
```

If the planned app needs Docker, also verify:

```bash
docker --version
docker compose version
docker info
```

If the app will use a persistent user service, also verify:

```bash
loginctl show-user "$USER" --property=Linger
systemctl --user is-system-running
```

If any required capability is missing or misconfigured, stop and point to `typescript-server-setup.md`. Do not use `sudo`, change system ownership, configure Docker groups, replace system Node, or repair the user’s npm prefix from app bootstrap.

Browser tooling is optional. Check or install a project browser dependency only if browser automation was explicitly selected for the app.

## Stack And Version Baseline

- Use this workflow primarily for TypeScript apps, especially full-stack Next.js, Prisma, and Postgres-style projects.
- Present the planned runtime, framework, package manager, data layer, database, linting, test tooling, and Docker images before scaffolding.
- Verify current versions and compatibility from official docs, package registries, or other primary sources. Do not rely on memory for latest/LTS claims.
- Prefer the current LTS/stable line. When components conflict, use the newest compatible combination and explain the constraint.
- Do not silently keep stale versions emitted by scaffolding tools.
- Default to npm unless the user chooses another package manager. Keep the package manager, lockfile, scripts, docs, and service commands consistent.

## Initial Architecture And Scaffold

Before creating files, present a simple folder/module proposal covering:

- route/page composition;
- product features;
- UI primitives;
- domain contracts and types;
- data access and validation;
- external-system adapters;
- tests;
- public docs and private memory.

After approval:

- create or verify `.gitignore` before dependency installation or generation;
- ignore the root `.env`, private memory, dependencies, build output, generated clients, coverage, logs, uploads, temp files, and editor noise;
- keep the committed environment template at `docs/deploy/.env.example`;
- install app dependencies locally and reproducibly through the selected package manager;
- keep provider/vendor-specific code behind adapters or plugins;
- keep route/page files composition-focused;
- create `docs/architecture/codebase-map.md` after the initial structure exists;
- do not create a marketing landing page unless the user requested one.

Initialize a local Git repository only when it is part of the accepted bootstrap scope. Do not commit, push, or create a remote repository unless the user explicitly requests the corresponding external action. Before any Git publication, verify the approved human identity and inspect the exact diff.

## Configuration And Local Development

- Treat every environment variable as part of the app interface: define its purpose, required/default state, consumer, validation, template entry, and documentation.
- Keep secrets only in the ignored root `.env` or an approved secret manager. Never put secrets in committed templates, docs, logs, or memory.
- Distinguish the bind address from the browser-facing origin. A shared dev server may bind to `0.0.0.0`, but `0.0.0.0` is not a browser-facing hostname or canonical URL.
- When applicable, define project-appropriate variables such as `HOSTNAME`, `APP_BASE_URL`, and `ALLOWED_DEV_ORIGINS`; do not copy stale prefixes or hostnames from another app.
- Update typed env validation, `docs/deploy/.env.example`, and relevant docs together.
- Reserve the development port and working directory as project boundaries. Do not inspect, stop, restart, or modify other apps or ports without explicit authorization.
- Use OS-level Node/npm binaries supplied by server setup. App commands and persistent services must not depend on interactive shell startup.

For Next/Turbopack apps, add a project-local cache-clear workflow during bootstrap. Reuse [clear-dev-cache.sh](https://github.com/Razva/public/blob/main/notes/llm/typescript/clear-dev-cache.sh) or an equivalent project-local script, expose it through a package script, and document its variables and stop/clear/restart behavior.

Automatic service-start cleanup should remove only `.next/dev/cache/turbopack`. Broader cache clearing may remove `.next`, `.turbo`, `.cache`, coverage, and TypeScript build state only after the matching dev service is stopped or from a separate checkout/worktree.

## Project Docker Compose

Server setup owns Docker installation and user access. App bootstrap owns only project infrastructure:

- keep local infrastructure in one Compose file unless the architecture requires a documented split;
- use stable/LTS image tags instead of unreviewed moving tags;
- name resources consistently from the accepted project identity;
- document containers, volumes, networks, health checks, ports, and startup order;
- bind exposed ports only as broadly as the intended access requires;
- validate the final Compose configuration before handoff.

If Docker fails because it is missing, stopped, or inaccessible to the user, stop and return to server setup rather than adding `sudo` or `sg docker` workarounds to the app.

## UI Foundation

- Choose and document the styling approach, icon system, accessibility baseline, and primitive strategy before building product screens.
- Review the reusable contracts in `ui-component-patterns.md` and adopt only the patterns relevant to the project.
- Record adopted and project-specific decisions in the app’s local UI documentation.
- Treat the app’s local UI documentation and implemented primitives as canonical after bootstrap. The public patterns file is a reusable seed, not a remote override.
- Build or approve shared primitives before using them in feature screens.
- Do not reproduce detailed component behavior contracts in this bootstrap file.
- Translate screenshots and mockups into a short written UI contract. Do not copy another app’s JSX, classes, state shape, routes, or file structure without explicit authorization.

## Optional Project Codex Configuration

User-wide Codex defaults belong to server/user setup. If the app needs shared project-specific settings, place only those overrides in `.codex/config.toml` after the project is reviewed and trusted.

Do not store secrets in Codex configuration. Do not pin copied model names or plugin configuration without verifying the current official Codex documentation.

## Optional Persistent App Service

Create a project service only after:

- the app path and user are final;
- the selected port is documented;
- the package script works interactively;
- server setup has enabled user-systemd and linger when persistence across logout/reboot is required.

Create the unit as the app-owning user:

```bash
mkdir -p "$HOME/.config/systemd/user"
nano "$HOME/.config/systemd/user/<app>.service"
```

General Next.js development shape:

```ini
[Unit]
Description=<app> development server
After=default.target

[Service]
Type=simple
WorkingDirectory=/absolute/path/to/app
Environment=NODE_ENV=development
Environment=PORT=<port>
Environment=NEXT_TELEMETRY_DISABLED=1
Environment=PATH=/usr/local/bin:/usr/bin:/bin
ExecStartPre=/usr/bin/rm -rf /absolute/path/to/app/.next/dev/cache/turbopack
ExecStart=/usr/local/bin/npm run dev
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
```

Adapt the unit to the selected framework and actual system binary paths. Keep project dependencies behind package scripts; add the user npm-global bin path only if the service truly invokes a user-installed global CLI.

Verify and start it:

```bash
systemd-analyze --user verify "$HOME/.config/systemd/user/<app>.service"
systemctl --user daemon-reload
systemctl --user enable --now <app>.service
systemctl --user status <app>.service
journalctl --user -u <app>.service -f
```

Document the unit path, service name, port, environment source, start/stop/restart commands, log command, linger requirement, automatic startup cleanup, and manual full-cache workflow in the app’s public operations docs and private handoff memory.

## Initial Docs And Private Memory

Create only the documentation the accepted foundation needs:

- product/master brief;
- architecture overview and codebase map;
- development and deployment setup;
- environment template and variable reference;
- security/privacy boundary;
- UI contract and adopted component patterns;
- operations notes for Docker and an optional app service.

Keep public docs human-facing and suitable for future manuals or wiki content. Do not mention assistant/model authorship in public product files, package metadata, commits, releases, or user-visible copy.

If private agent memory was selected, create a minimal durable structure such as:

```text
.agents/README.md
.agents/current-context.md
.agents/preferences.md
.agents/plans/master-plan.md
.agents/session-log/YYYY-MM-DD.md
```

Keep private process and handoff state out of public docs. Never store credentials, tokens, cookies, raw customer data, or private payloads in memory.

## Initial Verification And Handoff

Run only checks relevant to the scaffold:

- dependency installation and lockfile consistency;
- generated clients/codegen when relevant;
- lint;
- typecheck;
- focused tests;
- build;
- Docker Compose config validation when Compose was added;
- service-unit verification when a user service was added;
- dependency audit when dependencies were introduced.

Do not run Playwright, browser automation, screenshots, or heavyweight repository security scans unless the user explicitly requests them for this bootstrap. Do not launch repeated security scans after code changes unless explicitly requested.

Before adding product behavior, pause and show:

- accepted product and stack baseline;
- folder tree excluding dependencies/generated output;
- important created files with one-line purposes;
- codebase map;
- Git status and diff summary;
- checks and results;
- optional Docker/service state;
- known gaps and decisions still needed.

After the user accepts the foundation, stop using this bootstrap prompt. Use the project’s canonical docs, private handoff state, and [new-session.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/new-session.md) for subsequent implementation sessions.
