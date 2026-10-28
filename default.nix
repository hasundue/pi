{
  lib,
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
in
{
  imports = [
    ./skills/agent-skills
  ];

  pi.coding-agent = {
    extensions = storeMany ./extensions [
      # "footer.ts"
      "temperature.ts"
    ];
    promptTemplates = storeMany ./prompts [
      "polish.md"
    ];
    skills = [
      ./skills/ketch
    ];
    themes = [
      ./themes/kanagawa-wave.json
    ];
    rules = ./context/rules.md;
    extraArgs = [
      # Disable resource discovery from ~/.pi/agent and built-in extensions
      "--no-extensions"
      "--no-prompt-templates"
      "--no-skills"
      "--no-themes"

      "--use-theme"
      "kanagawa-wave"

      "--provider"
      "opencode-go"
      "--model"
      "deepseek-v4.1-flash:high"
    ]
    ++ passMany "--models" [
      "opencode-go/deepseek-v4.1-flash"
      "opencode-go/hy3"
      "opencode-go/minimax-m3"
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
  };
}
