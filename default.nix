{ pkgs, lib, ... }:
{
  pi.coding-agent = {
    extensions = [
      ./extensions/footer.ts
      ./extensions/temperature.ts
    ];
    extraArgs = [
      "--provider"
      "opencode-go"
      "--model"
      "deepseek-v4-flash:high"
    ]
    ++ [
      "--models"
      (lib.concatStringsSep "," [
        "deepseek-v4-flash"
        "deepseek-v4-pro"
        "minimax-m2.7"
        "kimi-k2.6"
      ])
    ]
    # Disable resource discovery from ~/.pi/agent
    ++ [
      "--no-extensions"
      "--no-prompt-templates"
      "--no-skills"
      "--no-themes"
    ]
    ++ [
      "--theme"
      "${./themes/kanagawa-wave.json}"
    ]
    # Enable all built-in tools
    ++ [
      "--tools"
      (lib.concatStringsSep "," [
        "read"
        "bash"
        "edit"
        "write"
        "grep"
        "find"
        "ls"
      ])
    ]
    ++ [
      "--append-system-prompt"
      "${./prompts/skill_relative_paths.md}"
    ]
    ++ [
      "--append-system-prompt"
      "${./prompts/skill_commands.md}"
    ]
    ++ [
      "--append-system-prompt"
      "${./prompts/ketch.md}"
    ];
  };
}
