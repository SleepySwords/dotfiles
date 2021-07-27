#! /usr/bin/env fish

set isRunning (osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"')

if test $isRunning = "true"
    set isPlaying (osascript -e 'tell application "Spotify" to player state as string')
    

    if test $isPlaying = "playing"
        set artist (osascript -e 'tell application "Spotify" to artist of current track as string')
        set track (osascript -e 'tell application "Spotify" to name of current track as string')
        echo "Playing $track by $artist"
    else
        echo ""
    end
else
    echo ""
end
