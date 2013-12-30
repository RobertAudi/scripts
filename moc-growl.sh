#!/bin/bash
#
# Monitors MOC and displays a Growl
# notification when state changes (i.e.: New song, play, pause, etc.)
#

while out=$(`/usr/local/bin/brew --prefix moc`/bin/mocp -i); do
  # Parse mocp output.
  while IFS=: read -r field value; do
    case $field in
      State) state=$value;;
      Artist) artist=$(echo -n "$value" | tr -d '\n');;
      Album) album=$value;;
      SongTitle) title=$(echo -n "$value" | tr -d '\n');;
      File) file=$(echo $value | sed 's/\/.*\/\(.*\..*\)/\1/g');;
    esac
  done <<< "$out"

  # Don't do anything if we're still on the same song.
  [[ "$state-$artist-$album-$title" = "$current" ]] && { sleep 1; continue; }

  # Growl notify this information
  if [[ $artist && $title ]]; then
    /usr/local/bin/growlnotify -t "$title" -n "MOC" -m "by $artist"
  else
    /usr/local/bin/growlnotify -t "$file" -n "MOC" -m ""
  fi

  # Remember the current song.
  current="$state-$artist-$album-$title"
done
