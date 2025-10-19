#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon=􀧓  \
                      script="$PLUGIN_DIR/cpu.sh"

sketchybar --add graph cpu_graph right 20
