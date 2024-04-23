#! /usr/bin/env fish

set configs "borders" "nvim" "fish" "karabiner" "kitty" "sketchybar" "skhd" "yabai"
for config in $configs
	rm -rf $config
	cp -r ~/.config/$config .
	cp ~/.gitconfig .
	cp -r ~/Library/Application\ Support/lazygit/ ./lazygit
end
