{
  lib,
  inputs,
  ...
}:
let
  # Always concat a store path of directory and a file name,
  # so that pi can use the clean file name as the skill name or extension name.
  store = dir: file: "${dir}/${file}";
  storeMany = dir: files: map (store dir) files;
  passMany = flag: args: [
    flag
    (lib.concatStringsSep "," args)
  ];
  # Helper function to repeat a flag for multiple files, e.g. --extension file1 --extension file2
  repeat =
    flag: files:
    lib.concatMap (f: [
      flag
      f
    ]) files;
in
{
  pi.coding-agent = {
    extensions = storeMany ./extensions [
      "footer.ts"
      "temperature.ts"
    ];
    promptTemplates = storeMany ./prompts [
      "polish.md"
    ];
    skills = storeMany ./skills [
      "ketch"
    ];
    extraArgs = [
      # Disable resource discovery from ~/.pi/agent
      "--no-extensions"
      "--no-prompt-templates"
      "--no-skills"
      "--no-themes"

      "--theme"
      (store ./themes "kanagawa-wave.json")

      "--provider"
      "opencode-go"
      "--model"
      "deepseek-v4-flash:high"
    ]
    ++ passMany "--models" [
      "deepseek-v4-flash"
      "deepseek-v4-pro"
      "minimax-m2.7"
      "kimi-k2.6"
    ]
    # Enable all built-in tools
    ++ passMany "--tools" [
      "read"
      "bash"
      "edit"
      "write"
      "grep"
      "find"
      "ls"
    ];
    rules = ''
      Agent Skills documentation — when creating, modifying, or reviewing an
      agent skill (SKILL.md and its bundled resources), read the relevant files
      under ${inputs.agentskills}/docs/skill-creation/:

      - quickstart.mdx — Create first skill, overview of format and activation
      - best-practices.mdx — Scoping, context efficiency, prescriptiveness, gotchas
      - evaluating-skills.mdx — Eval-driven iteration with test cases and grading
      - optimizing-descriptions.mdx — Testing and improving description triggering
      - using-scripts.mdx — Running commands and bundling scripts in skills

      For complete SKILL.md format, read ${inputs.agentskills}/docs/specification.mdx.

      Skill Commands - when the user types /skill:<name> [args...], pi expands it
      into an XML block:

      ```
      <skill name="<name>" location="/path/to/<name>/SKILL.md">
      [system guidance from pi]

      [instructions in SKILL.md]
      </skill>

      [args...] (optional)
      ```

      When you see this block, follow the instructions immediately and respond as if
      the user had typed `/skill:<name> [args...]`. You have already read the skill
      content, so do not use the read tool on the skill file in this case.
    '';
  };
}
