# TypeScript Development Server Setup

Use this file once when provisioning a development server or when adding a new project user. It prepares reusable machine- and user-level capabilities; it does not create an application.

After the server is ready, use [typescript-app-bootstrap.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-app-bootstrap.md) once for each new app. Use [typescript-server-operations.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-server-operations.md) for recurring maintenance and monitoring.

## Lifecycle Boundary

This setup owns:

- operating-system packages;
- project-user accounts and SSH access;
- the system Node runtime and per-user npm global prefix;
- Docker installation and user access;
- GitHub CLI and Codex availability;
- optional user-level systemd capability;
- a final server-readiness check.

This setup does not own:

- app repositories or dependencies;
- app ports, environment variables, or Docker Compose definitions;
- project-specific Codex configuration;
- app-specific systemd unit files;
- ongoing app or server operations.

Run privileged commands as the server administrator. Run user-scoped commands from the project user’s normal login shell. Do not give the project user `sudo` merely so an assistant can complete setup.

## Project User

If the user does not already exist, create it with a home directory and a normal login shell:

```bash
useradd -m <user>
```

Optionally, change the user's shell to `/bin/bash`:

```bash
chsh <user>
```

Keep each app checkout and its private environment owned by the project user that runs it.

## SSH Access

Generate a client key if needed:

```bash
ssh-keygen -t ed25519 -C "your_name_or_email" -f ~/.ssh/key_name
cat ~/.ssh/key_name.pub
```

Never print or copy `~/.ssh/key_name`; that is the private key.

On the server, prepare the project user’s authorized-keys file:

```bash
mkdir -p ~/.ssh &&
touch ~/.ssh/authorized_keys &&
chmod 700 ~/.ssh &&
chmod 600 ~/.ssh/authorized_keys
```

Append the public key to `~/.ssh/authorized_keys`, then test a fresh SSH login before continuing.

An optional client entry can keep connection details explicit:

```text
Host some_hostname
  HostName some_ip
  Port some_port
  User some_user
  IdentityFile ~/.ssh/key_name
```

## Baseline Apt Packages

Install baseline TypeScript tooling, debugging utilities, Postgres client utilities, browser OS dependencies, and the tools used by the operations runbook. This Debian-oriented package list excludes Node and Docker because those should come from their official upstream installation paths.

```bash
sudo apt update
sudo apt install -y \
  git gh ripgrep jq curl iproute2 systemd login \
  ca-certificates openssl \
  procps lsof smem bsdextrautils \
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

If the distribution uses different package names, translate this list for that distribution instead of forcing Debian-specific packages.

## Docker Engine

Install Docker from the official [Docker Engine installation guide](https://docs.docker.com/engine/install/). Prefer Docker’s official apt repository on supported Debian/Ubuntu systems so Docker Engine and the Compose plugin are managed by apt.

If the project user will use the rootful Docker daemon without `sudo`, follow Docker’s [Linux post-installation guidance](https://docs.docker.com/engine/install/linux-postinstall/):

```bash
sudo usermod -aG docker <user>
```

The user must start a new login session before the new group membership is reliably available. Membership in the `docker` group grants root-level privileges; decide deliberately whether that is acceptable for the server. Use Docker rootless mode instead when that boundary is required.

Verify from a fresh project-user login:

```bash
id
docker version
docker compose version
docker run --rm hello-world
```

Do not use `sudo docker` from app workflows. If Docker access fails, repair the server/user configuration here instead of adding Docker permission workarounds to an app.

## System Node Runtime

Download the selected Node LTS standalone binary from the official [Node.js downloads](https://nodejs.org/en/download) page.

Install it as root, replacing the version and architecture values as needed:

```bash
NODE_VERSION="<version>"
NODE_MAJOR="<major>"
NODE_ARCH="x64"

