# Development Server Setup

Use this reference when deliberately provisioning a self-managed development server or when project readiness identifies a missing machine- or user-level capability. It prepares reusable infrastructure; it does not create an application.

This is optional server guidance, not Step 0 or an application workflow, and it grants no authority to execute its commands. Apply the [Vibe-Coded Project Foundation](../1-vibe-coding-foundation.md), obtain the authority required for each machine or user mutation, and preserve the foundation's security, operational, verification, and completion requirements.

If File 2 routed here, return to its existing readiness or scaffold state after the selected capabilities pass. If setup happens before a project workflow, retain truthful readiness evidence for later discovery. Use [Development Server Operations](operations.md) for recurring inspection or maintenance.

## Select Capabilities First

Inventory the server, approved deployment shape, and expected project needs before installing anything. Classify every capability as `Required`, `Optional`, or `Not applicable`, with a short rationale.

| Capability | Typical trigger |
| --- | --- |
| Project user and SSH | A dedicated account or remote shell is required. |
| Core command-line tools | The selected workflow or verification commands require them. |
| GitHub CLI | The project uses GitHub through an approved human account. |
| Docker and Compose | The approved project uses containers on this server. |
| Node and user-owned npm tools | The approved project or development tooling requires Node. |
| PostgreSQL client | Operators must connect to an approved PostgreSQL instance. |
| Browser automation | The verification contract includes browser tests or screenshots. |
| Persistent user services | A development service must survive logout or reboot. |
| Codex | The owner chooses Codex as a development tool on this server. |

Do not install a broad fixed stack merely because this reference documents it. Verify current supported versions and installation instructions from each tool's official source before use.

## Lifecycle Boundary

This setup may own selected operating-system packages, project-user accounts and SSH access, shared runtimes, developer tooling, container access, or user-level service capability.

It does not own application repositories or dependencies; app ports or environment variables; Compose definitions; project-specific tool configuration; application service units; or ongoing operations. Those remain with the application bootstrap and project contracts.

Run privileged commands as the server administrator. Run user-scoped commands from the project user's normal login shell. Do not give the project user `sudo` merely so a development tool can complete setup.

## Project User

If the selected boundary requires a dedicated user and it does not already exist, create it as `root` or an approved sudoer:

```bash
useradd -m <user>
```

Optionally change its shell to `/bin/bash`:

```bash
chsh <user>
```

Keep each application checkout and its private environment owned by the user that runs it.

## SSH Access

Generate a client key if needed:

```bash
ssh-keygen -t ed25519 -C "your_name_or_email" -f ~/.ssh/key_name
cat ~/.ssh/key_name.pub
```

Never print or copy `~/.ssh/key_name`; that is the private key.

From the project user's server login, prepare the authorized-keys file:

```bash
mkdir -p ~/.ssh &&
touch ~/.ssh/authorized_keys &&
chmod 700 ~/.ssh &&
chmod 600 ~/.ssh/authorized_keys
```

Append only the approved public key, then test a fresh SSH login before continuing. An optional client entry can keep connection details explicit:

```text
Host some_hostname
  HostName some_ip
  Port some_port
  User some_user
  IdentityFile ~/.ssh/key_name
```

## Core Command-Line Tools

On a Debian-oriented server, install only the approved subset. A common core is:

```bash
sudo apt update
sudo apt install \
  git ripgrep jq curl ca-certificates openssl \
  procps lsof smem bsdextrautils \
  unzip zip tar rsync
```

Add `build-essential` and `python3` only when a selected runtime or dependency build requires them. Translate package names for the actual distribution instead of forcing Debian-specific packages.

## Optional GitHub CLI

Install GitHub CLI from its current official instructions, then authenticate as the project owner or approved human account from the project user's shell:

```bash
gh --version
gh auth login
gh auth status
```

Do not configure a placeholder, assistant, model, or automation Git identity. Project Git identity and repository creation belong to application bootstrap.

## Optional Docker And Compose

