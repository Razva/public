# Vibe-Coded Project Continuation

Use this file at the beginning of every later conversation for the same project. The user supplies this file and the current request; do not require the user to paste the foundation separately.

This file is a loader and router. It contains no substitute for the global foundation or the project's canonical sources.

The optional [session-closeout workflow](3-vibe-coding-session-closeout.md) may have prepared a final checkpoint, but continuation must not depend on it. If closeout was skipped or interrupted, detect stale or incomplete state through the foundation's startup protocol and reconstruct only from verified repository evidence.

Do not use this file inside the original conversation in which bootstrap is still running or has just been approved. That conversation already has the required context and may continue directly.

## 1. Load The Canonical Foundation

Before substantive project work, retrieve and read the complete current foundation from:

[Canonical Vibe-Coded Project Foundation](https://github.com/Razva/public/blob/main/notes/llm/general/1-vibe-coding-foundation.md)

Resolve the mutable `main` reference to an exact commit, identify the exact file revision, and calculate a content digest. Read through end-of-file and verify the repository owner, repository, path, and source identity. A branch name, search excerpt, cached copy, summary, remembered instruction, or truncated tool result is not sufficient.

If the complete foundation cannot be retrieved or its canonical identity, exact revision, and content digest cannot be established, stop. State the precise access or completeness problem and ask the user to provide the complete foundation. Do not continue from memory or embedded excerpts.

Do not copy the foundation into this file, project documentation, or private memory. Store only its source identity, exact revision, and content digest where this workflow requires a reference.

## 2. Load The Current Project

Execute the complete **Source-Of-Truth Startup Protocol** and **Tool Result Completeness** requirements from the foundation against the current project. Do not reproduce their checklist here.

Use the canonical application and private-memory repository identities and locations recorded by the project. Complete that protocol before relying on a path, branch, plan, decision, preference, current state, or claimed absence.

Do not ask the user to supply the bootstrap file again. Whether its exact recorded revision may be retrieved is determined only by the lifecycle route below.

## 3. Reconcile The Foundation Revision

After establishing the canonical project and memory sources, read the foundation source identity, exact Git revision, and content digest previously recorded in `.agents/current-context.md`.

If no prior value exists, do not establish a baseline until evaluating the bootstrap lifecycle in Section 4. Treat its absence from a lifecycle record created under the current bootstrap contract as inconsistent. For the verified legacy-project route defined below, use the current foundation revision and digest as the continuation baseline and disclose that no earlier comparison was possible.

If the value changed:

1. identify the clauses changed between the previously recorded and current versions when both are available;
2. execute the foundation's precedence rules against the project's established contracts and decisions;
3. identify any changed clause that conflicts with or would redesign established project behavior, architecture, workflow, or ownership;
4. continue unaffected work only when the conflict does not govern it;
5. surface consequential conflicts for owner resolution instead of silently rewriting project contracts.

Record the exact foundation revision and content digest used for the session in `current-context.md` as part of the session's first otherwise-required memory update. When the revision changed, record the comparison outcome in the current daily session log and link to any resulting project decision without copying either source.

For a purely read-only request that does not otherwise justify a memory update, state the verified foundation revision and content digest in the response but do not mutate memory solely to record the read.

If a relevant revision change cannot be compared reliably, fail closed for work it may affect. State what could not be verified and what evidence is needed.

## 4. Evaluate The Bootstrap Lifecycle

Look for the stable bootstrap identifier and lifecycle fields in `.agents/decisions.md`, then follow any link to active state in `.agents/current-context.md`.

When a lifecycle record exists, validate its required fields, recorded foundation baseline, conditional proposal reference, links, and combination against the exact routes below. The bootstrap workflow owns creation and transition of this state; continuation only consumes it. Do not assume approval, retirement, applicability, or permission to proceed. Select exactly one route:

- **Active bootstrap** — applicability is `Applicable`, retirement is `Active`, bootstrap approval is `Not requested`, `Awaiting approval`, or `Changes requested`, and the proposal fields match the recorded stage. Retrieve the bootstrap file at its exact recorded revision—not the current branch version—verify its identity, digest, and complete contents, validate the full lifecycle record against that source, then resume the linked stage and next action. Do not begin functional product work that bootstrap has not permitted.
- **Completed bootstrap** — applicability is `Applicable`, proposal status and bootstrap approval are `Approved`, an approved-proposal reference exists, and retirement is `Retired`. Route to ordinary project continuation.
- **Established project without bootstrap execution** — applicability, proposal status, and bootstrap approval are `Not applicable`; no approved-proposal reference exists; and retirement is `Retired without execution`. Route to ordinary continuation without implying that bootstrap created or approved the existing project.
- **Verified legacy established project** — no lifecycle record exists, canonical project sources and repository history demonstrate that the project was established before adoption of the lifecycle contract, and no evidence indicates an active or incomplete bootstrap. Route to ordinary continuation, label the route explicitly, and do not fabricate bootstrap approval or retirement.

Any other present, absent, incompatible, or contradictory state is invalid. Investigate it against repository evidence and relevant history. If it cannot be resolved confidently, fail closed for mutating work, report the exact inconsistency, and request only the information needed to resolve it.

Never retrieve or apply the bootstrap file for a completed, non-executed, or legacy route. If an active record lacks an exact retrievable revision, its content digest, or enough source identity to establish the canonical file, fail closed rather than substituting the latest bootstrap version or a remembered copy.

## 5. Route The Current Request

If bootstrap is active, treat its recorded stage and next action as the current workflow. Reconcile the user's request with that state: continue compatible bootstrap work, or explain why a requested functional change must wait for bootstrap approval.

If bootstrap is retired, was not applicable, or the verified legacy route applies, treat the user's current request as the session objective. Use the foundation and canonical project sources to determine the relevant scope, then load only the additional context needed for that objective.

The user's latest explicit instruction may change the current task under the foundation's precedence rules. It does not silently erase unresolved repository state, bootstrap status, or separately controlled external actions.

Do not require the owner to repeat accepted identity, product, technology, or workflow decisions that are available in canonical project sources.

## 6. Begin The Session

Before acting, provide a concise orientation containing only:

- the lifecycle route selected;
- the exact foundation revision and content digest loaded;
- the current state, constraints, blockers, and next action relevant to the request;
- any foundation-revision conflict or source gap that affects the request.

If the request is concrete and unblocked, proceed in the same turn after this orientation. Do not require a full project recap or a new approval merely because a later conversation began.

If the user supplied no concrete task, summarize the current state and next permitted action, then ask what they want to do.

After loading and routing are complete, this file has completed its role for the conversation. Continue under the foundation, the project's canonical sources, and the user's current instructions.