sudo mkdir -p /opt/node
sudo tar -xJf "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" -C /opt/node
sudo mv "/opt/node/node-v${NODE_VERSION}-linux-${NODE_ARCH}" "/opt/node/node${NODE_MAJOR}-${NODE_VERSION}"
sudo ln -sfn "/opt/node/node${NODE_MAJOR}-${NODE_VERSION}" "/opt/node/node${NODE_MAJOR}"
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/node" /usr/local/bin/node
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/npm" /usr/local/bin/npm
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/npx" /usr/local/bin/npx
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/corepack" /usr/local/bin/corepack
```

When changing the system Node version, refresh all four symlinks so non-interactive shells and persistent services use the intended runtime.

Keep `/opt/node`, `/usr/local`, and the system Node prefix owned by root. Never make them writable by project users.

## Per-User npm Global Prefix

Configure global developer tools from the project user’s normal login shell. Do not run these commands as root or through `sudo -u`.

```bash
mkdir -p "$HOME/.local/share/npm"
npm config set prefix "$HOME/.local/share/npm"
npm config get prefix
```

Add the bin directory to the same user’s login path:

```bash
grep -qxF 'export PATH="$HOME/.local/share/npm/bin:$PATH"' "$HOME/.profile" || \
  printf '\nexport PATH="$HOME/.local/share/npm/bin:$PATH"\n' >> "$HOME/.profile"
```

Start a new login shell, then verify:

```bash
command -v node
command -v npm
command -v npx
npm config get prefix
```

Install global project-user tools only after the prefix points inside the user’s home. Do not use `sudo npm install -g`.

## GitHub CLI

Authenticate as the project owner or approved human account from the project user’s shell:

```bash
gh --version
gh auth login
gh auth status
```

Do not configure a placeholder, assistant, model, or automation Git identity. App-specific Git identity and repository creation belong to app bootstrap.

## Codex

Install Codex as the project user after the per-user npm prefix is configured:

```bash
npm install -g @openai/codex
command -v codex
codex --version
```

Run `codex` once for authentication and initial user-level file creation.

User-wide defaults belong in `~/.codex/config.toml`. Project-specific settings belong in a trusted app’s `.codex/config.toml` and are created during app bootstrap. Prefer the current official [Codex configuration documentation](https://learn.chatgpt.com/docs/config-file/config-basic) over copied model names or stale sample values.

A conservative user-level starting point is:

```toml
approval_policy = "on-request"
sandbox_mode = "workspace-write"
personality = "pragmatic"
```

For a dedicated, non-sudo project user that the owner explicitly wants Codex to control without approval prompts, the broader combination is:

```toml
approval_policy = "never"
sandbox_mode = "danger-full-access"
personality = "pragmatic"
```

Use the broader profile only when the user explicitly accepts the boundary, and never compensate for it by granting the Unix user `sudo`.

Use `/plugins` in Codex CLI or the current Codex plugin settings UI to browse, install, and enable approved plugins. Do not copy plugin-enable TOML from an older setup. Installing Codex Security or another scanner does not authorize running scans; scan execution remains explicitly task-authorized.

## Optional Browser Capability

The baseline packages provide common Chromium OS libraries. Do not run `npm install playwright` in this server setup; project dependencies and managed browser installation belong to app bootstrap and only when browser automation is explicitly selected for that app.

## Optional User-Level systemd Capability

A real app service cannot be defined until the app path, command, port, and environment exist. Server setup should only make persistent user services possible.

If the project user will need services that survive logout or reboot, enable [user lingering](https://www.freedesktop.org/software/systemd/man/latest/loginctl.html) once as the server administrator:

```bash
sudo loginctl enable-linger <user>
loginctl show-user <user> --property=Linger
```

From a fresh project-user login, prepare and verify the user manager:

```bash
mkdir -p "$HOME/.config/systemd/user"
systemctl --user is-system-running
systemctl --user daemon-reload
```

Do not create a placeholder app unit here. App bootstrap creates the real project-specific unit after the app’s development command works.

## Server-Readiness Contract

Verify from the project user’s fresh login shell:

```bash
git --version
gh --version
gh auth status
rg --version
jq --version
curl --version
node --version
npm --version
npx --version
corepack --version
npm config get prefix
docker --version
docker compose version
docker info
psql --version
codex --version
```

The server is ready for app bootstrap when:

- the project user has a working home directory and SSH login;
- GitHub CLI is authenticated as the approved human account;
- Node, npm, npx, and Corepack resolve in a non-interactive shell;
- the npm global prefix is user-owned;
- Docker works without `sudo`, if the planned app needs it;
- Codex is installed and authenticated, if it will be used;
- user-level systemd and linger work, if the app will use a persistent user service.

Record any intentionally unavailable optional capability. Then continue with [typescript-app-bootstrap.md](https://github.com/Razva/public/blob/main/notes/llm/typescript/typescript-app-bootstrap.md); do not repeat machine provisioning inside the app workflow.
