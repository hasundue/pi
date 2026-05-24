When a skill references files with relative paths (e.g. `./scripts/tool.ts`),
resolve them against the skill's root directory (parent of the `location` path).
When the skill shows such a path as a command (e.g. in a code block), execute it
directly — assume it has an executable shebang. Do not prepend an interpreter
like `deno run`, `node`, or `python` unless the skill explicitly specifies one.
Prefer executing a script directly with its full path or the relative path from
your current working directory, rather than changing your working directory to
the skill's root.
