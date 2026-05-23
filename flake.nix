{
  description = "A Nix flake for a hasundue's pi setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pi-nix = {
      url = "github:lukasl-dev/pi.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [ "https://pi.cachix.org" ];
    extra-trusted-public-keys = [
      "pi.cachix.org-1:lGeoGJaZ5ZDabuRzkcD5EBTNnDM4HJ1vqeOxlWk1Flk="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      git-hooks-nix,
      treefmt-nix,
      pi-nix,
    }:
    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      packages = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
        }
      );
      forEachSystem = f: lib.genAttrs systems (s: f packages.${s});
      forAllSystems = f: lib.genAttrs systems (system: f system packages.${system});
    in
    {
      apps = forAllSystems (
        system: pkgs:
        let
          my-pi = pi-nix.lib.mkCodingAgent {
            inherit pkgs;
            modules = [
              {
                pi.coding-agent = {
                  extraArgs = [
                    "--no-extensions"
                    "--no-skills"
                  ];
                  extensions = [
                    ./extensions/footer.ts
                    ./extensions/messages.ts
                    ./extensions/temperature.ts
                  ];
                };
              }
            ];
          };
        in
        {
          default = {
            type = "app";
            program = "${my-pi.package}/bin/pi";
          };
        }
      );
      devShells = forEachSystem (
        pkgs:
        let
          inherit (pkgs.stdenv.hostPlatform) system;
          treefmt = treefmt-nix.lib.mkWrapper pkgs {
            programs.nixfmt = {
              enable = true;
            };
          };
          git-hooks = git-hooks-nix.lib.${system}.run {
            src = ./.;
            hooks = {
              treefmt = {
                enable = true;
                package = treefmt;
              };
            };
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nil
              treefmt
            ];
            shellHook = git-hooks.shellHook;
          };
        }
      );
    };
}
