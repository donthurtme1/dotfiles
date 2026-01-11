#!/bin/env bash

readonly dwl_output_filename="$HOME/.cache/dwloutput"
log_lines_per_focus_change=7
monitor="${1}"

[[ ! -f "${dwl_output_filename}" ]] && printf -- '%s\n' \
	"You need to redirect dwl stdout to ~/.cache/dwloutput" >&2
while [[ -n "$(pgrep waybar)" ]]; do
	dwl_latest_output_by_monitor="$(grep  -E "^${monitor}\s" "${dwl_output_filename}" | tail --lines=${log_lines_per_focus_change})"

	#title="$(echo   "${dwl_latest_output_by_monitor}" | grep '^[[:graph:]]* title'  | cut -d ' ' -f 3- )"
    #title="${title//\"/“}" # Replace quotation - prevent waybar crash
    #title="${title//\&/+}" # Replace ampersand - prevent waybar crash

	echo "$dwl_latest_output_by_monitor"

	inotifywait -t 60 -qq --event modify "${dwl_output_filename}"
done
