# Vibe-Coded Project Bootstrap

Supply the [Vibe-Coded Project Foundation](https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/1-vibe-coding-foundation.md) first. Then supply this complete workflow exactly once to establish a new application or complete an appropriate partial bootstrap. Bootstrap remains active until the owner approves and retires it.

The canonical copy is [Vibe-Coded Project Bootstrap](https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/2-vibe-coding-bootstrap.md). Resolve both supplied files to exact Git revisions and calculate their SHA-256 digests using a tool that read the exact revision bytes, as defined by the foundation. Never infer a digest. If the required source or tool verification fails, report it; do not create a lifecycle record that later sessions cannot verify.

This workflow collects project facts, recommends project-specific choices, creates and verifies the approved non-product scaffold, and hands the project to normal development. It must not implement the first functional product slice.

## 1. Companion Contract And Loading

Apply the foundation without copying it here. Read its loading contract and core sections, evaluate every observable router trigger against bootstrap, and load every triggered section. The initial rule manifest should identify bootstrap as the task and list the selected sections and expected gates.

The four workflow roles remain separate:

- the foundation owns permanent reusable policy;
- this file owns one-time discovery, project selection, setup, and bootstrap retirement;
- the optional closeout file owns an intentional session checkpoint and its authorized publication;
- continuation owns later-session loading and lifecycle routing.

Collect project values where the foundation leaves a choice; do not ask whether its established rules should apply. Store project-specific contracts in their canonical project documents, not in these reusable files.

## 2. Lifecycle And Scope

Bootstrap owns starting-state classification, discovery, technology recommendation, the pre-scaffold proposal and approval, readiness, non-product scaffolding, initial canonical documentation and memory, verification, and owner acceptance. It does not own later product work, routine continuation, unrelated provisioning, or permanent policy already in the foundation.

After the private memory location is accepted and its mutation is authorized, create `.agents/bootstrap-lifecycle.json` as the only canonical lifecycle record. Use valid JSON with this exact schema:

```json
{
  "schema_version": 1,
  "bootstrap_id": "stable project-unique identifier",
  "state": "active-discovery",
  "starting_classification": "New",
  "bootstrap_source": {
    "repository": "Razva/public",
    "path": "notes/llm/vibe-coding/2-vibe-coding-bootstrap.md",
    "revision": "exact Git commit",
    "digest": "sha256:lowercase-hex"
  },
  "approved_proposal_ref": null,
  "evidence_ref": "canonical supporting reference or null",
  "updated_at": "ISO-8601 timestamp"
}
```

Only these states are valid:

| State | Meaning | Approved proposal |
| --- | --- | --- |
| `active-discovery` | Classification or discovery is in progress | Must be `null` |
| `active-proposal` | A complete proposal awaits approval or revision | Must be `null` |
| `active-scaffold` | The proposal is approved and scaffold work is in progress | Required |
| `active-review` | The scaffold awaits owner approval or requested corrections | Required |
| `retired-complete` | The owner approved bootstrap | Required |
| `retired-not-applicable` | An established project did not require bootstrap | Must be `null` |

`starting_classification` must be one value from Section 4. `evidence_ref` is required for both retired states and otherwise records useful canonical evidence or `null`. Do not add parallel applicability, proposal-status, approval-status, or retirement fields.

Validate JSON syntax, allowed states, exact source identity, digest format, and conditional fields after every transition. The current context links to `bootstrap_id` and stores the foundation identity/revision/digest, current work, designated memory writer, blockers, and next action; it does not copy lifecycle state. The daily log records meaningful transitions. Decisions link to the approved proposal and final owner decision without reproducing lifecycle fields.

Transitions are:

1. create `active-discovery`;
2. set `active-proposal` when the complete proposal is presented;
3. set `active-scaffold` only after explicit proposal approval and add its canonical reference;
4. set `active-review` when the scaffold is ready for owner review; requested corrections remain `active-review` while context records the next correction;
5. set `retired-complete` only after explicit bootstrap approval;
6. use `retired-not-applicable` only for a verified established project.

A later session resumes an active state through File 4, which retrieves this exact recorded bootstrap revision. Never ask the user to supply File 2 again. Retirement ends bootstrap, not the conversation; after retirement this file must never be retrieved or applied for the project.

## 3. Adaptive Discovery Method

