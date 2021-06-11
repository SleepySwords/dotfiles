function fish_greeting
    echo Hello friend!
    echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called (set_color red; hostname)
end