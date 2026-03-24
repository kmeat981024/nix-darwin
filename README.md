# nix-darwin

[한국어](README-ko.md)

Declarative macOS setup with `nix-darwin`, `home-manager`, `nix-homebrew`, and
`sops-nix`.

## What This Repo Manages

- System-level macOS configuration in `hosts/`
- User-level tooling, shell, terminal, and editor config in `home/`
- Declarative Homebrew taps/apps/casks in `hosts/apps.nix`
- Encrypted secrets via SOPS (`secrets/` + `.sops.yaml`)

## Prerequisites

- macOS on Apple Silicon (`aarch64-darwin`)
- Nix with flakes enabled (`nix-command` + `flakes`)
- `just` (command runner)
- SOPS age key at:

```bash
~/.config/sops/age/keys.txt
```

## Repository Layout

- `flake.nix`: flake inputs/outputs and `darwinConfigurations`
- `Justfile`: day-to-day commands (`darwin`, `darwin-debug`, `fmt`, `up`, `gc`)
- `hosts/`: system modules
  - `default.nix`
  - `nix-core.nix`
  - `system.nix`
  - `apps.nix`
  - `host-users.nix`
- `home/`: Home Manager modules (`git.nix`, `zsh.nix`, `nvf/`, `aerospace.nix`,
  etc.)
- `secrets/`: encrypted secret files (`poby.yaml`)

## Common Commands

```bash
# List available tasks
just

# Build and switch for current machine hostname
just darwin $(hostname)

# Build and switch with trace/verbose logs
just darwin-debug $(hostname)

# Format Nix files (from repository root)
just fmt .

# Update all flake inputs
just up

# Update one flake input
just upp nixpkgs-darwin

# Validate build without switching (example host: fenrir)
nix build .#darwinConfigurations.fenrir.system --extra-experimental-features 'nix-command flakes'

# Inspect profile history / cleanup old generations
just history
just clean
just gc
```

## Configuration Notes

- `flake.nix` currently defines one `darwinConfigurations` entry from
  `hostname`, and imports system modules through `./hosts`.
- `home/default.nix` composes user modules (shell, git, nvf, aerospace, sops,
  ssh).
- Aerospace multi-monitor workspace assignment lives in `home/aerospace.nix`.
- Homebrew-first app management (for frequently updated apps) is in
  `hosts/apps.nix`.

## Secrets

- Keep secrets encrypted in `secrets/*.yaml`.
- `.sops.yaml` enforces encryption rules for `secrets/.*\.yaml`.
- Home Manager reads from `secrets/poby.yaml` via `home/sops.nix`:
  - `github_ssh_key`
  - `github_cli_token`

## Troubleshooting

- Use `just darwin-debug <hostname>` for detailed evaluation/build output.
- If evaluation fails for a host, verify it exists under `darwinConfigurations`.
- If settings look stale after a successful build, run switch again and verify
  active hostname/config values.

## Milestone

- [ ] `multi-host implementation`
- [ ] Dentritic Pattern - using flake-parts
