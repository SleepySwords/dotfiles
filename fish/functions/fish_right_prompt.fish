function fish_right_prompt
    echo (fish_git_prompt)
    echo -n " ["
    set_color cyan;
    echo -n $status
    set_color normal;
    echo -n "]"
end
