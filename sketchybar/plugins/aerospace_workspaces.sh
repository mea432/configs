#!/bin/bash

source "$CONFIG_DIR/colors.sh"

MONITOR_ID="$1"
WORKSPACE="$2"

if [ -z "$MONITOR_ID" ] || [ -z "$WORKSPACE" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

VISIBLE_ON_MONITOR=$(aerospace list-workspaces --monitor "$MONITOR_ID" --visible 2>/dev/null)
POPULATED_ON_MONITOR=$(aerospace list-workspaces --monitor "$MONITOR_ID" --empty no 2>/dev/null)
FULLSCREEN_WINDOWS=$(aerospace list-windows --workspace "$WORKSPACE" --format '%{window-is-fullscreen}' 2>/dev/null)
FOCUSED_MONITOR_ID=$(aerospace list-monitors --focused --format '%{monitor-id}' 2>/dev/null)

is_visible=false
is_populated=false
is_fullscreen=false
is_focused_monitor=false

if echo "$VISIBLE_ON_MONITOR" | grep -F -x -q "$WORKSPACE"; then
  is_visible=true
fi

if echo "$POPULATED_ON_MONITOR" | grep -F -x -q "$WORKSPACE"; then
  is_populated=true
fi

if echo "$FULLSCREEN_WINDOWS" | grep -F -x -q "true"; then
  is_fullscreen=true
fi

if [ "$FOCUSED_MONITOR_ID" = "$MONITOR_ID" ]; then
  is_focused_monitor=true
fi

if [ "$is_visible" = true ] && [ "$is_focused_monitor" = true ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    icon.color="$BLACK" \
    label.drawing="$is_fullscreen" \
    label.color="$BLACK" \
    background.drawing=on \
    background.color="$BLUE" \
    background.border_width=0
elif [ "$is_visible" = true ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    icon.color="$BLUE" \
    label.drawing="$is_fullscreen" \
    label.color="$BLUE" \
    background.drawing=on \
    background.color="$TRANSPARENT" \
    background.border_color="$BLUE" \
    background.border_width=2
elif [ "$is_populated" = true ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    icon.color="$WHITE" \
    label.drawing="$is_fullscreen" \
    label.color="$WHITE" \
    background.drawing=on \
    background.color="$BACKGROUND_2" \
    background.border_width=0
else
  sketchybar --set "$NAME" drawing=off label.drawing=off background.border_width=0
fi
