if status is-interactive
    # Commands to run in interactive sessions can go here
end

export GPG_TTY=$(tty)

# Setting PATH for Python 3.11
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

set -x LIBRARY_PATH "$LIRBARY_PATH" "$(brew --prefix)/lib" "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/ibby/.ghcup/bin # ghcup-env

# Emulates vim's cursor shape behavior
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

set -gx BAT_THEME OneHalfLight



# set -g __fish_git_prompt_show_informative_status 1
# set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch red
# set -g __fish_git_prompt_showupstream "informative"
# set -g __fish_git_prompt_char_upstream_ahead "↑"
# set -g __fish_git_prompt_char_upstream_behind "↓"
# set -g __fish_git_prompt_char_upstream_prefix ""
#
# set -g __fish_git_prompt_char_stagedstate "●"
# set -g __fish_git_prompt_char_dirtystate "✚"
# set -g __fish_git_prompt_char_untrackedfiles "…"
# set -g __fish_git_prompt_char_conflictedstate "✖"
# set -g __fish_git_prompt_char_cleanstate "✔"
#
# set -g __fish_git_prompt_color_dirtystate blue
# set -g __fish_git_prompt_color_stagedstate yellow
# set -g __fish_git_prompt_color_invalidstate red
# set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
# set -g __fish_git_prompt_color_cleanstate green


fish_vi_cursor
fish_vi_key_bindings

# Setting PATH for Python 3.12
# The original version is saved in /Users/ibby/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

set -gx FZF_DEFAULT_OPTS '
           --color=fg:#000000,fg+:#262626,bg:#ffffff,bg+:#bcb6b6
           --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
           --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
           --color=gutter:#bcb6b6,border:#262626,label:#aeaeae,query:#343434
           --preview-window="border-sharp" --prompt="> " --marker=">" --pointer="◆"
           --separator="" --scrollbar="│" --info="default" --preview "bat --color=always {}" --preview-window \'~3\''

starship init fish | source
# enable_transience
