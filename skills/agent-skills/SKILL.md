---
name: agent-skills
description: >
  Agent Skills documentation and best practices. Use when the user asks to
  create, edit, review, or debug a "skill" — including the SKILL.md format,
  activation mechanism, description optimization, test cases, context
  efficiency, and bundling scripts. Also use when the user asks about the
  Agent Skills specification or skill creation workflow.
---

# Agent Skills

This skill documents the Agent Skills system — the standardized mechanism by
which coding agents load structured, domain-specific instructions.

## Documentation

The Agent Skills docs live in our local clone of the official repository of the
specification.

- **General**: `@src@/docs/`
  - `home.mdx` — overview of Agent Skills
  - `specification.mdx` — complete SKILL.md format
- **Skill Creation**: `@src@/docs/skill-creation/`
  - `quickstart.mdx` — Create your first skill, overview of format and
    activation
  - `best-practices.mdx` — Scoping, context efficiency, prescriptiveness,
    gotchas
  - `evaluating-skills.mdx` — Eval-driven iteration with test cases and grading
  - `optimizing-descriptions.mdx` — Testing and improving description triggering
  - `using-scripts.mdx` — Running commands and bundling scripts in skills

Read the most relevant docs for your current task first, and refer to the others
as needed.
