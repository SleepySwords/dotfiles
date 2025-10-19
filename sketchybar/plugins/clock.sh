#!/usr/bin/env bash

CLOCK="$(date '+%a  %d  %b  %I:%M %p')"

sketchybar --set $NAME label="$CLOCK"
