# Vibe-Coding Project Prompts

These files help an AI coding agent start, build, and continue an application safely.

## How To Use These Files

Copy only the prompt you need from the code blocks below. Do not paste this entire README into the agent.

| What you want to do | Prompt to use |
| --- | --- |
| Start a new project | Prompt 1, followed by Prompt 2 |
| Close the current conversation before moving to a new one | Prompt 3 — optional but recommended |
| Continue the project in a new conversation | Prompt 4 |

Prompt 2 can be used later if Prompt 1 was completed on an earlier date, but only when you are still using the same conversation and its context is still available. In a new conversation, use Prompt 4 instead.

### Prompt 1 — Load The Foundation

Use this once at the start of a new project conversation:

```text
Retrieve and apply the complete canonical Vibe-Coded Project Foundation from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/1-vibe-coding-foundation.md

Treat this message as my explicit invocation of that workflow. Load and apply it now; do not merely review, summarize, or explain it.

Resolve the main branch to an exact Git commit. Retrieve the complete canonical file with an appropriate tool, verify it as required by its loading contract, and apply it as the governing workflow for this project.

Do not begin project discovery or implementation yet. When the Foundation is active, respond briefly that you are ready for File 2. If you cannot retrieve the complete file at an exact revision, report the exact failure and do not claim that the Foundation is active.
```

File 1 loads the project rules. It does not start the project. A short confirmation that the agent is ready for File 2 is the correct response.

### Prompt 2 — Start The Project Bootstrap

Use this after File 1 is active in the same conversation:

```text
The Vibe-Coded Project Foundation is already active in this conversation.

Retrieve and execute the complete canonical Vibe-Coded Project Bootstrap from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/2-vibe-coding-bootstrap.md

Treat this message as my explicit invocation of that workflow and as an instruction to begin bootstrap now. Do not reply with only a review, summary, explanation, or acknowledgement.

Verify the active Foundation's canonical identity, exact revision, and recorded digest or unavailable status. Do not silently replace it with the current Foundation. Resolve the Bootstrap file's main branch to an exact Git commit, retrieve and verify the complete canonical file, and execute it.

If the Foundation is not active and verifiable in this conversation, stop and report that Prompt 2 cannot be used yet. If bootstrap was already completed or retired for this project, do not apply File 2 again; use Prompt 4 instead.

In this response, inspect all available repositories and project material, classify the starting state, and begin adaptive discovery. Do not ask for information that is already available from existing evidence.

Ask only the next small set of questions that blocks progress. Continue through discovery and prepare the pre-scaffold proposal. Do not scaffold, install dependencies, initialize repositories, or implement product behaviour until the workflow requires my explicit approval and I provide it.

Initial project context:

[Briefly describe what you want to build, existing repositories or files, known constraints, and decisions already made.]
```

File 2 must begin the next allowed bootstrap action. It should not respond with only an acknowledgement.

After you approve and complete bootstrap, continue working in the same conversation. Do not use File 4 until you start a new conversation.

### Prompt 3 — Close The Current Conversation

Use this before deliberately moving the project to a new conversation. It is optional but recommended:

```text
Retrieve and execute the complete canonical Vibe-Coded Project Session Closeout from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/3-vibe-coding-session-closeout.md

Treat this message as my explicit invocation of that workflow and as an instruction to perform the closeout now. Do not reply with only a review, summary, explanation, or acknowledgement.

Resolve the main branch to an exact Git commit. Retrieve the complete canonical file with an appropriate tool, verify its identity, revision, exact bytes, digest, and authority as required, and execute it.

Establish the true stopping state, run the required verification, save the permitted checkpoint, and complete every publication action authorized by the workflow. If an authority or verification gate prevents an action, preserve the work and report the exact blocker and next action.
```

File 3 may correctly refuse to commit or push when it cannot verify its authority. Resolve the reported problem or provide separate explicit permission for the specific action. Do not assume the closeout succeeded.

### Prompt 4 — Continue The Project

Use this at the beginning of every later project conversation:

