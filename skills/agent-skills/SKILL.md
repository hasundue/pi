---
name: agent-skills
description: >
  Agent Skills documentation and best practices. Use when the user asks to
  create, edit, review, or debug a "skill" — including the SKILL.md format,
  activation mechanism, description optimization, test cases, context
  efficiency, and bundling scripts. Also use when the user asks about the
  agentskills specification or skill creation workflow.
---

# Agent Skills

This skill documents the Agent Skills system — the mechanism by which the pi
coding agent loads structured, domain-specific instructions.

## Documentation

The Agent Skills docs live in the `agentskills` flake input
(`github:agentskills/agentskills`). To find the resolved store path:

1. Read `flake.nix` — locates the input URL.
2. Read `flake.lock` — gives the exact `narHash` and path.
3. Or grep for the store path: `ls /nix/store/*-source/docs/`

Then read the following files under **`<store-path>/docs/`**:

- **Root**: `<store-path>/docs/`
  - `home.mdx` — overview of Agent Skills
  - `specification.mdx` — complete SKILL.md format
- **Skill Creation**: `<store-path>/docs/skill-creation/`
  - `quickstart.mdx` — Create first skill, overview of format and activation
  - `best-practices.mdx` — Scoping, context efficiency, prescriptiveness,
    gotchas
  - `evaluating-skills.mdx` — Eval-driven iteration with test cases and grading
  - `optimizing-descriptions.mdx` — Testing and improving description triggering
  - `using-scripts.mdx` — Running commands and bundling scripts in skills

Read them via the `read` tool.

## Key Concepts

### Structure

A skill is a directory containing at minimum a `SKILL.md` file. Optional
`scripts/` directory for helper executables. Skills are registered in the
`skills` list in `default.nix`.

### Activation

Skills activate when the user's request matches their `description` field
(frontmatter). Description matching is semantic — be prescriptive about when the
skill should and should not activate.

### Context Efficiency

Skills are loaded only when their description matches the current request. This
keeps the context window lean. Avoid including instructions that are always
needed — those belong in `rules` (see the Skill Commands protocol in
`default.nix`).

### Prescriptiveness

Be specific about tools, commands, and workflows. Agent Skills work best when
they leave little ambiguity — include exact commands, flag names, and expected
output formats.

### Evaluation

Skills can be tested with inline test cases in the SKILL.md frontmatter or
separate eval files. Grading rubrics help iterate on description triggering and
instruction quality.
