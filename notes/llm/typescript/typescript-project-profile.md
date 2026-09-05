# TypeScript Project Profile

Use this conditional technical reference only under the [Vibe-Coded Project Foundation](../vibe-coding/1-vibe-coding-foundation.md) and its active bootstrap or continuation route. It is not a workflow and grants no authority. It cannot change lifecycle state, permissions, repository ownership, verification obligations, publication order, deployment boundaries, or any other requirement in Files 1–4.

Retrieve this file completely at an exact revision when TypeScript is required, detected in preserved project material, or becomes a credible candidate for the recommended technology baseline. The foundation and approved project contracts retain their defined precedence. Stop applying and surface any text that conflicts or appears to conflict with them.

## Adoption Contract

During bootstrap:

1. inspect product needs, deployment constraints, existing material, team capability, and credible alternatives before selecting TypeScript;
2. verify the current runtime, compiler, package manager, framework, library, and tool versions from primary sources;
3. include proposed TypeScript choices, exceptions, and rejected alternatives in the complete pre-scaffold proposal;
4. apply them only after proposal approval; and
5. write accepted choices into the application's canonical architecture, development, verification, and configuration documentation.

For an established project, inspect its `package.json`, lockfile, `tsconfig` inheritance, build configuration, lint rules, generated sources, tests, and documented conventions before recommending change. Existing approved contracts and compatible implementation remain canonical. Do not reconfigure the project merely to match this profile.

Later sessions use the project-local contracts. Reconsult this profile only when a relevant local contract is missing, the work changes project-wide TypeScript conventions, or the owner asks to reconsider the baseline.

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

## UI-Specific TypeScript

When a TypeScript project has a UI, the foundation and the project's local UI contract own behaviour, accessibility, responsiveness, and visual decisions. The [Web UI Component Patterns](../vibe-coding/references/web-ui-component-patterns.md) is a separate conditional seed.

TypeScript-specific implementation should:

- type component inputs and emitted events at their ownership boundary;
- model loading, empty, ready, validation, submission, failure, and conflict states without impossible combinations;
- distinguish persisted domain values from temporary form and presentation state;
- avoid broad component types that accept invalid prop combinations;
- preserve framework-supported inference instead of restating library types unnecessarily; and
- keep browser-only values and APIs out of server-only modules and vice versa.

Framework-specific rendering, caching, routing, and server/client rules belong in the matching framework profile and project-local contract.

## Verification Contract

The project verification matrix determines exact commands and milestones. For applicable TypeScript work, define and run:

- reproducible dependency installation and lockfile validation;
- compiler/typecheck;
- lint rules that enforce adopted safety boundaries, including promise handling when supported;
- focused tests for changed behaviour and boundary validation;
- application or package build;
- generated-code drift checks when generation is used; and
- declaration/API compatibility checks when publishing a library or stable internal package.

Do not claim TypeScript safety from a successful transpilation alone. Record exceptions and omitted checks under the foundation's evidence requirements.

## Project-Local Handoff

Before bootstrap retirement, ensure the application repository records:

- runtime, TypeScript, package-manager, and toolchain choices;
- module system and compiler configuration ownership;
- type and runtime-validation boundaries;
- generated-code ownership and commands;
- exact install, lint, typecheck, test, and build entry points;
- accepted exceptions and their rationale; and
- any separate framework or UI contract adopted for the project.

Store project decisions, not a copy of this reusable profile. Future profile revisions must never redesign an established application silently.
