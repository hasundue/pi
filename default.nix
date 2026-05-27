{
  pkgs,
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
  imports = [
    ./skills/agent-skills
  ];

  pi.coding-agent = {
    extensions = storeMany ./extensions [
      "footer.ts"
      "temperature.ts"
    ];
    promptTemplates = storeMany ./prompts [
      "polish.md"
    ];
    skills = [
      ./skills/ketch
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
    ]
    ++ repeat "--append-system-prompt" (
      storeMany ./context [
        "skill_commands.md"
      ]
    );
  };
}
