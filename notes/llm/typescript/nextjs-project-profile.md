# Next.js Project Profile

Use this conditional technical reference only when Next.js is required, detected in preserved project material, or becomes a credible candidate for the recommended baseline. TypeScript alone does not make Next.js applicable.

This file is not a workflow and grants no authority. Apply it only under the [Vibe-Coded Project Foundation](../vibe-coding/1-vibe-coding-foundation.md), the active bootstrap or continuation route, the [TypeScript Project Profile](typescript-project-profile.md) when TypeScript is selected, and approved project contracts. Stop applying and surface any text that conflicts or appears to conflict with those sources.

## Adoption And Existing Projects

Before recommending Next.js, verify from primary sources the currently supported framework, React, Node runtime, package-manager, lint, test, browser, data-layer, and deployment combinations. Compare Next.js with the smallest credible alternatives for the actual product and deployment target; do not select it merely because the product has a web UI.

For a new project, include router choice, rendering model, server/client boundaries, persistence shape, deployment target, caching, environment contract, verification, and optional service shape in the complete bootstrap proposal.

For an established project, inspect its existing router, configuration, routes, runtime declarations, middleware, server/client boundaries, caching directives, environment handling, scripts, lockfile, deployment files, and framework conventions. Do not migrate routers, rewrite working boundaries, or replace established configuration merely to match this profile.

After approval, store accepted decisions in the application repository. Later sessions use those local contracts and consult this profile again only for a relevant gap or an explicitly requested baseline review.

## Application Boundaries

- Keep route, layout, page, handler, action, and middleware entry points thin. They adapt framework input and output and call the owning application boundary.
- Organize product behaviour around cohesive capabilities rather than the framework's folders alone.
- Define server-only, client-only, shared, build-time, request-time, and background responsibilities explicitly. Prevent server secrets, privileged adapters, and unrestricted data access from entering client bundles.
- Treat route handlers, server actions, forms, uploads, search parameters, cookies, headers, and middleware input as untrusted boundaries. Validate input and enforce authorization server-side.
- Do not perform consequential external writes during render, prefetch, metadata generation, loading, cache refresh, health checks, or incidental effects.
- Use framework conventions where they preserve the application's ownership model. Do not place business rules in a framework hook or entry point merely because it is convenient.

## Rendering, Data, And Caching

Choose rendering and data-access behaviour from product freshness, privacy, latency, availability, and deployment needs. Record which routes or reads are static, dynamic, streamed, cached, revalidated, or client-refreshed and why.

- A framework cache is not a source of truth and must follow the foundation's identity, permission, freshness, invalidation, and stale-data rules.
- Never cache authorization decisions or sensitive results without every required visibility identity and an approved protection contract.
- Make mutation ownership explicit. Commit authoritative state before dependent external effects and invalidate or refresh caches only from confirmed outcomes.
- Avoid client request fan-out when a server/application boundary can return a consumer-shaped result safely.
- Bound pagination, payloads, timeouts, cancellation, retries, and background refresh.
- Verify framework caching and invalidation behaviour for the selected version from official documentation; do not rely on remembered defaults.

Keep ORM, database, provider, and transport records behind their owning adapters. Next.js does not require a particular database, ORM, queue, authentication provider, or hosting platform.

## Configuration And Environment

Define and validate every application setting under the foundation's configuration contract.

- Distinguish server-only secrets from values intentionally exposed to the browser. Treat public-prefix variables as published build/runtime interface, never as secret storage.
- Distinguish the server bind address from the browser-facing application origin. `0.0.0.0` may be a bind address but is not a canonical browser URL.
- Define allowed development origins, proxies, forwarded headers, cookies, callback URLs, and trusted hosts only when required by the selected topology.
- Keep local defaults, test values, container addresses, public origins, and production configuration explicit rather than deriving one environment from another accidentally.
- Keep typed validation, safe examples, deployment definitions, tests, and operations documentation synchronized.

Do not copy environment-variable names, ports, domains, database names, service names, or prefixes from another project.

## Package And Build Contract

- Use the package manager approved for the project and keep its manifest, lockfile, scripts, CI, container, service, and documentation commands consistent.
- Inspect generated scaffold defaults deliberately. Remove unused examples, assets, dependencies, telemetry choices, and placeholder behaviour rather than treating them as product decisions.
- Keep `.next`, other build output, caches, dependencies, coverage, local uploads, logs, private environment files, generated clients where appropriate, and editor noise untracked.
- Record separate development, lint, typecheck, focused-test, complete-test, build, and start entry points as applicable.
- Confirm that the production build performs every required semantic check; run the separate typecheck or lint gate when the framework build does not.
- Verify selected runtime and deployment features against the actual target. Do not assume a capability available on one managed platform exists in a container or self-hosted Node process.

