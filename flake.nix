{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      setPath = ''
          export DOTFILES_RELATIVE_PATH="''${DOTFILES_RELATIVE_PATH:-stuff/dev/dotfiles}/$SUB_DIR"
          export XDG_CONFIG_HOME="$HOME/$DOTFILES_RELATIVE_PATH"
          export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
      '';
      packages = [ pkgs.neovim pkgs.fish pkgs.zsh pkgs.ripgrep pkgs.starship ];
    in
    {
      devShells.aarch64-darwin.default = pkgs.mkShell {
        packages = packages;
        shellHook = setPath;
      };
      devShells.aarch64-darwin.minimal = pkgs.mkShell {
        packages = packages;
        shellHook = ''
          export SUB_DIR=minimal
          export NVIM_APPNAME=nvim_minimal
        '' + setPath;
      };
    };
}
