# TypeScript Reference Profiles

These files preserve TypeScript- and Next.js-specific guidance for projects governed by the [Vibe-Coding Project Prompts](../vibe-coding/README.md).

They are conditional technical references, not workflows. They do not replace, reproduce, weaken, extend, or override the foundation, bootstrap, session-closeout, or continuation workflows. They grant no authority for file mutation, installation, private-memory changes, Git operations, publication, external actions, deployment, production changes, or server administration.

When any reference conflicts or appears to conflict with the Vibe-Coding files or an approved project contract, stop applying the conflicting reference text and surface the conflict. The foundation's complete loading contract and applicability router still apply independently.

## Selection

The bootstrap agent decides whether a profile is applicable from owner constraints, preserved project evidence, and credible technology options. The owner decides whether to adopt the proposed stack and profile choices through the complete bootstrap proposal.

| Profile | Load when |
| --- | --- |
| [TypeScript Project Profile](typescript-project-profile.md) | TypeScript is required, detected, or a credible candidate for the recommended baseline. |
| [Next.js Project Profile](nextjs-project-profile.md) | Next.js is independently required, detected, or a credible candidate. TypeScript alone does not trigger it. |
| [Web UI Component Patterns](../vibe-coding/references/web-ui-component-patterns.md) | The product has a web UI and reusable component behaviour is relevant. |

During bootstrap, retrieve each applicable reference completely at an exact revision, include its proposed adoptions and deviations in the pre-scaffold proposal, and write only approved project-specific choices into the application's canonical documentation.

For an established project, existing code, configuration, and approved local contracts take precedence. Consult these profiles only when a relevant local contract is missing, the task changes project-wide technology conventions, or the owner asks to reconsider the baseline. Never silently update an application because a reusable profile changed.

## Supporting Material

- [Node And TypeScript Development Server Setup](../development-server/node-typescript-server-setup.md) prepares an eligible development server after the required administrative authority is provided.
- [Node And TypeScript Development Server Operations](../development-server/node-typescript-server-operations.md) provides recurring inspection and maintenance commands under the application's operational contract.
- [`scripts/clear-next-dev-cache.sh`](scripts/clear-next-dev-cache.sh) is a guarded template to copy into a Next.js application's `scripts/` directory when that workflow is approved.

The former `typescript-app-bootstrap.md` and `new-session.md` files are retired compatibility notices. Do not paste or apply them as project prompts.
