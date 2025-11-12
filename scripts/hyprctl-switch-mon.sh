#!/usr/bin/sh
focusmon_id=$(hyprctl activeworkspace | grep "monitorID" | awk '{print $2}')

if [[ $focusmon_id == 0 ]]; then
	to_workspace=$(hyprctl monitors | grep "ID 1" -A7 | grep "active workspace" | awk '{print $3}');
else
	to_workspace=$(hyprctl monitors | grep "ID 0" -A7 | grep "active workspace" | awk '{print $3}');
fi

hyprctl dispatch workspace $to_workspace
