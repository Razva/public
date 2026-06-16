# TypeScript Server Setup Commands

Use this file for server-level setup before starting a new TypeScript app with an assistant. These commands are for the user or server admin, not for the assistant when it lacks root privileges.

## Baseline Apt Packages

Install baseline TypeScript app tooling, optional debugging tools, Postgres client utilities, and Playwright Chromium OS dependencies with apt. This command excludes Node and Docker because they should be installed from their official upstream instructions.

```bash
sudo apt update && sudo apt install -y \
  git gh ripgrep jq curl iproute2 systemd login \
  ca-certificates openssl \
  procps lsof \
  unzip zip tar rsync \
  build-essential python3 \
  postgresql-client \
  fontconfig fonts-liberation fonts-noto-color-emoji \
  libasound2t64 \
  libatk-bridge2.0-0t64 libatk1.0-0t64 libatspi2.0-0t64 \
  libcairo2 libcups2t64 \
  libdrm2 libgbm1 libglib2.0-0t64 libgtk-3-0t64 \
  libnspr4 libnss3 libpango-1.0-0 \
  libx11-6 libx11-xcb1 libxcb1 \
  libxcomposite1 libxdamage1 libxext6 libxfixes3 \
  libxrandr2 libxrender1 \
  xvfb
```

## Docker

