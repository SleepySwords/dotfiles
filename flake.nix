{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      setPath = ''
          export DOTFILES_RELATIVE_PATH="''${DOTFILES_RELATIVE_PATH:-stuff/dev/dotfiles}"
          export XDG_CONFIG_HOME="$HOME/$DOTFILES_RELATIVE_PATH"
      '';
      packages = [ pkgs.neovim pkgs.fish pkgs.zsh pkgs.ripgrep ];
    in
    {
      devShells.aarch64-darwin.default = pkgs.mkShell {
        packages = packages;
        shellHook = setPath;
      };
      devShells.aarch64-darwin.minimal = pkgs.mkShell {
        packages = packages;
        shellHook = setPath + ''
          export NVIM_APPNAME=nvim_minimal
        '';
      };
    };
}
