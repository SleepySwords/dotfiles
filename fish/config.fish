if status is-interactive
    # Commands to run in interactive sessions can go here
end

export GPG_TTY=$(tty)

# Setting PATH for Python 3.11
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

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
