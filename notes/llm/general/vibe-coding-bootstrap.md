# Vibe-Coded Project Bootstrap

Use this workflow once to establish a new application project or complete an appropriate partial bootstrap. Use it together with [Vibe-Coded Project Foundation](vibe-coding-foundation.md), which must be available to the same LLM coding agent.

The foundation defines the permanent operating rules. This file collects project-specific facts, guides initial decisions, creates the approved non-product scaffold, verifies it, and hands the resulting project to normal development.

Do not implement the first functional product slice through this workflow.

## 1. Companion Contract And Non-Duplication

Read the complete foundation before starting. Apply it throughout bootstrap without copying or paraphrasing its rules into this file.

Keep the three reusable workflows distinct:

- the foundation owns rules that remain applicable throughout the project;
- this bootstrap owns one-time discovery, project-specific selection, initial setup, and bootstrap handoff;
- the separate continuation workflow owns orientation and task startup for an established project.

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

Ending bootstrap means retiring this workflow, not ending the conversation. After bootstrap approval, the same conversation may continue under the established project sources and continuation workflow. Start a new conversation only when the owner prefers it or the existing context is no longer dependable.

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

Do not scaffold, install dependencies, initialize repositories, create remote resources, or write project files before the pre-scaffold proposal is approved.

## 4. Classify The Starting State

First classify the project as one of:

- **New** — neither project repository exists;
- **Empty repositories** — repositories exist but contain no meaningful project state;
- **Partial bootstrap** — some initial files or decisions exist, but the foundation is not yet coherent or verified;
- **Established project** — implementation or authoritative project contracts already define the project;
- **Replacement or clean-room project** — a new implementation is informed by an older product or data source.

For any existing local or remote repository, inspect its identity, visibility, default branch, remotes, tracked files, documentation, recent history, status, and relevant diffs before deciding how to proceed. Inspect both application and memory repositories when they exist.

Use this workflow for a partial bootstrap only after identifying what is authoritative, what is incomplete, what must be preserved, and what the bootstrap would change. Never overwrite an existing project shape blindly.

If the project is already established, do not force it back through bootstrap or require a new conversation. Explain the classification and transition to the continuation workflow in the same conversation.

For a replacement or clean-room project, ask the owner to classify prior materials as requirements, visual references, migration inputs, historical evidence, or authorized implementation sources before inspecting or using them.

## 5. Establish Project Identity

Collect or confirm:

- final product name and a one-sentence description;
- application-repository GitHub owner, name, visibility, default branch, and local path;
- private memory-repository GitHub owner, name, default branch, and local path;
- whether either repository already exists locally or remotely;
- application, package, namespace, or distribution identifiers required by credible stack options;
- development, preview, and production domains or addresses when applicable;
- reserved local ports when applicable;
- intended license and documentation language;
- approved human Git identity if bootstrap Git actions may be requested.

Default the private memory repository name to `<application-name>-agents` unless the owner supplies another name. Its visibility remains private under the foundation.

Keep identifiers provisional until the technology and deployment proposal confirms which ones are actually required. Do not invent unused identifiers merely to complete a questionnaire.

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
- scheduled, asynchronous, offline, or long-running behavior;
- credible initial scale, latency, availability, and growth requirements.

Do not design a detailed schema during discovery. Capture enough ownership, lifecycle, invariants, and risk to evaluate architecture and propose the first data-model direction.

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
- cost, licensing, vendor, residency, or portability constraints;
- restrictions on containers, persistent processes, background workers, or external infrastructure.

Distinguish current hard limits from future preferences. Do not select infrastructure for hypothetical scale that contradicts the first-release constraints.

## 10. Evaluate And Recommend The Technology Baseline

Ask for hard technology constraints, relevant team experience, strong owner preferences, prohibited choices, and maintenance expectations. Do not ask the owner to select a programming language before explaining the credible options unless the language is already a hard constraint.

Evaluate the smallest credible combinations of language, runtime, application framework, interface technology, data store, persistence approach, package tooling, testing, build tooling, and deployment shape. Include only components the accepted product and operational baseline justifies.

