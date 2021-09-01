#! /usr/bin/env fish

set currentProfile ('/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli' --show-current-profile-name)

if test $currentProfile = "VI-Mode"
    '/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli' --select-profile 'Programming'
else
    '/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli' --select-profile 'VI-Mode'
end
