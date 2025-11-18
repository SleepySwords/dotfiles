#!/bin/bash

sketchybar --add graph cpu_graph right 20 \
           --set cpu_graph update_freq=2 \
                 script="$PLUGIN_DIR/cpu_graph.sh"
