function fish_right_prompt
    echo (fish_git_prompt %s)

    echo -n " "
    set_color yellow;
    echo -n (date +%T)
    set_color normal;

    echo " ["
    set_color cyan;
    echo $status
    set_color normal;
    echo "]"
end
