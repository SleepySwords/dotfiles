if status is-interactive
    # Commands to run in interactive sessions can go here
end

export GPG_TTY=$(tty)

# Setting PATH for Python 3.11
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/ibby/.ghcup/bin # ghcup-env

# Emulates vim's cursor shape behavior
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

set -gx BAT_THEME OneHalfLight

fish_vi_cursor
fish_vi_key_bindings

set -gx FZF_DEFAULT_OPTS '
           --color=fg:#000000,fg+:#262626,bg:#ffffff,bg+:#bcb6b6
           --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
           --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
           --color=gutter:#bcb6b6,border:#262626,label:#aeaeae,query:#343434
           --preview-window="border-sharp" --prompt="> " --marker=">" --pointer="◆"
           --separator="" --scrollbar="│" --info="default" --preview "bat --color=always {}" --preview-window \'~3\''
