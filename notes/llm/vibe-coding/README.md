# Vibe-Coding Project Prompts

These files help an AI coding agent start, build, and continue an application safely. They are designed to be used together.

This README is for people. Do not paste it into the coding agent.

Use one of the four copy/paste prompts below. Each prompt names the canonical workflow and instructs the agent to retrieve it completely from GitHub. If the agent cannot retrieve the canonical file, use the manual fallback below; never paste only one section.

| File | Purpose | When to use it |
| --- | --- | --- |
| [1 — Foundation](1-vibe-coding-foundation.md) | The rules used throughout the project. The agent loads the parts relevant to each task. | Use Prompt 1 once at the start of a new project conversation. |
| [2 — Bootstrap](2-vibe-coding-bootstrap.md) | Collects project details and creates the initial structure. It does not build the first feature. | Use Prompt 2 after File 1 is active. Use it only once per project. |
| [3 — Session closeout](3-vibe-coding-session-closeout.md) | Saves the current state in the project repositories and publishes eligible work. | Optionally use Prompt 3 in the current session before changing sessions. |
| [4 — Continuation](4-vibe-coding-continuation.md) | Loads the rules and current project state for a later session. | Use Prompt 4 at the start of every later session, together with your new request. |

## Conditional References

The four prompt files are the only project workflow. Reusable technology and UI files are conditional references, not parallel workflows, and grant no mutation, Git, publication, deployment, external-action, or server-administration authority.

During bootstrap, File 2 loads a relevant reference when the proposed product surface or technology triggers it. The approved project-specific result is then recorded in the application's canonical documentation. Later sessions use those local contracts; they consult a reusable reference again only when the local contract has a relevant gap or the owner asks to reconsider it.

| Reference | Load when |
| --- | --- |
| [Web UI Component Patterns](references/web-ui-component-patterns.md) | The product has a user interface; adopt only web-specific patterns relevant to its surfaces and stack. |
| [TypeScript Project Profile](profiles/typescript.md) | TypeScript is required, detected, or a credible candidate for the approved stack. Its Next.js section applies only when Next.js is independently relevant. |

The foundation and approved project contracts always retain their defined precedence. If a reference conflicts or appears to conflict with them, the agent must surface the conflict and stop applying the conflicting reference text.

This table mirrors reference availability for human discovery. File 2 remains the authoritative agent-facing registry and source of applicability rules; this README's summaries cannot replace or override it.

## Optional Development Server Guidance

The [server guidance](server/README.md) is not a fifth workflow file or a mandatory Step 0. Use its setup reference only when deliberately preparing a self-managed development server or when File 2 finds a missing approved readiness capability. Use its operations reference only for applicable, authorized recurring server work. Application-specific setup and operations remain in the application's own documentation.

## Four Copy/Paste Prompts

Do not paste this entire README into the agent. Copy only the prompt that matches the action you want to take.

### Prompt 1 — Load The Foundation

Use this once at the start of a new project conversation:

```text
Retrieve and apply the complete canonical Vibe-Coded Project Foundation from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/1-vibe-coding-foundation.md

Treat this message as my explicit invocation of that workflow, not as a request to review, summarize, explain, or merely remember it.

Resolve the URL's main branch to an exact Git commit, retrieve the complete canonical file with an appropriate tool, verify it as required by its loading contract, and apply it as the governing workflow for this project.

Do not begin project discovery or implementation yet. When the Foundation is active, respond briefly that you are ready for File 2. If the file cannot be retrieved completely at an exact revision, report the exact failure and do not claim that the Foundation is active.
```

File 1 deliberately establishes the working rules without starting the project. A short readiness confirmation is the expected result.

### Prompt 2 — Execute Bootstrap

Use this after File 1 is already active in the same conversation. This remains valid when File 1 was loaded on an earlier date, provided the conversation and its verified context have continued:

