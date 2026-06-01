#!/bin/bash

LOCK_FILE="/tmp/sketchybar_media_scroll.lock"

# Function to set drawing state for all media items
set_media_drawing_state() {
  sketchybar --set media_back drawing=$1
  sketchybar --set media_play_pause drawing=$1
  sketchybar --set media_next drawing=$1
  sketchybar --set media drawing=$1
}

case "$SENDER" in
"mouse.entered")
  # If a scroll animation is not already in progress...
  if [ ! -f "$LOCK_FILE" ]; then
    # Create lock file
    touch "$LOCK_FILE"

    # Start scrolling
    sketchybar --set media scroll_texts=on

    # In the background, wait for the scroll to finish, then stop it and remove the lock.
    (
      sleep 1
      sketchybar --set media scroll_texts=off
      rm "$LOCK_FILE"
    ) &
  fi
  ;;
*) # Default update
  PLAYBACK_RATE=$(nowplaying-cli get playbackRate)
  TITLE=$(nowplaying-cli get title)
  ARTIST=$(nowplaying-cli get artist)

  # Treat "null" string as empty
  if [[ "$TITLE" == "null" ]]; then
    TITLE=""
  fi
  if [[ "$ARTIST" == "null" ]]; then
    ARTIST=""
  fi

  if [[ -z "$TITLE" && -z "$ARTIST" ]]; then
    set_media_drawing_state off
    exit 0
  fi

  IS_PLAYING=0
  # Check if PLAYBACK_RATE is a number before using bc
  if [[ "$PLAYBACK_RATE" =~ ^[0-9\.]+$ ]]; then
    if [ "$(echo "$PLAYBACK_RATE > 0" | bc -l)" -eq 1 ]; then
      IS_PLAYING=1
    fi
  fi

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

  if [ "$IS_PLAYING" -eq 1 ]; then
    sketchybar --set media_play_pause icon=􀊘 # Pause icon
  else
    sketchybar --set media_play_pause icon= # Play icon
  fi

  sketchybar --set media label="$LABEL"
  set_media_drawing_state on
  ;;
esac
