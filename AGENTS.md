# Repository Guidelines

## Project Structure & Module Organization

This repository is a declarative macOS setup built with Nix flakes.

- `flake.nix` and `flake.lock`: entrypoint and pinned inputs.
- `modules/`: system-level nix-darwin modules (`nix-core.nix`, `system.nix`,
  `apps.nix`, `host-users.nix`).
- `home/`: Home Manager user configuration, with feature modules such as
  `git.nix`, `zsh.nix`, and `nvf/`.
- `secrets/`: encrypted SOPS files (for example `secrets/poby.yaml`).
- `Justfile`: day-to-day contributor commands.

Prefer adding new configuration as small focused modules, then importing them
from `home/default.nix` or `flake.nix`.

## Build, Test, and Development Commands

Use `just` as the primary interface:

- `just darwin <hostname>`: build and switch to the current host (ex: `fenrir`).
- `just darwin-debug <hostname>`: same as above with verbose trace output.
- `just fmt`: format all Nix files via `nix fmt` (Alejandra).
- `just up`: update all flake inputs.
- `just upp <input>`: update one input (example: `just upp nixpkgs-darwin`).
- `just history`, `just gc`, `just clean`: inspect and prune Nix
  generations/store.

For validation without switching, run:
`nix build .#darwinConfigurations.fenrir.system --extra-experimental-features 'nix-command flakes'`.

## Coding Style & Naming Conventions

- Use 2-space indentation in `.nix` files and keep attribute sets readable.
- Run `just fmt` before committing; formatter is defined in `flake.nix`
  (`alejandra`).
- Name module files in lowercase kebab-case (example: `host-users.nix`).
- Keep modules single-purpose and compose through `imports`.

## Testing Guidelines

There is no dedicated unit-test suite in this repo. Treat evaluation/build as
the test gate:

- Run `just fmt`.
- Run `nix build .#darwinConfigurations.fenrir.system`.
- Use `just darwin-debug` when diagnosing evaluation/runtime issues.

Document manual verification for user-facing changes (shell, terminal, window
manager, app defaults).

## Commit & Pull Request Guidelines

Commit history follows Conventional Commit style: `feat:`, `fix:`, `refactor:`,
`style:`.

- Keep subject lines imperative and concise.
- Scope each commit to one logical change.
- In PRs, include: summary, affected modules/paths, command output used for
  validation, and any relevant screenshots for UI changes (for example
  WezTerm/AeroSpace behavior).

## Security & Configuration Tips

- Never commit plaintext secrets.
- Store secrets only in `secrets/*.yaml` and manage keys/rules in `.sops.yaml`.
- If adding new secret files, ensure `path_regex` coverage and encrypted content
  before pushing.
