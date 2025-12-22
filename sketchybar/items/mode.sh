#!/bin/bash

sketchybar --add event mode_changed

sketchybar --add item mode right \
           --set mode  \
                      script="$PLUGIN_DIR/mode.sh" \
           --subscribe mode mode_changed