```text
The Vibe-Coded Project Foundation is already active in this conversation.

Retrieve and execute the complete canonical Vibe-Coded Project Bootstrap from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/2-vibe-coding-bootstrap.md

Treat this message as my explicit invocation of that workflow and an instruction to begin bootstrap now, not as a request to review, summarize, explain, or memorize it.

Verify the active Foundation's canonical identity, exact revision, and recorded digest or unavailable status without silently replacing it with the current Foundation. Resolve the Bootstrap URL's main branch to an exact Git commit, retrieve and verify the complete canonical file, and then execute it.

If the Foundation is not already active and verifiable in this conversation, stop and tell me to use Prompt 1. If bootstrap was already retired for this project, do not apply File 2 again; tell me to use Prompt 4.

In this response, verify the supplied workflows, inspect all available repositories and project material, classify the starting state, and begin adaptive discovery. Do not ask for information that can be obtained from existing evidence.

Ask only the next small set of questions that materially blocks progress. Continue through discovery and preparation of the pre-scaffold proposal, but do not scaffold, install dependencies, initialize repositories, or implement product behaviour until the workflow requires my explicit approval and I provide it.

Initial project context:

[Briefly describe what you want to build, known constraints, existing repositories or files, and decisions already made.]
```

File 2 drives the first session. The agent should take the next permitted bootstrap action rather than merely acknowledge the workflow.

After you approve and complete bootstrap, continue working in the same conversation. Do not use File 4 inside the original bootstrap conversation.

### Prompt 3 — Close The Current Session

Use this in the current project conversation before deliberately changing sessions. It is optional but recommended:

```text
Retrieve and execute the complete canonical Vibe-Coded Project Session Closeout from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/3-vibe-coding-session-closeout.md

Treat this message as my explicit invocation of that workflow and an instruction to perform the closeout now, not as a request to review, summarize, explain, or memorize it.

Resolve the URL's main branch to an exact Git commit, retrieve the complete canonical file with an appropriate tool, verify its identity, revision, exact bytes, digest, and authority as required, and then execute it.

Establish the true stopping state, run the required verification, persist the permitted checkpoint, and complete every publication action authorized by the workflow. If an authority or verification gate prevents an action, preserve the work and report the exact blocker and required next action.
```

File 3 is optional but recommended. It may correctly refuse to commit or push when its authority cannot be verified.

### Prompt 4 — Continue The Project

Use this at the beginning of every later project conversation:

```text
Retrieve and execute the complete canonical Vibe-Coded Project Continuation workflow from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/4-vibe-coding-continuation.md

Treat this message as my explicit invocation of that workflow and an instruction to resume project work, not as a request to review, summarize, explain, or memorize it.

Resolve the URL's main branch to an exact Git commit, retrieve and verify the complete canonical file with an appropriate tool, and then execute it together with my current request.

Verify and load the required project state, route the bootstrap lifecycle, apply the relevant foundation rules, and then perform the current request in this same response whenever it is concrete and unblocked.

Current request:

[Describe the work you want completed in this session.]
```

For later sessions, paste only File 4 and the current request. Do not paste Files 1 or 2 again: File 4 retrieves the foundation and, when necessary, the exact recorded bootstrap revision.

File 4 can recover when the previous session ended without a closeout.

### Manual Fallback

If the agent cannot retrieve a named workflow completely from GitHub, open the linked file, copy it from its title through its final sentence, and paste the complete contents after the same launcher in the same conversation. The agent must still resolve and verify the supplied bytes against an exact canonical revision. Do not use an excerpt or remembered copy. Follow the same order and one-time-use rules described above.

## Maintaining These Files

Before asking an agent to change Files 1–4, tell it to read this README and the complete [maintainer evaluation](workflow-evaluation.md). The evaluation file is the maintenance entry point; it is not a project prompt and should never be pasted into an application-development session.

Run `notes/llm/vibe-coding/scripts/validate-workflow-integrity.sh` before every maintenance commit. It verifies profile, conditional-reference, and server-guide registration; requires absolute links for workflow-owned resources in Files 1–4; checks canonical and relative link targets; and confirms the README's discovery mirrors. The [script roles](scripts/README.md) explain which script runs here and which is copied into an application.

After a workflow change is committed, its exact revision remains `Pending independent review` until a different agent evaluates every fixed scenario. Only then may the current status become `Reviewed`. Do not describe changed workflow files as finished while their recorded revision or status is outdated.
