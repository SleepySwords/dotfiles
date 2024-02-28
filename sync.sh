#! /usr/bin/env fish

set configs "borders" "nvim" "fish" "karabiner" "kitty" "sketchybar" "skhd" "yabai"
for config in $configs
	rm -rf $config
	cp -r ~/.config/$config .
end