```text
Retrieve and execute the complete canonical Vibe-Coded Project Continuation workflow from:

https://github.com/Razva/public/blob/main/notes/llm/vibe-coding/4-vibe-coding-continuation.md

Treat this message as my explicit invocation of that workflow and as an instruction to resume project work. Do not reply with only a review, summary, explanation, or acknowledgement.

Resolve the main branch to an exact Git commit. Retrieve and verify the complete canonical file with an appropriate tool, and execute it together with my current request.

Load the required project state, route the bootstrap lifecycle, apply the relevant Foundation rules, and perform the current request in this response whenever it is clear and unblocked.

Current request:

[Describe the work you want completed in this conversation.]
```

Do not paste Files 1 or 2 in a later conversation. File 4 retrieves the Foundation and, when necessary, the exact Bootstrap revision saved by the project. It can also recover when the previous conversation ended without using File 3.

### Manual Fallback

If the agent cannot retrieve a workflow from GitHub, open the linked file and copy everything from its title through its final sentence. Paste the complete file after the same prompt in the same conversation. The agent must still resolve and verify those bytes against an exact canonical revision. Never use an excerpt or a remembered copy.

## What These Files Do

| File | Purpose | When to use it |
| --- | --- | --- |
| [1 — Foundation](1-vibe-coding-foundation.md) | Defines the rules used throughout the project. | Once, at the start of a new project conversation. |
| [2 — Bootstrap](2-vibe-coding-bootstrap.md) | Collects project information and creates the approved initial structure. It does not build the first feature. | After File 1. Use it only once per project. |
| [3 — Session closeout](3-vibe-coding-session-closeout.md) | Saves the current state and publishes eligible work. | Optionally, before moving to another conversation. |
| [4 — Continuation](4-vibe-coding-continuation.md) | Loads the project rules and current state in a later conversation. | At the start of every later conversation, together with your request. |

## Conditional References

Files 1–4 are the only project workflow. The files below are optional references, not additional workflows. They cannot grant permission to change files, use Git, publish, deploy, perform external actions, or administer a server.

During bootstrap, File 2 retrieves a reference when the proposed product or technology makes it relevant. The accepted project-specific decisions are then saved in the application's own documentation. Later conversations use that local documentation. The agent retrieves a reusable reference again only when the local documentation has a relevant gap or the owner asks to reconsider it.

| Reference | When it applies |
| --- | --- |
| [Web UI Component Patterns](references/web-ui-component-patterns.md) | The product has a user interface. The agent selects only web-specific patterns that match its surfaces and technology. |
| [TypeScript Project Profile](profiles/typescript.md) | TypeScript is required, already present, or a realistic option for the approved technology. The Next.js section applies only when Next.js is independently relevant. |

The Foundation and approved project contracts always take priority. If a reference conflicts or may conflict with them, the agent must stop applying the conflicting text and report the problem.

This table helps people discover the available references. File 2 remains the authoritative registry and decides when each reference applies.

## Optional Development Server Guidance

The [server guidance](server/README.md) is not a fifth workflow file and is not a required first step. Use the setup guide only when deliberately preparing a self-managed Codex development server or when File 2 finds that an approved readiness capability is missing on one. Once the setup guide is adopted, its documented baseline is required; existing working capabilities are verified and preserved rather than reinstalled. Use the operations guide only for relevant and authorized recurring server work. Each application must keep its own setup and operations instructions in its own documentation.

## Maintaining These Files

Before asking an agent to change Files 1–4, tell it to read this README and the complete [maintainer evaluation](workflow-evaluation.md). The evaluation file is the starting point for maintenance. It is not a project prompt and must not be pasted into an application-development conversation.

Run `notes/llm/vibe-coding/scripts/validate-workflow-integrity.sh` before every maintenance commit. It verifies profile, conditional-reference, and server-guide registration; requires absolute links for workflow-owned resources in Files 1–4; checks canonical and relative link targets; and confirms the README's discovery lists. The [script roles](scripts/README.md) explain which script runs in this repository and which script is copied into an application.

After Files 1–4 change, their exact revision remains `Pending independent review` until a different agent evaluates every fixed scenario. Only then may the status become `Reviewed`. Do not describe changed workflow files as finished while their recorded revision or status is outdated.
