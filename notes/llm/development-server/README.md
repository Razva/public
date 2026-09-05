# Development Server Runbooks

These files preserve reusable infrastructure guidance outside the application-development workflow.

They are operational references, not prompts or authority grants. Before executing a command, apply the [Vibe-Coded Project Foundation](../vibe-coding/1-vibe-coding-foundation.md), the relevant application's canonical deployment and operations contracts, and the owner's current authorization.

| File | Purpose |
| --- | --- |
| [Node And TypeScript Development Server Setup](node-typescript-server-setup.md) | One-time Debian-oriented preparation of a project user, Node, Docker, GitHub CLI, Codex, and optional user-systemd capability. |
| [Node And TypeScript Development Server Operations](node-typescript-server-operations.md) | Recurring read-only inspection and explicitly authorized maintenance of the prepared server. |

Application-specific paths, ports, environment variables, Compose definitions, service units, cache behaviour, and recovery procedures belong in the application's own documentation.
