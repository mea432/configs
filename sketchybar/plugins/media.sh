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
  PLAYBACK_RATE=$(nowplaying-cli get playbackRate)

  # Default to not paused
  IS_PAUSED=0
  # Check if PLAYBACK_RATE is a number before using bc
  if [[ "$PLAYBACK_RATE" =~ ^[0-9.-]+$ ]]; then
      if [ "$(echo "$PLAYBACK_RATE == 0" | bc -l)" -eq 1 ]; then
          IS_PAUSED=1
      fi
  fi

  # Treat "null" string as empty
  if [[ "$TITLE" == "null" ]]; then
    TITLE=""
  fi
  if [[ "$ARTIST" == "null" ]]; then
    ARTIST=""
  fi

  # If both title and artist are empty, OR it's paused, then hide the item
  if [[ (-z "$TITLE" && -z "$ARTIST") || $IS_PAUSED -eq 1 ]]; then
    sketchybar --set $NAME drawing=off
  else
    LABEL=""
    if [[ -n "$TITLE" ]]; then
      LABEL="$TITLE"
    fi
    if [[ -n "$ARTIST" ]]; then
      if [[ -n "$LABEL" ]]; then
        LABEL="$LABEL - $ARTIST"
      else
        LABEL="$ARTIST"
      fi
    fi
    sketchybar --set $NAME label="$LABEL" drawing=on
  fi
  ;;
esac
