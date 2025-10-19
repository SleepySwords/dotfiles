#!/bin/bash

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"
CPU_DATA_POINT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.2f\n", ($1 + $2)}')"

echo $CPU_DATA_POINT

sketchybar --set $NAME label="$CPU_PERCENT%"
sketchybar --push cpu_graph $CPU_DATA_POINT
