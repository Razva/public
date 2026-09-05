# Development Server Operations

Use this reference for applicable recurring inspection and separately authorized maintenance on a self-managed development server. It is not part of the four-file Vibe-Coding workflow and grants no inspection, mutation, restart, installation, or administrator authority.

Apply the [Vibe-Coded Project Foundation](../1-vibe-coding-foundation.md), the application's canonical operations contract, and the owner's current authorization before executing commands. [Development Server Setup](setup.md) owns missing reusable machine or user capabilities.

Application-specific service names, paths, ports, environment variables, restart procedures, cache behavior, health checks, backup, and recovery belong in each application's public operations documentation.

## Operational Boundaries

- Run server-wide inspection only as an approved administrator.
- Run user-service commands as the user that owns the service unless an approved administrator procedure explicitly uses `systemctl --machine=<user>@.host`.
- Do not stop, restart, kill, disable, update, or edit an application or tool merely because it appears in an audit.
- Do not print environment files, credentials, tokens, cookies, private payloads, customer data, or unrestricted process environments during diagnostics.
- Interpret health signals against the server's workload, configuration, and historical baseline; fixed process-count or memory thresholds are not universal guarantees.

## General Health Snapshot

Use only commands available through the selected setup capabilities:

```bash
date
free -h
uptime
smem -u -c "user uss pss rss" -k
ps -eo pid,user,etimes,rss,cmd --sort=-rss | head -30
```

Record the observation time and relevant workload. An isolated snapshot does not prove a leak, incident, or safe-to-kill process.

## General Process And Service Inspection

List the largest processes by proportional set size when `smem` is available:

```bash
smem -c "pid user pss uss rss command" -tk | sort -k3 -hr | head -40
```

Use the application service name documented by the project:

```bash
systemctl --user status <app>.service
journalctl --user -u <app>.service -f
```

These mutations require separate operational authority:

```bash
systemctl --user restart <app>.service
systemctl --user stop <app>.service
systemctl --user start <app>.service
systemctl --user enable <app>.service
systemctl --user disable <app>.service
```

After an intentionally authorized unit edit:

```bash
systemd-analyze --user verify "$HOME/.config/systemd/user/<app>.service"
systemctl --user daemon-reload
systemctl --user restart <app>.service
```

Do not run a build or broad cache cleanup against the same checkout while its development service is running. Follow the application's documented stop/build/restart or isolated-worktree procedure.

## Cross-User Service Audit

An approved administrator may inspect selected users' unit definitions without modifying them:

```bash
find /home -path '*/.config/systemd/user/*.service' -type f \
  -exec grep -HE '^(Description|WorkingDirectory|EnvironmentFile|ExecStart|Restart|MemoryMax)' {} \;
```

List running services for explicitly selected application users:

```bash
for user in <user1> <user2> <user3>; do
  systemctl --machine="$user@.host" --user list-units --type=service --no-pager
done
```

If `systemctl --machine=` is unavailable, inspect from each user's normal login session instead of adding global shell-profile workarounds.

## Conditional Codex Maintenance

Apply this section only when Codex is an approved server capability. Check the installed version as the project user:

```bash
command -v codex
codex --version
```

An explicitly authorized update must use the same user-owned npm global prefix selected during setup:

```bash
npm install -g @openai/codex
codex --version
```

Do not use `sudo npm install -g`. Treat unattended updates as a separate operational decision because a CLI release can change behavior. Document any approved schedule, owner, rollback path, and verification command rather than adding an unexplained scheduled task.

## Conditional Codex Process Audit

Apply this section only when diagnosing Codex app-server processes is within scope. List processes and WebSocket listeners:

```bash
pgrep -af 'codex app-server --listen'
pgrep -af 'codex app-server --listen ws://'
```

Find processes adopted by PID 1 after their original parent exited:

```bash
ps -eo pid,ppid,user,etimes,cmd \
| awk '$2 == 1 && /codex app-server --listen/ {print}'
```

Find sessions older than 24 hours and count sessions by user:

```bash
ps -eo pid,ppid,user,etimes,etime,cmd \
| awk '/codex app-server --listen/ && $4 > 86400 {print}'

ps -eo user,cmd \
| awk '/codex app-server --listen/ && !/awk/ {count[$1]++} END {for (u in count) print u,count[u]}'
```

Treat these as diagnostic signals. Do not kill a process solely because it is old or parented by PID 1; confirm whether it is active, expected, and safe to stop.

## Conditional Node And Next.js Inspection

Apply this section only to an application whose local operations contract identifies Node or Next.js processes:

```bash
ps -eo pid,ppid,user,etimes,rss,cmd \
| grep -E 'node|next-server|next start' \
| grep -v grep
```

Resolve the result against the documented user, path, service, port, and workload before drawing conclusions. For an adopted Next.js cache-recovery workflow, use the project's copy of the guarded [cache-clearing template](../scripts/clear-next-dev-cache.sh) only under the application's stop/restart contract.

## Operational Handoff

After an approved inspection or maintenance action, record:

- what was inspected or changed;
- affected users, services, and applications;
- commands and results;
- whether a restart occurred;
- remaining risks or follow-up work; and
- final service and working-tree state when relevant.
