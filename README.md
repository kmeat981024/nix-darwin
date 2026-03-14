# nix-darwin

Declarative macOS setup for host `fenrir` using `nix-darwin`, `home-manager`,
`nix-homebrew`, and `sops-nix`.

## What This Repo Manages

- System-level macOS configuration (`modules/`)
- User-level tooling and shell/editor setup (`home/`)
- Declarative Homebrew taps/apps/casks
- Encrypted secrets via SOPS (`secrets/` + `.sops.yaml`)

## Prerequisites

- macOS on Apple Silicon (`aarch64-darwin`)
- Nix with flakes (`nix-command` + `flakes`)
- `just` (command runner)
- SOPS age key at:

```bash
~/.config/sops/age/keys.txt
```

## Repository Layout

- `flake.nix`: flake inputs/outputs and `darwinConfigurations`
- `Justfile`: daily commands (`darwin`, `darwin-debug`, `fmt`, `up`, `gc`, etc.)
- `modules/`: system modules (`nix-core.nix`, `system.nix`, `apps.nix`,
  `host-users.nix`)
- `home/`: Home Manager modules (shell, git, nvf, terminal, tools)
- `secrets/`: encrypted secret files (`poby.yaml`)

## Common Commands

```bash
# List available tasks
just

# Build and switch for a host
just darwin $(hostname)

# Build and switch with full trace
just darwin-debug $(hostname)

# Format Nix files (example: whole repo)
just fmt .

# Update all flake inputs
just up

# Update one input
just upp nixpkgs-darwin

# Inspect system profile history
just history

# Clean old generations / garbage collect
just clean
just gc
```

## Secrets

- Secrets are encrypted in `secrets/*.yaml`.
- `.sops.yaml` enforces age-based encryption rules.
- Home Manager reads secrets from `secrets/poby.yaml` and exposes:
  - `github_ssh_key`
  - `github_cli_token`

## Customization Notes

- Update `hostname`, `username`, and `useremail` in `flake.nix` for your
  machine.
- Add new system behavior in `modules/*.nix`.
- Add user tooling in `home/*.nix` and import it from `home/default.nix`.

## Troubleshooting

- Use `just darwin-debug <hostname>` for verbose evaluation/build output.
- If a build succeeds but behavior is stale, re-run switch and verify active
  host/config values.
