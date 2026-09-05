# TypeScript Project Profile

Use this conditional technical reference only under the [Vibe-Coded Project Foundation](../1-vibe-coding-foundation.md) and its active bootstrap or continuation route. It is not a workflow and grants no authority. It cannot change lifecycle state, permissions, repository ownership, verification obligations, publication order, deployment boundaries, or any other requirement in Files 1–4.

Retrieve this file completely at an exact revision when TypeScript is required, detected in preserved project material, or becomes a credible candidate for the recommended technology baseline. The foundation and approved project contracts retain their defined precedence. Stop applying and surface any text that conflicts or appears to conflict with them.

The TypeScript sections apply whenever this profile is selected. The Next.js sections apply only when Next.js is independently required, detected, or a credible candidate. TypeScript alone never selects Next.js, and considering Next.js never silently selects TypeScript.

## Adoption Contract

During bootstrap:

1. inspect product needs, deployment constraints, existing material, team capability, and credible alternatives before selecting TypeScript;
2. verify the current runtime, compiler, package manager, framework, library, and tool versions from primary sources;
3. include proposed TypeScript choices, conditional Next.js choices, exceptions, and rejected alternatives in the complete pre-scaffold proposal;
4. apply them only after proposal approval; and
5. write accepted choices into the application's canonical architecture, development, verification, configuration, deployment, and operations documentation as applicable.

For an established project, inspect its `package.json`, lockfile, `tsconfig` inheritance, build configuration, lint rules, generated sources, tests, and documented conventions before recommending change. Existing approved contracts and compatible implementation remain canonical. Do not reconfigure the project merely to match this profile.

Later sessions use the project-local contracts. Reconsult this profile only when a relevant local contract is missing, the work changes project-wide TypeScript or applicable Next.js conventions, or the owner asks to reconsider the baseline.

## Compiler And Module Baseline

- Enable TypeScript's supported strict mode for new projects. Evaluate additional strictness options such as unchecked indexed access and exact optional-property semantics against the selected libraries, generated code, and migration cost; document each adopted option and exception.
- Keep the runtime, `package.json` module type, compiler module and resolution settings, bundler, test runner, emitted format, file extensions, aliases, and deployment environment compatible. Do not mix CommonJS and ESM accidentally.
- Use one intentional `tsconfig` inheritance structure. Give application, test, script, generated, and build configurations explicit ownership when their requirements differ.
- Keep production type checking independent from editor-only behaviour. A transpiler or framework build that skips semantic checking does not replace the project's typecheck gate.
- Exclude generated output, dependencies, caches, coverage, temporary files, and secrets consistently across TypeScript, build, lint, test, Git, and container contexts.

Record the exact typecheck entry point and whether the project emits JavaScript, declarations, both, or neither.

## Type Ownership And Boundaries

- Prefer inference inside cohesive implementations and explicit types at exported, persisted, provider, package, and cross-module boundaries.
- Use domain vocabulary for authoritative application types. Provider payloads, database records, transport objects, form state, and view models remain distinct when they have different ownership or invariants.
- Do not create a global dumping ground for unrelated types. Keep types beside their owning capability or in a deliberately bounded shared contract.
- Model finite states and results with discriminated unions when that prevents invalid combinations. Keep optional properties for genuinely optional data, not as a substitute for defined state transitions.
- Preserve readonly intent where callers must not mutate shared values. Do not add deep-readonly complexity without a demonstrated ownership need.
- Prefer `unknown` at untrusted boundaries and narrow it deliberately. `any` requires a concrete, documented interoperability reason and must not spread beyond its boundary adapter.
- Do not use type assertions or non-null assertions merely to silence errors. Validate, narrow, redesign the contract, or document the proven invariant at the narrowest safe location.
- Avoid type-level cleverness that makes ordinary maintenance harder. Split complex generic relationships by responsibility and expose the smallest stable public surface.

## Runtime Validation

TypeScript types do not validate runtime data. Validate and normalize untrusted values at each authoritative boundary, including:

- environment and configuration input;
- HTTP, form, file, command-line, webhook, and message input;
- database values not already protected by a compatible trusted contract;
- provider responses and events;
- deserialized cache, local-storage, queue, and persisted-job payloads; and
- versioned imports or migrations.

