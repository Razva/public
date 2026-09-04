# Vibe-Coded Project Bootstrap

Supply the [Vibe-Coded Project Foundation](1-vibe-coding-foundation.md) first. Then supply this workflow exactly once for the project to establish a new application or complete an appropriate partial bootstrap. Keep bootstrap as the active project phase until the owner approves and retires it.

The foundation defines the permanent operating rules. This file collects project-specific facts, guides initial decisions, creates the approved non-product scaffold, verifies it, and hands the resulting project to normal development.

Do not implement the first functional product slice through this workflow.

## 1. Companion Contract And Non-Duplication

Read the complete foundation before starting. Apply it throughout bootstrap without copying or paraphrasing its rules into this file.

Keep the three reusable workflows distinct:

- the foundation owns rules that remain applicable throughout the project;
- this bootstrap owns one-time discovery, project-specific selection, initial setup, and bootstrap handoff;
- the separate continuation workflow owns orientation and task startup only at the beginning of a later conversation for an established project.

When the foundation already decides a policy, collect only the concrete project value needed to apply it. For example, collect the two repositories' names and paths without asking whether the required two-repository model should be used.

Project documentation may record accepted project-specific decisions and exceptions. That is instantiation of the foundation, not permission to duplicate reusable guidance across companion files.

If an instruction would still be needed after bootstrap, it does not belong here unless it only identifies the handoff boundary. Put permanent reusable policy in the foundation and project-specific durable policy in the appropriate canonical project document.

## 2. Lifecycle And Scope

This workflow owns:

- read-only classification of the starting state;
- discovery of project identity, product intent, constraints, and authoritative inputs;
- evaluation and recommendation of an appropriate technology baseline;
- a consolidated pre-scaffold proposal and approval gate;
- environment and repository readiness checks;
- creation or completion of the approved non-product scaffold;
- creation and initial population of applicable canonical project documentation and private memory;
- bootstrap verification, review, and handoff.

This workflow does not own:

- permanent implementation, security, Git, documentation, or operational policy already defined by the foundation;
- operating-system or account provisioning that was not explicitly placed in scope;
- the first functional vertical slice or later product work;
- routine startup for an established project;
- ongoing session orientation, recovery, or resumption.

Bootstrap remains active until the owner approves its outcome. Do not supply this file again, including when bootstrap spans conversations.

After project identity and the private memory location are accepted, create one durable bootstrap lifecycle record as soon as that memory repository is available and the owner has authorized the required memory mutation. Use one stable identifier in `.agents/decisions.md` and record the bootstrap source identity and revision or digest, starting-state classification, status, approved facts, current stage, unresolved questions, and next action. Keep status and next action current after each meaningful discovery or execution checkpoint. Other memory files may link to this record but must not duplicate it.

If a later conversation begins before bootstrap approval, the continuation workflow must detect the `In progress` lifecycle record and resume from its recorded stage without receiving this file again. If no durable record exists, reconstruct only from accessible project or conversation evidence and ask for missing facts; never invent prior approval or silently repeat completed work.

Approval retires bootstrap, not the conversation. The same conversation may then continue using the foundation and canonical project sources; do not activate the continuation workflow in that conversation. Supply the continuation workflow only at the beginning of a later conversation. Once bootstrap is approved and retired, never supply or apply it again for that project.

## 3. Adaptive Discovery Method

Inspect before asking. Obtain facts from authorized repositories, supplied material, and read-only environment checks when they can be discovered safely.

Ask questions in short, coherent rounds. Resolve high-impact decisions before dependent questions, and ask conditional questions only when the answer can affect product scope, architecture, security, deployment, user experience, or the scaffold.

For each consequential question:

- explain briefly why the answer matters when that is not obvious;
- distinguish a hard constraint from a preference;
- offer a recommendation when evidence supports one;
- make alternatives and trade-offs concrete;
- preserve an item as open when the owner has not approved it.

Do not repeat answered questions. Do not turn low-risk details into blockers when a reversible assumption will suffice; label such assumptions in the proposal.