Verify current versions, support windows, compatibility, licensing, and deployment requirements through primary sources. Record the verification date and source links in the proposal. Do not rely on remembered latest-version claims or stale generator defaults.

Recommend one baseline. Present alternatives only when they are genuinely competitive or expose a consequential trade-off. Explain why the recommendation fits this product better; do not select a stack merely because it is fashionable, familiar to the agent, or common in unrelated projects.

Keep framework and generator output subordinate to the product model. Identify optional components, rejected infrastructure, and future decision gates explicitly.

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
4. authoritative inputs, evidence, clean-room boundaries, and unresolved conflicts;
5. domain, data-ownership, trust, integration, and migration direction;
6. product surfaces and experience constraints;
7. recommended technology baseline with verified versions, sources, rationale, and trade-offs;
8. deployment and operational shape;
9. proposed top-level modules, ownership boundaries, and dependency direction;
10. first-pass data-model direction without premature schema detail;
11. applicable canonical documentation and decision artifacts to create;
12. project-specific working and verification contract;
13. exact bootstrap deliverables and explicitly excluded product work;
14. assumptions, risks, blockers, deferred decisions, and their decision gates.

Clearly distinguish owner-provided facts, verified facts, recommendations, assumptions, open questions, and decisions awaiting approval.

Request explicit approval for each consequential product, architecture, data, security, deployment, and workflow choice. A general request to continue does not approve clearly identified unresolved alternatives. Revise the proposal when an answer changes downstream choices.

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

- Create, clone, or initialize the exact application and memory repositories only when the corresponding action is authorized.
- Preserve approved partial-bootstrap material and integrate with it deliberately.
- Apply the foundation's repository hygiene before running generators or dependency installation.
- Use the chosen stack's current official scaffold or smallest supported setup when it fits the approved architecture; inspect and deliberately accept, replace, or remove generated defaults.
- Retain only generated example behavior explicitly accepted in the proposal. Do not mistake starter content for approved product scope.
- Establish the proposed module boundaries without creating speculative empty layers or features.
- Create and populate only the applicable canonical project artifacts required by the foundation and named in the proposal.
- Put the canonical master plan in the application repository and initialize it with approved phases, gates, status, and the first permitted product action.
- Create the exhaustive codebase map after the tracked scaffold exists.
- Initialize the foundation's standard private-memory structure with project-specific facts, links, decisions, preferences, current context, and the current day's meaningful bootstrap record.
- Configure the approved project-specific verification entry points.

Do not implement the first functional vertical slice. Do not create speculative product routes, screens, schema, integrations, or feature modules to make the scaffold appear more complete.

## 15. Verify And Review The Bootstrap

Run the exact scaffold verification approved in the proposal together with every applicable foundation gate. Verify the scaffold from its documented entry points rather than relying only on generator success.

Check that:

- dependency resolution and lock state are reproducible when dependencies exist;
- the selected build, static checks, tests, and minimal runtime smoke check succeed as applicable;
- configuration examples and validation agree without exposing secrets;
- documentation links and declared source ownership are coherent;
- the codebase map accounts for every tracked application-repository file;
- the application and memory repositories contain only material appropriate to their roles;
- repository status and diffs match the approved bootstrap scope.

Do not add product behavior merely to satisfy an inapplicable generated check. Correct the scaffold or revise the documented verification contract instead.

## 16. Handoff And Retire Bootstrap

Before declaring bootstrap complete, present:

- the accepted project and technology baseline;
- the repositories, branches, and local paths established;
- the created structure and the role of each canonical artifact;
- verification performed and reproducible results;
- any authorized commits, pushes, or remote resources and their exact identifiers;
- known gaps, deferred decisions, and blockers;
- the canonical master plan's current state and first permitted product action;
- final status of both repositories.

Update the canonical master plan, private current context, decisions, and current daily session log with the verified bootstrap outcome. Complete any separately authorized publication and confirm the resulting remote state.

Ask the owner to approve the bootstrap result. After approval, stop applying this file. Continue in the same conversation when useful, or in a later conversation when preferred, using the project's canonical sources and the separate continuation workflow.
