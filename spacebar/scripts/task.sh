#! /usr/bin/env fish

set task (osascript -e 'tell application "Reminders" to name of first reminders whose flagged is true and completed is false')
if not test -n "$task"
    set task "No current task!!!"
end
echo "Current Task: $task"
