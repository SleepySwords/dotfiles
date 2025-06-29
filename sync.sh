#! /usr/bin/env fish

set dot_configs "borders" "nvim" "fish" "karabiner" "kitty" "sketchybar" "skhd" "yabai" "starship.toml" "zsh" "git" "zathura"
set home ".clangd"
set application_support_config "lazygit" "com.mitchellh.ghostty"
for config in $dot_configs
    rm -rf $config
    cp -r ~/.config/$config .
end
for config in $application_support_config
    rm -rf $config
    cp -r ~/Library/Application\ Support/$config .
end
for config in $home
    rm -rf $config
    cp -r ~/$config .
end