Keep the validation schema, normalized application type, error mapping, and ownership boundary aligned. Derive types from schemas or schemas from types only when the selected tool preserves the required runtime guarantees; do not maintain two drifting definitions without verification.

## Functions, Errors, And Asynchronous Work

- Give exported functions intentional input and output contracts. Avoid boolean flags that hide unrelated behaviours; prefer named options or separate operations.
- Represent expected domain failure explicitly at the owning boundary. Preserve causal information for diagnostics without exposing sensitive provider or internal details to users.
- Do not ignore or float promises. Define cancellation, timeout, retry, concurrency, and idempotency behaviour under the relevant foundation sections before introducing background or external work.
- Keep pure calculations separate from I/O when that materially improves verification, reuse, or deterministic testing.
- Inject clocks, randomness, identifiers, and external adapters where deterministic behaviour or testing requires control.

## Generated And Third-Party Types

- Treat generated clients and types as generated artifacts with a documented source, command, version, output location, reproducibility check, and codebase-map role.
- Never hand-edit generated output unless the generator explicitly owns an approved extension region.
- Normalize provider and generated types at adapters instead of leaking them through core product modules.
- Verify library types against actual runtime behaviour and official documentation. A declaration file does not prove provider guarantees or validate external data.
- Keep dependency versions, the selected package manager, manifest, lockfile, scripts, CI, documentation, and deployment commands consistent.

## TypeScript Verification Contract

The project verification matrix determines exact commands and milestones. For applicable TypeScript work, define and run:

- reproducible dependency installation and lockfile validation;
- compiler/typecheck;
- lint rules that enforce adopted safety boundaries, including promise handling when supported;
- focused tests for changed behaviour and boundary validation;
- application or package build;
- generated-code drift checks when generation is used; and
- declaration/API compatibility checks when publishing a library or stable internal package.

Do not claim TypeScript safety from a successful transpilation alone. Record exceptions and omitted checks under the foundation's evidence requirements.

## TypeScript Project-Local Handoff

Before bootstrap retirement, ensure the application repository records:

- runtime, TypeScript, package-manager, and toolchain choices;
- module system and compiler configuration ownership;
- type and runtime-validation boundaries;
- generated-code ownership and commands;
- exact install, lint, typecheck, test, and build entry points;
- accepted exceptions and their rationale; and
- any separately adopted framework contract.

Store project decisions, not a copy of this reusable profile. Future profile revisions must never redesign an established application silently.

## Next.js — Only When Applicable

Apply this section only when Next.js is independently required, detected in preserved project material, or becomes a credible candidate for the recommended baseline. Do not select it merely because the product has a web UI or uses TypeScript.

### Adoption And Existing Projects

Before recommending Next.js, verify from primary sources the currently supported framework, React, Node runtime, package-manager, lint, test, browser, data-layer, and deployment combinations. Compare Next.js with the smallest credible alternatives for the actual product and deployment target.

For a new project, include router choice, rendering model, server/client boundaries, persistence shape, deployment target, caching, environment contract, verification, and optional service shape in the complete bootstrap proposal.

For an established project, inspect its existing router, configuration, routes, runtime declarations, middleware, server/client boundaries, caching directives, environment handling, scripts, lockfile, deployment files, and framework conventions. Do not migrate routers, rewrite working boundaries, or replace established configuration merely to match this profile.

After approval, store accepted decisions in the application repository. Later sessions use those local contracts and consult this section again only for a relevant gap or an explicitly requested baseline review.

### Application Boundaries

- Keep route, layout, page, handler, action, and middleware entry points thin. They adapt framework input and output and call the owning application boundary.
- Organize product behaviour around cohesive capabilities rather than the framework's folders alone.
- Define server-only, client-only, shared, build-time, request-time, and background responsibilities explicitly. Prevent server secrets, privileged adapters, and unrestricted data access from entering client bundles.
- Treat route handlers, server actions, forms, uploads, search parameters, cookies, headers, and middleware input as untrusted boundaries. Validate input and enforce authorization server-side.
- Do not perform consequential external writes during render, prefetch, metadata generation, loading, cache refresh, health checks, or incidental effects.
- Use framework conventions where they preserve the application's ownership model. Do not place business rules in a framework hook or entry point merely because it is convenient.

