{ lib, ... }:
{
  pi.coding-agent = {
    extensions = [
      # ../extensions
      ./extensions/footer.ts
      # ../extensions/messages.ts
      ./extensions/temperature.ts
    ];
    # skills = [
    #   ./skills/exa-search
    # ];
    extraArgs =
      # Discover NOTHING from ~/.pi/agent
      [
        "--no-extensions"
        "--no-skills"
        "--no-themes"
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