Do not scaffold, install dependencies, initialize the application repository, create application files, or create unrelated remote resources before the pre-scaffold proposal is approved. The sole early-write exception is the private-memory bootstrap lifecycle checkpoint defined above. Creating or connecting its repository still requires the applicable authorization.

## 4. Classify The Starting State

First classify the project as one of:

- **New** — neither project repository exists;
- **Empty repositories** — repositories exist but contain no meaningful project state;
- **Partial bootstrap** — some initial files or decisions exist, but the foundation is not yet coherent or verified;
- **Established project** — implementation or authoritative project contracts already define the project;
- **Replacement or clean-room project** — a new implementation is informed by an older product or data source.

For any existing local or remote repository, inspect its identity, visibility, default branch, remotes, tracked files, documentation, recent history, status, and relevant diffs before deciding how to proceed. Inspect both application and memory repositories when they exist.

Use this workflow for a partial bootstrap only after identifying what is authoritative, what is incomplete, what must be preserved, and what the bootstrap would change. Never overwrite an existing project shape blindly.

If the project is already established, do not force it back through bootstrap or require a new conversation. Explain the classification, stop applying bootstrap, and continue in the same conversation using the foundation and canonical project sources. Reserve the continuation workflow for a later conversation.

When durable private memory exists, record this early-exit outcome in the bootstrap lifecycle record: classification `Established project`, outcome `Not applicable`, the evidence supporting that classification, the bootstrap source revision or digest, and status `Retired without execution`. If durable memory is unavailable, report that limitation rather than claiming a persistent retirement record.

For a replacement or clean-room project, ask the owner to classify prior materials as requirements, visual references, migration inputs, historical evidence, or authorized implementation sources before inspecting or using them. Inventory supplied code, content, datasets, fonts, icons, screenshots, designs, and other assets, then collect the project-specific provenance, permission, attribution, and publication facts required by the foundation's source-and-asset-rights rules.

## 5. Establish Project Identity And Collaboration

Collect or confirm:

- final product name and a one-sentence description;
- application-repository GitHub owner, name, visibility, default branch, and local path;
- private memory-repository GitHub owner, name, default branch, and local path;
- whether either repository already exists locally or remotely;
- application, package, namespace, or distribution identifiers required by credible stack options;
- development, preview, and production domains or addresses when applicable;
- reserved local ports when applicable;
- project working timezone for memory and development records;
- intended license and documentation language;
- approved human Git identity if bootstrap Git actions may be requested.

Default the private memory repository name to `<application-name>-agents` unless the owner supplies another name. Its visibility remains private under the foundation.

Keep identifiers provisional until the technology and deployment proposal confirms which ones are actually required. Do not invent unused identifiers merely to complete a questionnaire.

Collect durable owner collaboration preferences, including desired response detail, progress-update cadence, how recommendations and alternatives should be presented, preferred project terminology, and any other working preference that will help later agents collaborate consistently. Keep the project working timezone distinct from any user-facing product timezone.

## 6. Establish The Product Baseline

Ask or derive:

- the problem to solve and desired outcome;
- target users and their important differences;
- the primary end-to-end workflow;
- the smallest first release that is genuinely usable;
- measurable completion criteria;
- explicit non-goals and deferred capabilities;
- known business or domain terminology;
- existing commitments that the project must preserve.

Separate desired behavior from implementation suggestions. Restate legacy behavior as a clean product requirement before treating it as part of the new project.

Identify uncertainty that could change the first release. Resolve blocking ambiguity now and defer unrelated future detail to a named just-in-time decision gate.

## 7. Establish Domain, Data, And Trust Boundaries

Ask only the applicable questions needed to identify:

- actors, roles, ownership, and consequential permissions;
- authoritative sources of data and which system may change each kind of data;
- authentication, privacy, confidentiality, and regulatory constraints;
- sensitive data categories and prohibited storage or exposure;
- retention, deletion, audit, history, and recovery expectations;
- tenant, organization, workspace, or other isolation boundaries;
- existing data that must be imported, reconciled, or preserved;
- external systems and which reads, writes, or communications the product requires;
- whether optional telemetry or external diagnostic export is needed;
- scheduled, asynchronous, offline, or long-running behavior;
- credible initial scale, latency, availability, and growth requirements.