## UI And Accessibility

The foundation and the application's `docs/ui/` contract own UI behaviour. During bootstrap, consult the [Web UI Component Patterns](../vibe-coding/references/web-ui-component-patterns.md) and adopt only relevant patterns through the approved proposal.

- Build or approve shared primitives before repeating complex interaction markup across features.
- Preserve server/client boundaries without sacrificing semantic HTML, keyboard operation, focus, assistive-technology status, error recovery, or container-aware responsiveness.
- Model loading, empty, error, disabled, permission, saving, saved, dirty, and conflict states deliberately.
- Treat hydration errors, layout shifts, stale client state, and older asynchronous responses as correctness issues when they can change user-visible meaning or lose work.
- Browser automation, screenshots, and visual-baseline changes remain subject to the project's approved verification contract and foundation authority boundary.

## Local Infrastructure

Application bootstrap owns only approved project infrastructure. Machine and user provisioning belongs to [Node And TypeScript Development Server Setup](../development-server/node-typescript-server-setup.md).

When local containers are selected:

- keep the smallest coherent Compose shape;
- use verified supported image versions rather than unreviewed moving tags;
- name resources from the accepted project identity;
- document volumes, networks, health checks, port exposure, dependency readiness, backup, and recovery; and
- validate the final Compose configuration through the project verification entry point.

When a persistent user service is selected:

- verify that the final app path, user, package script, environment source, and reserved port work interactively first;
- require server setup to provide a working user manager and linger when the service must survive logout or reboot;
- use absolute paths and a non-interactive runtime path;
- document service identity, start/stop/restart, logs, health, cache behaviour, and recovery in the application's operations contract; and
- verify the exact unit before enabling or starting it.

Creating, enabling, restarting, or inspecting a service remains an operational action requiring the authority defined by the foundation and project contract.

An approved development-service unit may use this general shape after every placeholder and binary path is resolved from the actual project and server:

```ini
[Unit]
Description=<application> development server
After=default.target

[Service]
Type=simple
WorkingDirectory=<absolute-application-path>
Environment=NODE_ENV=development
Environment=PORT=<reserved-port>
Environment=NEXT_TELEMETRY_DISABLED=1
Environment=PATH=/usr/local/bin:/usr/bin:/bin
ExecStartPre=/usr/bin/rm -rf <absolute-application-path>/.next/dev/cache/turbopack
ExecStart=/usr/local/bin/npm run dev
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
```

Adapt the command, environment source, telemetry decision, cache target, runtime path, restart policy, and health procedure to the approved project. Verify the unit with `systemd-analyze --user verify` before any separately authorized enable or start action.

## Development Cache Recovery

For a Next.js/Turbopack development project, adopt a project-local cache-recovery command only when repeated cache problems justify it. The guarded [`clear-next-dev-cache.sh`](scripts/clear-next-dev-cache.sh) is a reusable template, not a command to run from this repository.

When adopted:

- copy it to the application's `scripts/` directory and expose it through the chosen package manager;
- document `APP_ROOT`, `NEXT_DEV_SERVICE`, `APP_DEV_URL`, and the unmanaged-process confirmation;
- stop the matching service or confirm that all processes using the checkout are stopped before broad removal;
- never use elevated privileges or kill arbitrary processes; and
- verify restart and readiness when the script manages a service.

Automatic service-start cleanup should target only the proven disposable cache required for startup. Broader `.next` removal belongs to this explicit stopped-service recovery workflow.

## Verification And Handoff

Add exact applicable checks to the project's verification matrix, including:

- reproducible dependency installation and lockfile validation;
- lint and independent TypeScript checking;
- focused and broader tests determined by consumer impact;
- production build;
- environment/configuration validation;
- framework boundary or architecture checks when automated;
- Compose validation when Compose changes;
- service-unit verification when a unit changes; and
- approved browser, visual, accessibility, integration, dependency, and security checks when triggered.

Before bootstrap retirement, ensure canonical project documentation records the router/rendering approach, module ownership, server/client and trust boundaries, caching/freshness decisions, environment interface, deployment/process shape, cache recovery, exact verification commands, and known exceptions. Do not store a copy of this profile as the project contract.
