#! /usr/bin/env fish

# Thanks to this https://stackoverflow.com/questions/30855440/how-to-get-cpu-utilization-in-in-terminal-mac

set cpu (top -l 1 -s 0 | grep -E "^CPU" | awk '{print $3" + "$5" = "$3+$5"%"}')

set free_ram (vm_stat | grep -E "Pages (free|inactive)" | awk '{s+=$3} END {print s / 256}')

set total_ram (sysctl -n hw.memsize | awk '{print $1 / 1024 / 1024}')

set used_ram (math -s0 $total_ram - $free_ram)

echo "CPU: $cpu       RAM: $used_ram MB / $total_ram MB"
