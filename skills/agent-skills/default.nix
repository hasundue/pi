{
  pkgs,
  inputs,
  ...
}:
{
  pi.coding-agent = {
    skills = [
      (pkgs.linkFarm "agent-skills" [
        {
          name = "SKILL.md";
          path = pkgs.replaceVars ./SKILL.md {
            src = inputs.agentskills;
          };
        }
      ])
    ];
  };
}
