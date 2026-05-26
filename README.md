# nix-darwin

[한국어](README-ko.md)

Declarative macOS setup with `nix-darwin`, `home-manager`, `nix-homebrew`, and
`sops-nix`.

## What This Repo Manages

- Flake orchestration and host assembly in `modules/flake/`
- Auto-discovered Darwin and Home Manager aspects in `modules/aspects/`
- Auto-discovered host declarations in `hosts/`
- Encrypted secrets via SOPS (`secrets/` + `.sops.yaml`)

## Prerequisites

- macOS on Apple Silicon (`aarch64-darwin`)
- Nix with flakes enabled (`nix-command` + `flakes`)
- `just` (command runner)
- SOPS age key at:

```bash
$HOME/.config/sops/age/keys.txt
```

## Repository Layout

- `flake.nix`: `flake-parts` entrypoint and flake inputs
- `Justfile`: day-to-day commands (`dry-run`, `darwin`, `darwin-debug`,
  `fmt`, `up`, `repl`, `gc`, `gcroot`)
- `modules/flake/`: repo options, Darwin assembly, and shared context modules
- `modules/aspects/`: auto-discovered aspect entry modules such as `base`,
  `homebrew`, `shell`, `editor`, and `desktop`
- `modules/aspects/_*/`: ignored internal implementation trees that back the
  public aspect entry modules
- `hosts/`: auto-discovered host declarations that register `system` and a flat
  `features` list
- `secrets/`: encrypted secret files (`poby.yaml`)

## Common Commands

```bash
# List available tasks
just

# Build and switch for current machine hostname
just darwin $(hostname)

# Build and switch with trace/verbose logs
just darwin-debug $(hostname)

# Validate dependency graph without realizing a full build
just dry-run fenrir

# Format Nix files (from repository root)
just fmt .

# Update all flake inputs
just up

# Update one flake input
just upp nixpkgs

# Validate build without switching (example host: fenrir)
nix build .#darwinConfigurations.fenrir.system --extra-experimental-features 'nix-command flakes'

# Equivalent raw Nix dry-run validation
nix build .#darwinConfigurations.fenrir.system --dry-run --extra-experimental-features 'nix-command flakes'

# Inspect profile history / cleanup old generations
just history
just clean
just gc
```

## Configuration Notes

- `flake.nix` uses `flake-parts`, keeps `./modules/flake` explicit, and
  auto-discovers `./modules/aspects` and `./hosts` through `import-tree`.
- `hosts/fenrir.nix` is the current host declaration and maps `fenrir` to one
  flat feature list.
- `modules/flake/darwin-configurations.nix` assembles each host’s
  `darwinConfigurations.<host>` output and embeds Home Manager for user `poby`.
- `modules/aspects/` is the feature vocabulary for hosts. The current feature
  set is `base`, `nix-core`, `system-packages`, `homebrew`, `macos-defaults`,
  `activation`, `fonts`, `sudo-auth`, `shell`, `cli-tools`, `git`, `ssh`,
  `secrets`, `terminal`, `editor`, `desktop`, and `fenrir`.
- The `cli-tools` aspect owns the CLI user tool set, including `zoxide`.
- `modules/aspects/_*/` contains implementation files that are intentionally not
  auto-loaded. `import-tree` skips paths containing `/_`, which is the repo’s
  convention for internal helpers and subtrees like the NVF source.
- Home Manager is integrated through nix-darwin; no standalone
  `homeConfigurations` output is exposed.

## Adding A Host

- Create `hosts/<hostname>.nix`.
- Register `repo.hosts.<hostname>.system`.
- Register `repo.hosts.<hostname>.features` with the desired aspect names.
- Add any host-specific behavior as a new aspect in `modules/aspects/` instead
  of modifying shared features.

## Secrets

- Keep secrets encrypted in `secrets/*.yaml`.
- `.sops.yaml` enforces encryption rules for `secrets/.*\.yaml`.
- Home Manager reads from `secrets/poby.yaml` via the `secrets` aspect:
  - `github_ssh_key`
  - `github_cli_token`
  - `kmeat_mac_mini_ssh_key`

## Troubleshooting

- Use `just darwin-debug <hostname>` for detailed evaluation/build output.
- If evaluation fails for a host, verify it exists under `darwinConfigurations`.
- Dry-run evaluation with
  `nix build .#darwinConfigurations.<host>.system --dry-run` before a full
  switch when you only want to confirm the dependency graph.
- If settings look stale after a successful build, run switch again and verify
  active hostname/config values.