Install Docker from the official [Docker Engine on Debian](https://docs.docker.com/engine/install/debian/) guide.

Prefer Docker's apt repository path so Docker Engine and the Compose plugin are managed by apt.

## Node

Download Node from the official [Node.js downloads](https://nodejs.org/en/download) page using the **Standalone Binary** option for the chosen major version.

Then run the equivalent of this as root, replacing the version/path as needed:

```bash
sudo mkdir -p /opt/node &&
sudo tar -xJf node-v24.*-linux-x64.tar.xz -C /opt/node &&
sudo mv /opt/node/node-v24.*-linux-x64 /opt/node/node24 &&
sudo ln -sfn /opt/node/node24/bin/node /usr/local/bin/node &&
sudo ln -sfn /opt/node/node24/bin/npm /usr/local/bin/npm &&
sudo ln -sfn /opt/node/node24/bin/npx /usr/local/bin/npx &&
sudo ln -sfn /opt/node/node24/bin/corepack /usr/local/bin/corepack
```

When changing the system Node version, rerun the symlink commands above so assistant shells and services continue to use the intended binaries.

### Per-User npm Global Prefix

The OS Node prefix should remain owned by root or the server admin. Do not make `/opt/node`, `/usr/local`, or the OS Node install prefix writable by project users, and do not install project-specific global npm packages there.

Configure npm globals from the project user's own shell. Do not run these npm configuration commands as root, and do not run them as root on behalf of the user with `sudo -u`; that can leave npm config, cache, or shell profile changes attached to the wrong environment.

Use `$HOME/.local/share/npm` as the recommended per-user npm global prefix. If the project user does not already have a home directory, create or fix that account first as root/server admin. Then switch to the project user with a normal login shell and run:

```bash
mkdir -p "$HOME/.local/share/npm" &&
npm config set prefix "$HOME/.local/share/npm" &&
npm config get prefix
```

Add the user global npm bin directory to that same user's interactive shell path:

```bash
grep -qxF 'export PATH="$HOME/.local/share/npm/bin:$PATH"' "$HOME/.profile" || 
  printf '\nexport PATH="$HOME/.local/share/npm/bin:$PATH"\n' >> "$HOME/.profile"
```

Reload the profile or start a new login shell, then verify as the same user:

```bash
. "$HOME/.profile" &&
command -v npm &&
command -v npx &&
npm config get prefix
```

Install global project-user tools by running npm as the project user after this prefix is configured. Do not use `sudo npm install -g` for assistant or project-user tooling.

## Verify Install

As user, check the expected tools after setup:

```bash
gh --version \
git --version \
node --version \
npm --version \
npx --version \
corepack --version \
docker --version \
docker compose version \
rg --version \
jq --version \
curl --version \
psql --version
```

### Playwright

After Node and project dependencies are available, install Playwright's managed Chromium browser:

```bash
npm install playwright &&
npx playwright install chromium
```

## SSH Management

### Client

#### Generate SSH key (client)
```bash
ssh-keygen -t ed25519 -C "your_name_or_email" -f ~/.ssh/key_name
```

#### Configure ssh/config
```bash
nano ~/.ssh/config
```

```text
Host some_hostname
  HostName some_ip
  Port some_port
  User some_user
  IdentityFile ~/.ssh/key_name
```

```bash
cat ~/.ssh/key_name
```

### Server

#### Install SSH key (server)
```bash
mkdir ~/.ssh &&
touch ~/.ssh/authorized_keys &&
chmod 700 ~/.ssh &&
chmod 600 ~/.ssh/authorized_keys
```

```bash
nano ~/.ssh/authorized_keys
```

## Codex

### Codex Installation

Install Codex as the same project user:

```bash
npm i -g @openai/codex &&
command -v codex &&
codex --version
```

### Codex Project Settings

Run `codex` once in order for authentication and initial file structure creation.

Allow Codex to control the entire project. WARNING: be extra-careful, ensure that the UNIX user doesn't have `root` or `sudo` access!

```bash
nano ~/.codex/config.toml
```

```text
model = "gpt-X.X"
model_reasoning_effort = "high"
approval_policy = "never"
sandbox_mode = "danger-full-access"
personality = "pragmatic"

[projects."/home/user/project"]
trust_level = "trusted"

[plugins."codex-security@openai-curated"]
enabled = true

[plugins."github@openai-curated"]
enabled = true
```

### Update Codex

```bash
npm install -g @openai/codex
```

Crontab for updating Codex daily at 6:

```bash
0 6 * * * npm install -g @openai/codex
```

## Persistent User Services

### Enable `linger`

If using a persistent user-level systemd service and the service must survive logout or reboot, enable linger once as root:

```bash
sudo loginctl enable-linger <user>
loginctl show-user <user> | grep Linger
```

### Create service

Create the service in the user's directory:

```bash
mkdir -p ~/.config/systemd/user
nano ~/.config/systemd/user/<my-app>.service
```

Add the service:

```bash
[Unit]
Description=<My App Description>
After=default.target

[Service]
Type=simple
WorkingDirectory=/home/<user>/<workdir>
Environment=NODE_ENV=development
Environment=PORT=<next-server-port>
Environment=NEXT_TELEMETRY_DISABLED=1
Environment=PATH=/usr/local/bin:/usr/bin:/bin
ExecStartPre=/usr/bin/rm -rf /home/<user>/<workdir>/.next/dev/cache/turbopack
ExecStart=/usr/local/bin/npm run dev
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
```

For Next.js dev services, keep the `ExecStartPre` line. It clears only the
Turbopack dev cache before the process starts, which avoids reusing a corrupted
`.next/dev/cache/turbopack` database without deleting the rest of `.next` while
the app is running.

Do not run `npm run build`, broad `.next` cleanup, or cache-clearing scripts
against the same checkout while `next dev` is running. Stop the user service
first, or use a separate checkout/worktree or separate Next `distDir` for
builds. If a cache-clear script is used, make it stop and restart only the
matching user service around the cleanup.

#### Reload daemon & check

```bash
systemctl --user daemon-reload &&
systemd-analyze --user verify ~/.config/systemd/user/<my-app>.service &&
journalctl --user -u <my-app>.service -f
```

### Disable `--machine=` requirement

Edit `~/.bashrc`.

```
export XDG_RUNTIME_DIR=/run/user/$(id -u)
```

Logout/login or `source ~/.bashrc`.

### Manage service

Manage the service as usual.

```bash
systemctl --user status <my-app>
systemctl --user stop <my-app>
systemctl --user start <my-app>
systemctl --user disable <my-app>
systemctl --user enable <my-app>
```

## Server Health & Codex Monitoring

### Quick Health Snapshot

One-command overview of system health and Codex activity.

```bash
echo "==== $(date) ===="
free -h

echo
echo "Codex total:"
pgrep -af 'codex app-server --listen' | wc -l

echo
echo "Codex ws:// sessions:"
pgrep -af 'codex app-server --listen ws://' | wc -l

echo
echo "Memory by user:"
tmp=$(mktemp); smem -u -c "user uss pss rss" -k > "$tmp"; echo "=== Top Memory Consumers ==="; (head -1 "$tmp"; tail -n +2 "$tmp" | sort -k3 -hr | head -10) | column -t; echo; echo "=== Total ==="; printf "%-10s %-10s %-10s %-10s %-10s\n" "Count" "Swap" "USS" "PSS" "RSS"; smem -u -tk | tail -1 | column -t; rm -f "$tmp"
```

### Expected Healthy Baseline

Typical healthy state after reboot:

```text
Memory Usage (PSS): ~2–4 GB
Codex App Servers: 3–10
WebSocket Sessions: 0–5
Orphaned Sessions: 0
```

Potential issue indicators:

```text
WebSocket Sessions continuously increasing
Large numbers of PPID=1 Codex processes
Codex sessions older than several days
Memory usage growing without corresponding workload
```

---

### Memory Usage by User

Provides a quick summary of RAM usage per user, including total system memory consumption.

```bash
tmp=$(mktemp); smem -u -c "user uss pss rss" -k > "$tmp"; echo "=== Top Memory Consumers ==="; (head -1 "$tmp"; tail -n +2 "$tmp" | sort -k3 -hr | head -10) | column -t; echo; echo "=== Total ==="; printf "%-10s %-10s %-10s %-10s %-10s\n" "Count" "Swap" "USS" "PSS" "RSS"; smem -u -tk | tail -1 | column -t; rm -f "$tmp"
```

---

### Total Active Codex App Servers

Shows the total number of running Codex app-server instances.

```bash
pgrep -af 'codex app-server --listen' | wc -l
```

---

### Active WebSocket Codex Sessions

Shows Codex app-server instances using `ws://` listeners, which are typically transient session workers and the primary indicator of session accumulation.

```bash
pgrep -af 'codex app-server --listen ws://'
```

Count only:

```bash
pgrep -af 'codex app-server --listen ws://' | wc -l
```

---

### Orphaned Codex Sessions

Shows Codex app-server processes that have been adopted by PID 1, indicating their original parent process exited without cleaning them up.

```bash
ps -eo pid,ppid,user,etimes,cmd \
| awk '$2 == 1 && /codex app-server --listen/ {print}'
```

---

### Old Codex Sessions (>24h)

Shows Codex sessions older than one day.

```bash
ps -eo pid,ppid,user,etimes,etime,cmd \
| awk '/codex app-server --listen/ && $4 > 86400 {print}'
```

---

### Codex Sessions by User

Shows how many Codex sessions are owned by each user.

```bash
ps -eo user,cmd \
| awk '/codex app-server --listen/ && !/awk/ {count[$1]++} END {for (u in count) print u,count[u]}'
```

---

### Codex Parent Summary

Shows which parent processes spawned Codex sessions.

A large number of sessions under PPID `1` is a strong indicator of orphaned processes.

```bash
ps -eo pid,ppid,user,cmd \
| grep 'codex app-server --listen' \
| grep -v grep \
| awk '{count[$2]++} END {for (p in count) print count[p], p}' \
| sort -nr
```

---

### Next.js Process Check

Lists all active Next.js processes and their memory usage.

```bash
ps -eo pid,ppid,user,etimes,rss,cmd \
| grep -E 'next-server|next start' \
| grep -v grep
```

---

### Top Memory Consumers by PSS

Shows the largest memory consumers using PSS (Proportional Set Size), which is the most accurate representation of actual memory usage.

```bash
smem -c "pid user pss uss rss command" -tk \
| sort -k3 -hr \
| head -40
```

---

### Largest Processes by RSS

Quick overview of the largest processes by RSS.

```bash
ps -eo pid,user,etimes,rss,cmd --sort=-rss | head -30
```

---

### User Services Audit

Lists all user-managed systemd services with key configuration details.

```bash
find /home -path '*/.config/systemd/user/*.service' -type f \
  -exec echo "==== {} ====" \; \
  -exec grep -E '^(Description|WorkingDirectory|ExecStart|Restart|MemoryMax)' {} \;
```

---

### Running User Services

Lists active user services for application users.

```bash
for u in <user1> <user2> <user3> <userX>; do
  echo "=== $u ==="
  systemctl --machine=$u@.host --user list-units --type=service --no-pager 2>/dev/null
done
```
