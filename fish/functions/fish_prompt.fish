function fish_prompt
    set_color green;
    echo -n '❱'
    set_color yellow;
    echo -n '❱'
    set_color red;
    echo -n '❱ '

    set_color normal;

    echo -n "["
    set_color magenta;
    echo -n (prompt_pwd)
    set_color normal;
    echo -n "]"
    
    set_color normal;
    echo ' % '
end
