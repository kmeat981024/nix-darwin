# nix-darwin

[한국어](README-ko.md)

Declarative macOS setup with `nix-darwin`, `home-manager`, `nix-homebrew`, and
`sops-nix`. The flake assembles one or more macOS hosts from small aspect
modules, with Home Manager embedded through nix-darwin.

## What this repo manages

- Flake orchestration and host assembly in `modules/flake/`
- Auto-discovered Darwin and Home Manager aspects in `modules/aspects/`
- Auto-discovered host declarations in `hosts/`
- Encrypted secrets via SOPS (`secrets/` + `.sops.yaml`)
- Editor, browser, terminal, shell, desktop, SSH, and CLI tooling for user
  `poby`

## Prerequisites

- macOS on Apple Silicon (`aarch64-darwin`)
- Nix with flakes enabled (`nix-command` + `flakes`)
- `just` (command runner)
- SOPS age key at:

```bash
$HOME/.config/sops/age/keys.txt
```

## Repository layout

- `flake.nix`: `flake-parts` entrypoint and flake inputs
- `Justfile`: day-to-day commands (`dry-run`, `darwin`, `darwin-debug`, `fmt`,
  `up`, `upp`, `repl`, `history`, `clean`, `gc`, `gcroot`)
- `modules/flake/`: repo options, Darwin assembly, and shared context modules
- `modules/aspects/`: auto-discovered aspect entry modules such as `base`,
  `homebrew`, `shell`, `browser`, `discord`, `editor`, and `desktop`
- `modules/aspects/_*/`: ignored internal implementation trees that back the
  public aspect entry modules
- `modules/aspects/_hammerspoon/`: Hammerspoon configuration linked to
  `$HOME/.hammerspoon`
- `modules/aspects/_editor/`: NVF and Zed editor configuration
- `modules/aspects/_browser/`: Zen Browser policies, profile settings,
  extensions, containers, spaces, and pinned tabs
- `modules/aspects/_secrets/`: `sops-nix` declarations and Home Manager session
  variables
- `hosts/`: auto-discovered host declarations that register `system` and a flat
  `features` list
- `secrets/`: encrypted secret files (`poby.yaml`)

## Common commands

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

# Inspect profile history / clean old generations / collect unused store paths
just history
just clean
just gc
```

## Configuration notes

- `flake.nix` uses `flake-parts`, keeps `./modules/flake` explicit, and
  auto-discovers `./modules/aspects` and `./hosts` through `import-tree`.
- `hosts/fenrir.nix` is the current host declaration and maps `fenrir` to one
  flat feature list.
- `modules/flake/darwin-configurations.nix` assembles each host's
  `darwinConfigurations.<host>` output and embeds Home Manager for user `poby`.
- `modules/aspects/` is the feature vocabulary for hosts. The current feature
  set is `base`, `nix-core`, `system-packages`, `homebrew`, `macos-defaults`,
  `activation`, `fonts`, `sudo-auth`, `shell`, `cli-tools`, `git`, `ssh`,
  `secrets`, `terminal`, `hammerspoon`, `editor`, `browser`, `discord`,
  `desktop`, and `fenrir`.
- The `cli-tools` aspect owns the CLI user tool set, including `zoxide`.
- The `editor` aspect imports both NVF and Zed. Zed is configured through Home
  Manager with mutable user settings and keymaps enabled, the `nix` extension,
  `nixd` as the active Nix language server, and Alejandra as the Nix formatter.
- The `browser` aspect manages Zen Browser through Home Manager, including
  browser policies and the profile modules under `modules/aspects/_browser/`.
- The Hammerspoon app is installed through the `homebrew` cask list, while the
  `hammerspoon` aspect links `modules/aspects/_hammerspoon/` to
  `$HOME/.hammerspoon` with Home Manager.
- `modules/aspects/_*/` contains implementation files that are intentionally not
  auto-loaded. `import-tree` skips paths containing `/_`, which is the repo's
  convention for internal helpers and subtrees like the NVF source.
- Home Manager is integrated through nix-darwin; no standalone
  `homeConfigurations` output is exposed.

## Adding a host

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
