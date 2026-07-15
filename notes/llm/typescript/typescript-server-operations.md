# TypeScript Development Server Operations

Use this runbook for recurring maintenance and monitoring after [typescript-server-setup.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-server-setup.md) is complete. It is not part of one-shot server or app bootstrap.

App-specific service names, paths, ports, environment variables, restart procedures, and cache behavior belong in each app’s public operations documentation.

## Operational Boundaries

- Run server-wide inspection as an approved administrator.
- Run user-service commands as the user that owns the service unless the command explicitly uses `systemctl --machine=<user>@.host` for administrator inspection.
- Do not stop, restart, kill, disable, or edit an app merely because it appears in an audit. Inspect its app documentation and obtain authorization first.
- Do not print environment files, credentials, tokens, cookies, private payloads, or customer data during diagnostics.

## Codex Maintenance

Check the installed version as the project user:

```bash
command -v codex
codex --version
```

Update Codex through the same user-owned npm global prefix used during server setup:

```bash
npm install -g @openai/codex
codex --version
```

Do not use `sudo npm install -g`. Treat unattended automatic updates as an explicit operational choice because a new CLI release can change behavior. If automatic updates are desired, document the schedule, owner, rollback path, and verification command rather than adding an unexplained cron entry.

## User-Service Management

Use the service name documented by the app:

```bash
systemctl --user status <app>.service
systemctl --user restart <app>.service
systemctl --user stop <app>.service
systemctl --user start <app>.service
systemctl --user enable <app>.service
systemctl --user disable <app>.service
journalctl --user -u <app>.service -f
```

After intentionally editing a unit:

```bash
systemd-analyze --user verify "$HOME/.config/systemd/user/<app>.service"
systemctl --user daemon-reload
systemctl --user restart <app>.service
```

Do not run a production build or broad cache cleanup against the same checkout while a development service is running. Follow the app’s documented stop/build/restart or separate-worktree workflow.

## Quick Health Snapshot

```bash
date
free -h
uptime

echo "Codex app servers:"
pgrep -af 'codex app-server --listen' | wc -l

echo "Codex WebSocket sessions:"
pgrep -af 'codex app-server --listen ws://' | wc -l

echo "Memory by user:"
smem -u -c "user uss pss rss" -k
```

Interpret the output relative to the server’s workload and historical baseline. Fixed process-count or memory thresholds are not universal health guarantees.

## Codex Process Audits

List all Codex app servers:

```bash
pgrep -af 'codex app-server --listen'
```

List WebSocket listeners, which are commonly transient session workers:

```bash
pgrep -af 'codex app-server --listen ws://'
```

Find processes adopted by PID 1 after their original parent exited:

```bash
ps -eo pid,ppid,user,etimes,cmd \
| awk '$2 == 1 && /codex app-server --listen/ {print}'
```

Find Codex sessions older than 24 hours:

```bash
ps -eo pid,ppid,user,etimes,etime,cmd \
| awk '/codex app-server --listen/ && $4 > 86400 {print}'
```

Count sessions by user:

```bash
ps -eo user,cmd \
| awk '/codex app-server --listen/ && !/awk/ {count[$1]++} END {for (u in count) print u,count[u]}'
```

Summarize parent processes:

```bash
ps -eo pid,ppid,user,cmd \
| grep 'codex app-server --listen' \
| grep -v grep \
| awk '{count[$2]++} END {for (p in count) print count[p], p}' \
| sort -nr
```

Treat these as diagnostic signals. Do not kill processes solely because they are old or parented by PID 1; confirm whether they are active, expected, and safe to stop.

## Application Process Audits

List active Next.js processes and memory usage:

```bash
ps -eo pid,ppid,user,etimes,rss,cmd \
| grep -E 'next-server|next start' \
| grep -v grep
```

List the largest processes by proportional set size:

```bash
smem -c "pid user pss uss rss command" -tk \
| sort -k3 -hr \
| head -40
```

List the largest processes by resident set size:

```bash
ps -eo pid,user,etimes,rss,cmd --sort=-rss | head -30
```

## User-Service Audit

Inspect user unit definitions without modifying them:

```bash
find /home -path '*/.config/systemd/user/*.service' -type f \
  -exec echo "==== {} ====" \; \
  -exec grep -E '^(Description|WorkingDirectory|EnvironmentFile|ExecStart|Restart|MemoryMax)' {} \;
```

As an administrator, list running services for selected application users:

```bash
for user in <user1> <user2> <user3>; do
  echo "=== $user ==="
  systemctl --machine="$user@.host" --user list-units --type=service --no-pager
done
```

If `systemctl --machine=` is unavailable in the current environment, inspect from each user’s normal login session instead of adding shell-profile workarounds globally.

## Operational Handoff

After an approved maintenance action, record:

- what was inspected or changed;
- affected users, services, and apps;
- commands and results;
- whether a restart occurred;
- remaining risks or follow-up work;
- final service and working-tree state when relevant.