### Rendering, Data, And Caching

Choose rendering and data-access behaviour from product freshness, privacy, latency, availability, and deployment needs. Record which routes or reads are static, dynamic, streamed, cached, revalidated, or client-refreshed and why.

- A framework cache is not a source of truth and must follow the foundation's identity, permission, freshness, invalidation, and stale-data rules.
- Never cache authorization decisions or sensitive results without every required visibility identity and an approved protection contract.
- Make mutation ownership explicit. Commit authoritative state before dependent external effects and invalidate or refresh caches only from confirmed outcomes.
- Avoid client request fan-out when a server/application boundary can return a consumer-shaped result safely.
- Bound pagination, payloads, timeouts, cancellation, retries, and background refresh.
- Verify framework caching and invalidation behaviour for the selected version from official documentation; do not rely on remembered defaults.

Keep ORM, database, provider, and transport records behind their owning adapters. Next.js does not require a particular database, ORM, queue, authentication provider, or hosting platform.

### Configuration And Environment

Define and validate every application setting under the foundation's configuration contract.

- Distinguish server-only secrets from values intentionally exposed to the browser. Treat public-prefix variables as published build/runtime interface, never as secret storage.
- Distinguish the server bind address from the browser-facing application origin. `0.0.0.0` may be a bind address but is not a canonical browser URL.
- Define allowed development origins, proxies, forwarded headers, cookies, callback URLs, and trusted hosts only when required by the selected topology.
- Keep local defaults, test values, container addresses, public origins, and production configuration explicit rather than deriving one environment from another accidentally.
- Keep typed validation, safe examples, deployment definitions, tests, and operations documentation synchronized.

Do not copy environment-variable names, ports, domains, database names, service names, or prefixes from another project.

### Package And Build Contract

- Use the package manager approved for the project and keep its manifest, lockfile, scripts, CI, container, service, and documentation commands consistent.
- Inspect generated scaffold defaults deliberately. Remove unused examples, assets, dependencies, telemetry choices, and placeholder behaviour rather than treating them as product decisions.
- Keep `.next`, other build output, caches, dependencies, coverage, local uploads, logs, private environment files, generated clients where appropriate, and editor noise untracked.
- Record separate development, lint, typecheck, focused-test, complete-test, build, and start entry points as applicable.
- Confirm that the production build performs every required semantic check; run the separate typecheck or lint gate when the framework build does not.
- Verify selected runtime and deployment features against the actual target. Do not assume a capability available on one managed platform exists in a container or self-hosted Node process.

### Local Infrastructure

Application bootstrap owns only approved project infrastructure. Machine and user provisioning belongs to the optional [Development Server Setup](../server/setup.md) reference.

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

### Development Cache Recovery

For a Next.js/Turbopack development project, adopt a project-local cache-recovery command only when repeated cache problems justify it. The guarded [`clear-next-dev-cache.sh`](../scripts/clear-next-dev-cache.sh) is a reusable template, not a command to run from this repository.

When adopted:

- copy it to the application's `scripts/` directory and expose it through the chosen package manager;
- document `APP_ROOT`, `NEXT_DEV_SERVICE`, `APP_DEV_URL`, and the unmanaged-process confirmation;
- stop the matching service or confirm that all processes using the checkout are stopped before broad removal;
- never use elevated privileges or kill arbitrary processes; and
- verify restart and readiness when the script manages a service.

Automatic service-start cleanup should target only the proven disposable cache required for startup. Broader `.next` removal belongs to this explicit stopped-service recovery workflow.

### Next.js Verification And Handoff

Add exact applicable checks to the project's verification matrix, including:

- reproducible dependency installation and lockfile validation;
- lint and independent TypeScript checking when TypeScript is selected;
- focused and broader tests determined by consumer impact;
- production build;
- environment/configuration validation;
- framework boundary or architecture checks when automated;
- Compose validation when Compose changes;
- service-unit verification when a unit changes; and
- approved browser, visual, accessibility, integration, dependency, and security checks when triggered.

Before bootstrap retirement, ensure canonical project documentation records the router/rendering approach, module ownership, server/client and trust boundaries, caching/freshness decisions, environment interface, deployment/process shape, cache recovery, exact verification commands, and known exceptions. Do not store a copy of this profile as the project contract.
