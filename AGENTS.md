# Repository Guidelines

## Project Structure & Module Organization

This repository is a declarative macOS setup built with Nix flakes, `flake-parts`,
and a dendritic aspect layout.

- `flake.nix` and `flake.lock`: flake entrypoint and pinned inputs.
- `modules/flake/`: flake assembly, repo options, shared context modules, and
  `darwinConfigurations` generation.
- `modules/aspects/`: public aspect entry modules auto-discovered with
  `import-tree`. Each aspect may expose `flake.modules.darwin.<feature>` and/or
  `repo.homeModules.<feature>`.
- `modules/aspects/_*/`: private implementation trees intentionally excluded
  from `import-tree`. Import these manually from the owning aspect to keep each
  feature plug-and-play and in control of its own composition surface.
- `hosts/`: auto-discovered host declarations that register
  `repo.hosts.<hostname>.system` and a flat `features` list.
- `secrets/` and `.sops.yaml`: encrypted SOPS files and path rules.
- `Justfile`: day-to-day contributor commands.

Prefer adding a new focused aspect in `modules/aspects/` and keeping host files
thin. Put reusable internals under a sibling `_/` tree and wire them in
explicitly from the public aspect entry module.

## Build, Test, and Development Commands

Use `just` as the primary interface:

- `just darwin <hostname>`: build and switch to the current host (ex: `fenrir`).
- `just darwin-debug <hostname>`: same as above with verbose trace output.
- `just fmt .`: format Nix files from the repository root via `nix fmt`
  (Alejandra).
- `just up`: update all flake inputs.
- `just upp <input>`: update one input (example: `just upp nixpkgs`).
- `just history`, `just clean`, `just gc`: inspect and prune Nix
  generations/store.

For validation without switching, run:
`nix build .#darwinConfigurations.fenrir.system --extra-experimental-features 'nix-command flakes'`.

For dependency-graph validation without realizing a full build, run:
`nix build .#darwinConfigurations.fenrir.system --dry-run --extra-experimental-features 'nix-command flakes'`.

## Coding Style & Naming Conventions

- Use 2-space indentation in `.nix` files and keep attribute sets readable.
- Run `just fmt .` before committing; formatter is defined in `flake.nix`
  (`alejandra`).
- Name aspect and helper files in lowercase kebab-case.
- Keep public aspect filenames aligned with the feature names referenced from
  `repo.hosts.<hostname>.features`.
- Keep host files declarative and small: they should select features, not carry
  large implementation blocks.
- Use `imports` inside private `_*/` trees to compose internals, but expose the
  aspect itself through one public entry module in `modules/aspects/`.

## Testing Guidelines

There is no dedicated unit-test suite in this repo. Treat evaluation/build as
the test gate:

- Run `just fmt .`.
- Run `nix build .#darwinConfigurations.fenrir.system`.
- Use `nix build .#darwinConfigurations.fenrir.system --dry-run` for a quick
  validation pass when you only need evaluation and dependency resolution.
- Use `just darwin-debug <hostname>` when diagnosing evaluation/runtime issues.

Document manual verification for user-facing changes (shell, terminal, window
manager, app defaults, Homebrew behavior).

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
- `.sops.yaml` currently matches `secrets/.*\.yaml$`; keep new secret files
  within that pattern or update the rule before committing.
- If adding new secret-backed modules, continue reading from encrypted files via
  the `secrets` aspect rather than hardcoding credentials into aspect modules.
