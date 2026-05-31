#!/bin/bash

LOCK_FILE="/tmp/sketchybar_media_scroll.lock"

case "$SENDER" in
"mouse.entered")
  # If a scroll animation is not already in progress...
  if [ ! -f "$LOCK_FILE" ]; then
    # Create lock file
    touch "$LOCK_FILE"

    # Start scrolling
    sketchybar --set $NAME scroll_texts=on

    # In the background, wait for the scroll to finish, then stop it and remove the lock.
    (
      sleep 1
      sketchybar --set $NAME scroll_texts=off
      rm "$LOCK_FILE"
    ) &
  fi
  ;;

"mouse.exited")
  # Do nothing. Let the animation finish.
  ;;

*) # Default update
  TITLE=$(nowplaying-cli get title)
  ARTIST=$(nowplaying-cli get artist)
  if [[ -n "$TITLE" ]]; then
    LABEL="$TITLE - $ARTIST"
    sketchybar --set $NAME label="$LABEL" drawing=on
  else
    sketchybar --set $NAME drawing=off
  fi
  ;;
esac
