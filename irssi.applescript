if isAppRunning("iTerm") then
  tell application "iTerm"
    set myterm to (make new terminal)
    tell myterm
      set mysession to (make new session at the end of sessions)
      tell mysession
        exec command "/usr/local/bin/fish -l"

        tell mysession to write text " fs"
        tell mysession to write text " log message activity User `$USER` opened a new irssi session"
        tell mysession to write text " /usr/local/bin/irssi"
      end tell
    end tell
    activate
  end tell
else
  activate application "iTerm"
end if

(* Code from Dweller on
* http://codesnippets.joyent.com/posts/show/1124
*)
on isAppRunning(appName)
  tell application "System Events" to (name of processes) contains appName
end isAppRunning
