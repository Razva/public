# Vibe-Coding Project Prompts

These files help an AI coding agent start, build, and continue an application safely. They are designed to be used together.

This README is for people. Do not paste it into the coding agent.

When using one of the four prompt files, copy and paste the complete file. Do not copy only one section.

| File | Purpose | When to use it |
| --- | --- | --- |
| [1 — Foundation](1-vibe-coding-foundation.md) | The rules used throughout the project. The agent loads the parts relevant to each task. | Paste it once at the start of a new project. |
| [2 — Bootstrap](2-vibe-coding-bootstrap.md) | Collects project details and creates the initial structure. It does not build the first feature. | Paste it after File 1. Use it only once per project. |
| [3 — Session closeout](3-vibe-coding-session-closeout.md) | Saves the current state in the project repositories and publishes eligible work. | Paste it into the current session before changing sessions. It is optional but recommended. |
| [4 — Continuation](4-vibe-coding-continuation.md) | Loads the rules and current project state for a later session. | Paste it at the start of every later session, together with your new request. |

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

## How To Start The Agent

The workflow file defines how the agent must work, but it does not automatically tell the agent to begin. Paste the corresponding invocation text immediately above the complete file.

Do not paste only the invocation. The complete workflow file must follow it in the same message.

### First Session — Step 1: Load The Foundation

Copy this text, then paste the complete contents of File 1 immediately below it:

```text
Load and apply the complete Vibe-Coded Project Foundation below as the governing workflow for this project.

This is an invocation of the workflow, not a request to review, summarize, explain, or merely remember it. Read and verify it completely as required by its loading contract.

Do not begin project discovery or implementation yet. When the foundation is active, respond briefly that you are ready for File 2.

The complete foundation begins below:
```

File 1 deliberately establishes the working rules without starting the project. A short readiness confirmation is the expected result.

### First Session — Step 2: Execute Bootstrap

After the agent confirms that File 1 is active, copy this text and paste the complete contents of File 2 immediately below it:

```text
The Vibe-Coded Project Foundation is active. Now invoke and execute the complete Vibe-Coded Project Bootstrap below for this project.

This is an instruction to begin the bootstrap now, not a request to review, summarize, explain, or memorize the workflow.

In this response, verify the supplied workflows, inspect all available repositories and project material, classify the starting state, and begin adaptive discovery. Do not ask for information that can be obtained from existing evidence.

Ask only the next small set of questions that materially blocks progress. Continue through discovery and preparation of the pre-scaffold proposal, but do not scaffold, install dependencies, initialize repositories, or implement product behaviour until the workflow requires my explicit approval and I provide it.

Initial project context:

[Briefly describe what you want to build, known constraints, existing repositories or files, and decisions already made.]

The complete bootstrap workflow begins below:
```

File 2 drives the first session. The agent should take the next permitted bootstrap action rather than merely acknowledge the workflow.

After you approve and complete bootstrap, continue working in the same conversation. Do not use File 4 inside the original bootstrap conversation.

### Before Leaving A Session — Optional Closeout

Copy this text, then paste the complete contents of File 3 immediately below it:

```text
Invoke and execute the complete Vibe-Coded Project Session Closeout below now.

This is an instruction to perform the closeout, not to review, summarize, explain, or memorize it.

Establish the true stopping state, run the required verification, persist the permitted checkpoint, and complete every publication action authorized by the workflow. If an authority or verification gate prevents an action, preserve the work and report the exact blocker and required next action.

The complete closeout workflow begins below:
```

File 3 is optional but recommended. It may correctly refuse to commit or push when its authority cannot be verified.

### Later Sessions — Continue The Project

Copy this text, add your current request, and then paste the complete contents of File 4 immediately below it:

```text
Invoke and execute the complete Vibe-Coded Project Continuation workflow below for this project.

This is an instruction to resume project work, not to review, summarize, explain, or memorize the workflow.

Verify and load the required project state, route the bootstrap lifecycle, apply the relevant foundation rules, and then perform the current request in this same response whenever it is concrete and unblocked.

Current request:

[Describe the work you want completed in this session.]

The complete continuation workflow begins below:
```

For later sessions, paste only File 4 and the current request. Do not paste Files 1 or 2 again: File 4 retrieves the foundation and, when necessary, the exact recorded bootstrap revision.

File 4 can recover when the previous session ended without a closeout.

## Maintaining These Files

Before asking an agent to change Files 1–4, tell it to read this README and the complete [maintainer evaluation](workflow-evaluation.md). The evaluation file is the maintenance entry point; it is not a project prompt and should never be pasted into an application-development session.

Run `notes/llm/vibe-coding/scripts/validate-workflow-integrity.sh` before every maintenance commit. It verifies profile, conditional-reference, and server-guide registration; requires absolute links for workflow-owned resources in Files 1–4; checks canonical and relative link targets; and confirms the README's discovery mirrors. The [script roles](scripts/README.md) explain which script runs here and which is copied into an application.

After a workflow change is committed, its exact revision remains `Pending independent review` until a different agent evaluates every fixed scenario. Only then may the current status become `Reviewed`. Do not describe changed workflow files as finished while their recorded revision or status is outdated.