Inspect authorized repositories, supplied material, and read-only environment facts before asking. Ask in short rounds, resolving high-impact dependencies before conditional detail. Explain non-obvious consequences, separate constraints from preferences, recommend when evidence supports it, and keep unapproved answers open.

Do not repeat answered questions or make reversible low-risk details into blockers; label assumptions in the proposal. Before proposal approval, do not scaffold, install dependencies, initialize the application repository, or create application files. The only early write is the authorized private-memory lifecycle checkpoint.

## 4. Classify The Starting State

Classify as:

- **New** — neither repository exists;
- **Empty repositories** — repositories exist without meaningful project state;
- **Partial bootstrap** — initial material exists but the project foundation is incomplete;
- **Established project** — implementation or authoritative contracts already define the project;
- **Replacement or clean-room project** — a new implementation is informed by an older product or data source.

Inspect every existing repository's identity, visibility, branch, remotes, tracked files, documentation, recent history, status, diffs, and active work. Preserve authoritative existing material. Use bootstrap for a partial project only after stating what is complete, missing, preserved, and proposed to change.

For an established project, stop bootstrap and continue in the same conversation under the foundation. If memory exists, write `retired-not-applicable` with supporting evidence, link it from current context, and record the transition; otherwise disclose that no durable lifecycle record can be created. Do not infer that bootstrap approved the existing project.

For replacement or clean-room work, have the owner classify old material as requirements, visual references, migration input, historical evidence, or authorized implementation source. Inventory supplied code and assets and apply the foundation's rights and clean-room boundaries.

## 5. Establish Project Identity And Collaboration

Collect or confirm:

- final name and one-sentence description;
- application GitHub owner/name/visibility/default branch/local path;
- private memory GitHub owner/name/default branch/local path;
- whether each repository exists locally or remotely;
- identifiers, domains, addresses, and reserved ports actually needed by credible options;
- project working timezone, license, documentation language, and approved human Git identity;
- desired response detail, progress cadence, decision presentation, and project terminology;
- the designated private-memory writer and any expected reviewer or concurrent-agent workflow.

Default memory to `<application-name>-agents`; it must be private. Keep technology-dependent identifiers provisional until the proposal proves they are needed. Keep project working timezone separate from product user timezones.

## 6. Establish The Product Baseline

Ask or derive the problem, desired outcome, users, primary workflow, smallest usable first release, measurable completion, non-goals, terminology, and commitments to preserve. Separate behavior from implementation suggestions. Restate legacy behavior as a clean requirement. Resolve uncertainty that can change the first release and defer other detail to named decision gates.

## 7. Establish Domain, Data, And Trust Boundaries

Collect only applicable facts about actors and permissions; authoritative data and write ownership; authentication, privacy, regulation, and sensitive data; retention/deletion/audit/history/recovery; isolation boundaries; import or reconciliation; external reads/writes/communications; optional telemetry; asynchronous work; and credible scale, latency, availability, and growth.

Capture ownership, lifecycle, invariants, and risk without designing a detailed schema. If optional telemetry or external diagnostic export is adopted, collect purpose, categories, providers, consent, retention, controls, and prohibited data; otherwise record that it remains disabled and skip provider questions.

## 8. Establish Product Surfaces And Experience

Identify required browser, mobile, desktop, API, command-line, embedded, or document surfaces and their priority. Collect applicable navigation, device/viewport/container, accessibility, language/locale/time/currency, visual identity, reference, loading/empty/error/offline/permission/editable-state, and project UI-contract decisions.

Classify visual material as evidence or approved direction. It cannot silently determine architecture, data ownership, routes, or source structure.

## 9. Establish Delivery And Operations

Collect the first deployment target and owner; available runtime, data, storage, network, and managed services; environments; deployment/process/service shape; configuration and secrets; backup/restore/recovery/monitoring/support; deadlines, team capacity, maintenance owner/horizon; cost, license, vendor, residency, and portability limits; and restrictions on containers, processes, workers, or infrastructure.

Separate present constraints from future preferences. Do not choose infrastructure for hypothetical scale.

## 10. Recommend The Technology Baseline

Ask for hard constraints, relevant experience, strong preferences, prohibited choices, and maintenance expectations. Do not force a programming-language choice before explaining credible options unless it is already a constraint.

Evaluate the smallest credible combinations of language, runtime, framework, interface technology, data store, persistence, package tooling, testing, build tooling, and deployment. Apply the foundation's version, dependency, and rights rules. Record verified versions, date, sources, compatibility, and license consequences.