Install Docker from the official [Docker Engine installation guide](https://docs.docker.com/engine/install/). Prefer Docker's official package repository on supported systems.

If the project user will use the rootful Docker daemon without `sudo`, follow Docker's [Linux post-installation guidance](https://docs.docker.com/engine/install/linux-postinstall/):

```bash
sudo usermod -aG docker <user>
```

The user must start a new login session before the membership is reliably available. The `docker` group grants root-level privileges; decide deliberately whether that is acceptable. Use rootless mode when the boundary requires it.

Verify from a fresh project-user login:

```bash
id
docker version
docker compose version
docker run --rm hello-world
```

Do not use `sudo docker` from application workflows. Repair server access here instead of adding application permission workarounds.

## Optional Node Runtime

Select and verify a supported Node release for the approved project or tooling from the official [Node.js downloads](https://nodejs.org/en/download) page. One server-wide installation method is the standalone binary. As administrator, replace the placeholders with verified values:

```bash
NODE_VERSION="<version>"
NODE_MAJOR="<major>"
NODE_ARCH="x64"

sudo mkdir -p /opt/node &&
sudo tar -xJf "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" -C /opt/node &&
sudo mv "/opt/node/node-v${NODE_VERSION}-linux-${NODE_ARCH}" "/opt/node/node${NODE_MAJOR}-${NODE_VERSION}" &&
sudo ln -sfn "/opt/node/node${NODE_MAJOR}-${NODE_VERSION}" "/opt/node/node${NODE_MAJOR}" &&
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/node" /usr/local/bin/node &&
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/npm" /usr/local/bin/npm &&
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/npx" /usr/local/bin/npx &&
sudo ln -sfn "/opt/node/node${NODE_MAJOR}/bin/corepack" /usr/local/bin/corepack
```

Refresh all four symlinks when changing the selected version so non-interactive shells and persistent services use one runtime. Keep `/opt/node`, `/usr/local`, and the system prefix root-owned.

Configure a per-user npm global prefix from the project user's normal login shell, never through `sudo npm install -g`:

```bash
mkdir -p "$HOME/.local/share/npm" &&
npm config set prefix "$HOME/.local/share/npm" &&
npm config get prefix
```

Add its bin directory to the same user's login path:

```bash
grep -qxF 'export PATH="$HOME/.local/share/npm/bin:$PATH"' "$HOME/.profile" || \
  printf '\nexport PATH="$HOME/.local/share/npm/bin:$PATH"\n' >> "$HOME/.profile"
```

Start a fresh login shell, then verify:

```bash
command -v node
command -v npm
command -v npx
command -v corepack
npm config get prefix
```

Install global user tools only after the prefix resolves inside that user's home.

## Optional PostgreSQL Client

Install client utilities only when the project or approved operations require them:

```bash
sudo apt install postgresql-client
psql --version
```

This does not authorize a database connection or grant access to credentials or production data.

## Optional Browser Automation

Install the browser framework through the application at its verified project version when browser automation is part of the approved verification contract. For a Node project using Playwright:

```bash
npm install --save-dev --save-exact @playwright/test@<verified-version>
npx playwright install chromium
npx playwright --version
```

If Chromium reports missing Linux libraries, an approved administrator may install the dependencies supported by that project version:

```bash
sudo npx playwright install-deps chromium
```

Retry the browser installation as the project user. Do not preinstall browser tooling when the project does not need it.

## Optional Persistent User Services

A real application service cannot be defined until the application path, command, port, and environment exist. This setup can only make persistent user services possible.

If a project user's services must survive logout or reboot, an approved administrator may enable user lingering:

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

Do not create a placeholder application unit here. Application bootstrap creates a real project-specific unit only after its development command and configuration work interactively.

## Optional Codex

When the owner selects Codex and Node/npm user tooling is available, install it as the project user:

```bash
npm install -g @openai/codex
command -v codex
codex --version
```

Run `codex` once for authentication and initial user-level file creation. Keep user-wide defaults in `~/.codex/config.toml` and project-specific settings in a trusted application's `.codex/config.toml`. Prefer current official [Codex configuration documentation](https://learn.chatgpt.com/docs/config-file/config-basic) over copied model names or stale sample values.

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

Choose approval and sandbox settings deliberately for the server's trust boundary. Use the broader profile only when the owner explicitly accepts it, and do not grant the Unix user `sudo` to compensate for broader tool permissions.

Use `/plugins` in Codex CLI or the current plugin settings interface to browse and enable approved plugins. Do not copy plugin-enable configuration from an older setup. Installing a security plugin or scanner does not authorize running a scan.

## Readiness Evidence

Verify only the selected capabilities from a fresh project-user login. A useful evidence record includes:

- project user and SSH result, when selected;
- tool paths and versions for required commands;
- authenticated GitHub human identity, when selected;
- user-owned npm prefix and non-interactive Node resolution, when selected;
- Docker and Compose operation without `sudo`, when selected;
- database-client version, when selected;
- browser install and smallest approved smoke check, when selected;
- user manager and linger state, when selected; and
- Codex path, version, and authentication readiness, when selected.

Record intentionally unavailable optional capabilities instead of treating them as failures. Then begin or resume the [Vibe-Coded Project Bootstrap](../2-vibe-coding-bootstrap.md) at its existing stage; do not repeat server provisioning inside the application lifecycle.