Do not design a detailed schema during discovery. Capture enough ownership, lifecycle, invariants, and risk to evaluate architecture and propose the first data-model direction.

If optional telemetry or external diagnostic export is adopted, collect the allowed categories, purposes, providers, consent basis, retention, user controls, and prohibited data required to instantiate the foundation. If it is not adopted, record that decision and do not ask provider-specific telemetry questions.

## 8. Establish Product-Surface And Experience Constraints

Determine which interfaces are required, such as browser, mobile, desktop, API, command line, embedded surface, or generated documents. Record their priority rather than assuming every surface is equally important.

Collect applicable project-specific decisions about:

- primary workflows and navigation model;
- device, viewport, and container priorities;
- accessibility target and keyboard or assistive-technology needs;
- supported languages, content ownership, locale, timezone, date, number, and currency behavior;
- visual identity, tone, iconography, and supplied design references;
- loading, empty, failure, offline, permission, and editable-state expectations that materially shape the product;
- whether a written project UI contract is required before interface implementation.

Classify screenshots and mockups as evidence or approved design direction. Do not let visual material silently determine architecture, data ownership, routes, or source structure.

## 9. Establish Deployment And Operational Constraints

Collect the facts that constrain the technical baseline:

- first deployment target and who administers it;
- available runtimes, databases, storage, network access, and managed services;
- required development, preview, staging, and production environments;
- deployment unit, process model, and expected service ownership;
- configuration and secret-management facilities;
- backup, restore, rollback, monitoring, and support expectations;
- delivery deadlines, available team capacity, maintenance owner, and expected maintenance horizon;
- cost, licensing, vendor, residency, or portability constraints;
- restrictions on containers, persistent processes, background workers, or external infrastructure.

Distinguish current hard limits from future preferences. Do not select infrastructure for hypothetical scale that contradicts the first-release constraints.

## 10. Evaluate And Recommend The Technology Baseline

Ask for hard technology constraints, relevant team experience, strong owner preferences, prohibited choices, and maintenance expectations. Do not ask the owner to select a programming language before explaining the credible options unless the language is already a hard constraint.

Evaluate the smallest credible combinations of language, runtime, application framework, interface technology, data store, persistence approach, package tooling, testing, build tooling, and deployment shape.

Apply the foundation's dependency, version-verification, and source-and-asset-rights rules to the candidate baseline. Record only the resulting project-specific versions, verification date, sources, compatibility constraints, and license consequences in the proposal.

Recommend one baseline. Present alternatives only when they are genuinely competitive or expose a consequential trade-off. Explain why the recommendation fits this product better; do not select a stack merely because it is fashionable, familiar to the agent, or common in unrelated projects.

Identify optional components, rejected infrastructure, and future decision gates explicitly.

## 11. Define The Project-Specific Working Contract

Collect only the choices that the foundation deliberately leaves to each project, including as applicable:

- branch and pull-request workflow;
- local commit cadence and any standing publication authority;
- CI triggers and full-gate milestones;
- project-specific verification commands;
- browser, responsive, visual-evidence, accessibility, live-integration, and security-scan expectations;
- dependency-update and maintenance cadence;
- environment promotion, release, and deployment ownership;
- public-documentation and root-README ownership;
- project-specific exceptions to foundation defaults.

Record accepted choices in the appropriate canonical project document. Do not repeat the foundation's general authorization, Git, verification, or publication rules.

## 12. Present The Pre-Scaffold Proposal

Before any mutation, present one consolidated proposal containing:

1. project identity and repository coordinates;
2. starting-state classification and preserved existing material;
3. product outcome, users, primary workflow, first-release cutline, completion criteria, and non-goals;
4. authoritative inputs, evidence, clean-room boundaries, source and asset rights, and unresolved conflicts;
5. domain, data-ownership, trust, integration, and migration direction;
6. product surfaces and experience constraints;
7. recommended technology baseline with verified versions, sources, rationale, and trade-offs;
8. deployment, delivery, ownership, and maintenance shape;
9. proposed top-level modules, ownership boundaries, and dependency direction;
10. first-pass data-model direction without premature schema detail;
11. applicable canonical documentation and decision artifacts to create;
12. project-specific working and verification contract;
13. exact bootstrap deliverables and explicitly excluded product work;
14. assumptions, risks, blockers, deferred decisions, and their decision gates.

Clearly distinguish owner-provided facts, verified facts, recommendations, assumptions, open questions, and decisions awaiting approval.

The owner may approve a complete, clearly enumerated proposal with one explicit statement such as `Approve the proposal as written`. That approval covers every item presented as a proposed decision, but it does not resolve alternatives or questions explicitly marked open and does not approve actions excluded from the proposal. Request separate answers only for unresolved alternatives, omissions, or partial approval. Revise the proposal when an answer changes downstream choices.

## 13. Verify Readiness

After proposal approval, verify the exact prerequisites required by the chosen baseline:

- target directories and repository identities;
- GitHub access and repository visibility when remote work is in scope;
- required local tools and compatible versions;
- runtime, package, build, test, database, container, browser, or service capabilities that the approved scaffold needs;
- selected ports, domains, filesystem permissions, and external-service reachability when applicable;
- existing files or processes that could conflict with the approved work.

Classify missing prerequisites as blocking or safely deferrable. Report owner, administrator, credential, billing, or external-service actions separately instead of silently expanding bootstrap authority.

If readiness evidence invalidates the approved proposal, stop and revise the affected decision before scaffolding.

## 14. Create The Approved Non-Product Scaffold

Execute only the approved bootstrap deliverables.

- Perform only the approved repository and scaffold mutations under the foundation's authorization and repository rules.
- Preserve the material identified by the partial-bootstrap review.
- Run the selected scaffold mechanism and compare its actual output with the proposal; retain, replace, or remove generator defaults deliberately.
- Instantiate the foundation-required application documentation, canonical master plan, exhaustive codebase map, and private memory with the accepted project-specific facts and decisions.
- Establish only the approved initial module boundaries and project-specific verification entry points.

Do not implement the first functional vertical slice. The scaffold must not acquire accidental product behavior merely to appear complete.

## 15. Verify And Review The Bootstrap

Apply the foundation's verification and evidence rules using the exact scaffold checks approved in the proposal. In addition to those general gates, bootstrap acceptance must prove that:

- the approved scaffold exists at the accepted repository locations;
- it initializes, builds, starts, or otherwise runs through its documented entry point as applicable;
- its actual technology, deployment shape, modules, and tracked contents match the approved proposal;
- it contains no unapproved or accidental product behavior;
- its project-specific documentation and memory are populated and mutually linked as proposed;
- the canonical master plan identifies the first permitted functional slice;
- no unresolved bootstrap task prevents that slice from beginning.

Do not add product behavior merely to satisfy an inapplicable generated check. Correct the scaffold or revise the documented verification contract instead.

## 16. Handoff And Retire Bootstrap

Apply the foundation's completion, memory, Git, publication, and handoff rules. Add only the bootstrap-specific handoff facts: the approved proposal, deviations from it, scaffold acceptance result, first permitted functional slice, unresolved bootstrap blockers, and the identity and revision or digest of this bootstrap source.

Before requesting approval, ensure the canonical bootstrap lifecycle record contains the source identity and revision or digest, final classification, proposal identity, deviations, completion evidence, first permitted functional slice, approval status `Awaiting approval`, and retirement status `Active`. If durable private memory remains unavailable, disclose that bootstrap cannot be durably approved and retired.

Ask the owner to approve the bootstrap result. On approval, update the same record to approval status `Approved` and retirement status `Retired`. Never supply or apply this bootstrap again for the project.

The current conversation may proceed directly with the foundation and canonical project sources. At the beginning of a later conversation, supply the foundation and the separate continuation workflow—not this bootstrap.