Recommend one baseline for this product. Show alternatives only for consequential trade-offs. Identify optional components, rejected infrastructure, and future gates.

## 11. Define The Project Working And Verification Contract

Collect project choices for branch/PR workflow, commit cadence and standing publication authority, CI triggers/full-gate milestones, exact verification commands, visual/accessibility/live-integration/security expectations, dependency maintenance, environment promotion/release/deployment ownership, documentation ownership, concurrent-work isolation, recovery checkpoints, and exceptions.

The proposal must define `docs/development/verification.md`, one top-level verification entry point, and the foundation check matrix. For each required check, specify `Automated`, `Manual`, or `Not applicable` with rationale, exact trigger/command, and CI use. It must cover file-size enforcement, generated codebase-map inventory/completeness, prohibited tracked files, project build/static/test gates, publication secret scanning, and applicable dependency audit/lockfile installation. Identify where generated conventional map roles and authored non-obvious descriptions are maintained.

Record accepted values in canonical project documents without restating foundation policy.

## 12. Present The Pre-Scaffold Proposal

Present one consolidated proposal containing:

1. project/repository identity and starting classification;
2. preserved material and authoritative or clean-room inputs;
3. outcome, users, workflow, first release, completion, and non-goals;
4. domain, data, trust, integration, migration, telemetry, and rights direction;
5. product surfaces and experience constraints;
6. recommended technology with verified versions, sources, rationale, and alternatives;
7. delivery, ownership, maintenance, concurrency, and recovery shape;
8. top-level modules, dependency direction, and first data-model direction;
9. canonical documents, verification automation, and lifecycle-validation method;
10. exact non-product scaffold deliverables and excluded product work;
11. assumptions, risks, blockers, deferred decisions, and gates.

Distinguish owner facts, verified facts, recommendations, assumptions, questions, and proposed decisions. The owner may approve the complete enumerated proposal in one statement; unresolved alternatives still need answers. Revise when an answer changes downstream choices.

When presenting it, transition to `active-proposal`. After explicit approval, store its canonical reference and transition to `active-scaffold`. Approval authorizes only the proposed scaffold actions, not the first feature.

## 13. Verify Readiness

After approval, verify repository identity/paths, GitHub access/visibility, required local tools and versions, runtime/package/build/test/data/container/browser/service capabilities, selected ports/domains/permissions/reachability, and conflicting files/processes. Classify gaps as blocking or deferrable and report owner, administrator, credential, billing, or provider actions separately. If evidence invalidates the proposal, revise the decision before scaffolding.

## 14. Create The Approved Non-Product Scaffold

Execute only approved deliverables. Preserve partial-project material, compare generator output with the proposal, and deliberately retain or remove defaults. Create the canonical documentation, master plan, exhaustive generated-and-authored codebase map, private memory, initial modules, and project verification entry point. Validate lifecycle JSON with a real JSON parser and this file's schema; no product component may own that workflow state.

Set the designated memory writer and active mutation boundary in current context. Do not implement the first functional slice or add accidental product behavior.

## 15. Verify And Review Bootstrap

Run the actual approved verification entry point and validate every matrix row—not merely the documented commands. Prove that the scaffold exists at accepted locations; starts/builds through its documented entry; matches the approved technology, deployment, modules, and tracked contents; contains no product behavior; has complete linked documentation/memory; validates the lifecycle JSON; identifies the first permitted slice; and has no unresolved bootstrap blocker.

Correct the scaffold or contract instead of adding product behavior to satisfy an inapplicable check. When ready for owner review, transition to `active-review`, update current context with evidence and next action, and record the daily checkpoint.

## 16. Approve, Handoff, And Retire

Report the proposal, deviations, scaffold result, actual check results, first permitted slice, blockers, selected foundation sections, and exact verified workflow identities. Ask the owner to approve the bootstrap result.

Requested corrections remain `active-review`; record the next correction in current context. On explicit approval, transition to `retired-complete`, add approval evidence, validate the record, update current context to the first permitted slice, and record the daily transition. If durable memory is unavailable or invalid, disclose that bootstrap cannot be durably retired.

The same conversation may continue directly under the foundation. Before deliberately leaving, the owner may supply File 3. At the start of a later conversation, supply only File 4 and the current request. Never supply or apply this bootstrap again after retirement.
