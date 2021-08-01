function fish_right_prompt
    echo (fish_git_prompt)
    echo " ["
    set_color cyan;
    echo $status
    set_color normal;
    echo "]"
end
