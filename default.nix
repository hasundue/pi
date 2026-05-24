{ lib, ... }:
let
  store = dir: file: "${dir}/${file}";
  storeMany = dir: files: map (store dir) files;
  passMany = flag: args: [
    flag
    (lib.concatStringsSep "," args)
  ];
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
      storeMany ./system_prompts [
        "skill_relative_paths.md"
        "skill_commands.md"
        "ketch.md"
      ]
    );
  };
}
