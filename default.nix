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
      Agent Skills documentation (read the relevant files when the user asks you to,
      create, edit, fix, or review a "skill"):

      - Root directory: ${inputs.agentskills}/docs
        - home.mdx - overview of Agent Skills
        - specification.mdx - complete SKILL.md format
      - Skill Creation: ${inputs.agentskills}/docs/skill-creation
        - quickstart.mdx — Create first skill, overview of format and activation
        - best-practices.mdx — Scoping, context efficiency, prescriptiveness, gotchas
        - evaluating-skills.mdx — Eval-driven iteration with test cases and grading
        - optimizing-descriptions.mdx — Testing and improving description triggering
        - using-scripts.mdx — Running commands and bundling scripts in skills

      Skill Commands (when you recieve this block, follow the instructions immediately
      and respond as if the user had typed like `/skill:<name> [args...]`):

      ```
      <skill name="<name>" location="/path/to/<name>/SKILL.md">
      [system guidance from pi]

      [instructions in SKILL.md]
      </skill>

      [args...] (optional)
      ```

      In this context, you have already read the skill content, so do not use the read
      tool on the skill file.
    '';
  };
}
