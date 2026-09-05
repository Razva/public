# Development Server Guidance

These files provide reusable guidance for self-managed Codex development servers. They belong beside the [Vibe-Coding workflow](../README.md), but they are not a fifth workflow file, a mandatory Step 0, or an authority grant.

Use [setup.md](setup.md) in either of two situations:

- the owner deliberately prepares a development server before starting an application workflow; or
- File 2 readiness checks find a missing machine- or user-level capability required by the approved project.

After setup, begin or resume the ordinary workflow at the stage it already reached. Do not invent a separate server lifecycle.

When the setup guide is adopted, its core command-line tools, project user, SSH access, Node runtime, GitHub CLI, and Codex capabilities form the required baseline. Existing working capabilities are verified and preserved rather than reinstalled. Browser automation, Docker and Compose, the PostgreSQL client, and persistent user services remain optional and are selected only when needed.

Use [operations.md](operations.md) only for applicable recurring inspection or separately authorized maintenance. Before executing any command, apply the [Vibe-Coded Project Foundation](../1-vibe-coding-foundation.md), the application's canonical deployment and operations contracts, and the owner's current authorization.

| Reference | Purpose |
| --- | --- |
| [Development Server Setup](setup.md) | Verifies the required Codex/GitHub server baseline and prepares only the optional capabilities an approved project needs. |
| [Development Server Operations](operations.md) | Provides general inspection and conditional service, Codex, Node, and Next.js procedures. |

Application-specific paths, ports, environment variables, Compose definitions, service units, cache behavior, health checks, backup, and recovery procedures belong in the application's own documentation.
