#!/usr/bin/sh
# command line args
workspace_id=$1

if [[ $(hyprctl monitors | grep "active workspace" | awk '{print $3}' | grep "$workspace_id") != $workspace_id ]]; then
	focusmon_id=$(hyprctl activeworkspace | grep "monitorID" | awk '{print $2}')
	hyprctl dispatch moveworkspacetomonitor $workspace_id $focusmon_id;
	hyprctl dispatch workspace $workspace_id
else
	mon0_workspace=$(hyprctl monitors | grep "ID 0" -A7 | grep "active workspace" | awk '{print $3}')
	mon1_workspace=$(hyprctl monitors | grep "ID 1" -A7 | grep "active workspace" | awk '{print $3}')

	# swap active workspaces of monitors
	hyprctl dispatch moveworkspacetomonitor $mon0_workspace 1
	hyprctl dispatch workspace $mon0_workspace
	hyprctl dispatch moveworkspacetomonitor $mon1_workspace 0
	hyprctl dispatch workspace $mon1_workspace
	hyprctl dispatch workspace $workspace_id
fi
