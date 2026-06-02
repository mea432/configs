#!/bin/bash

# Get a list of all non-empty workspaces on the focused monitor
POPULATED_ON_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)

# Get the currently focused workspace name
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Filter out the focused workspace from the list of populated ones on the focused monitor
UNFOCUSED_POPULATED=$(echo "$POPULATED_ON_FOCUSED_MONITOR" | grep -v -F -x "$FOCUSED_WORKSPACE")

if [ -z "$UNFOCUSED_POPULATED" ]; then
  sketchybar --set $NAME drawing=off
else
  # Format the list for sketchybar
  FORMATTED_WORKSPACES=$(echo "$UNFOCUSED_POPULATED" | tr '\n' ' ')
  sketchybar --set $NAME drawing=on label="$FORMATTED_WORKSPACES"
fi
