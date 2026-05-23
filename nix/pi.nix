{
  pi.coding-agent = {
    extraArgs =
      # Disable all extensions and skills from ~/.pi/agent
      [
        "--no-extensions"
        "--no-skills"
        "--no-themes"
      ];
    extensions = [
      # ../extensions
      ../extensions/footer.ts
      # ../extensions/messages.ts
      ../extensions/temperature.ts
    ];
    skills = [
      ../skills/exa-search
    ];
  };
}
