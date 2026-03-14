---
name: readme
description: Write and update README.md and README-ko.md for the nix-darwin repository. Use when asked to create new repository documentation, refresh outdated setup/usage instructions, summarize the current project structure, or produce Korean README content.
---

# README Writer

## Overview

Generate high-quality README files for this repository based on current code and
configuration. Create missing READMEs or update existing ones while preserving
useful, project-specific content.

## Workflow

1. Inspect repository facts before writing. Use targeted reads of `flake.nix`,
   `Justfile`, `home/`, `modules/`, and `secrets/` plus recent git history. Do
   not invent commands, tools, or directory names.

2. Select target file and language. Default target is `README.md` in English. If
   user asks for Korean or explicitly requests `README-ko.md`, write Korean
   content to `README-ko.md`. If target is ambiguous, ask one concise
   clarification question.

3. Draft content before mutating files. Always show a draft summary (or full
   draft when requested) and request explicit confirmation before writing. Use
   concise, actionable prose and include concrete commands that work in this
   repository.

4. Create or update safely. If the target README does not exist, create it. If
   it exists, retain useful custom sections and update stale technical details.
   Avoid deleting user-authored content unless it is clearly obsolete and
   replaced by accurate content.

5. Validate the result. Re-check that all commands and paths referenced in the
   README exist in the repository. Ensure headings are clear, markdown is valid,
   and tone is professional.

## Recommended README Structure

- Title and short description
- Prerequisites (Nix/macOS assumptions when relevant)
- Repository layout (`home/`, `modules/`, `secrets/`, root files)
- Key commands (`just darwin`, `just darwin-debug`, `just fmt`, update/cleanup
  commands)
- Configuration and secrets notes (`.sops.yaml`, `secrets/*.yaml`)
- Common workflows (apply config, update flake inputs, debug build issues)

Adapt section names if user requests a different format, but keep the content
repository-specific.

## Output Rules

- Prefer concise explanations over long tutorials.
- Keep examples runnable from repository root.
- Use Markdown headings and fenced code blocks for commands.
- Do not include placeholders like "TODO" in final README output.
- For bilingual requests, keep language consistent per file (no mixed-language
  sections unless requested).

## Confirmation Requirement

Never write or overwrite `README.md` or `README-ko.md` without explicit user
confirmation in the current conversation.
