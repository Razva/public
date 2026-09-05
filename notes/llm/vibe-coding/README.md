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
| [Web UI Component Patterns](references/web-ui-component-patterns.md) | The product has a web user interface and reusable component behaviour is relevant. |
| [TypeScript Project Profile](profiles/typescript.md) | TypeScript is required, detected, or a credible candidate for the approved stack. Its Next.js section applies only when Next.js is independently relevant. |

The foundation and approved project contracts always retain their defined precedence. If a reference conflicts or appears to conflict with them, the agent must surface the conflict and stop applying the conflicting reference text.

## Optional Development Server Guidance

The [server guidance](server/README.md) is not a fifth workflow file or a mandatory Step 0. Use its setup reference only when deliberately preparing a self-managed development server or when File 2 finds a missing approved readiness capability. Use its operations reference only for applicable, authorized recurring server work. Application-specific setup and operations remain in the application's own documentation.

## First Session

```text
File 1 → File 2 → continue working → optionally use File 3 before leaving
```

After bootstrap is approved, you may continue working in the same session. Do not use File 4 until you start a later session.

## Later Sessions

```text
File 4 + your request → continue working → optionally use File 3 before leaving
```

Paste only File 4 and your request. You do not need to paste File 1 again because File 4 loads it.

Never paste File 2 again. If bootstrap is still unfinished, File 4 finds the saved bootstrap version and resumes it.

File 3 is not required. File 4 can recover when the previous session ended without a closeout.

File 3 may deliberately refuse to commit or push when it cannot verify its canonical workflow or the required repository authority. Resolve the reported problem or give separate explicit permission for the specific action; do not assume the closeout succeeded.

## Maintaining These Files

Before asking an agent to change Files 1–4, tell it to read this README and the complete [maintainer evaluation](workflow-evaluation.md). The evaluation file is the maintenance entry point; it is not a project prompt and should never be pasted into an application-development session.

After a workflow change is committed, its exact revision remains `Pending independent review` until a different agent evaluates every fixed scenario. Only then may the current status become `Reviewed`. Do not describe changed workflow files as finished while their recorded revision or status is outdated.
