
if [ $SELECTED = true ]; then
    FONT="SF Pro Rounded:Heavy:13.0"
else
    FONT="SF Pro Rounded:Semibold:13.0"
fi

sketchybar --set $NAME icon.highlight=$SELECTED  \
                       icon.font="$FONT"
