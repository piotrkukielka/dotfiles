#!/bin/sh
# Toggle every microphone together. *.monitor sources are playback taps.
# If any mic is live, mute them all; otherwise unmute them all.
action=0
for name in $(pactl list short sources | cut -f2); do
	case $name in
	*.monitor) continue ;;
	esac
	pactl get-source-mute "$name" | grep -q ": no" && action=1
done
for name in $(pactl list short sources | cut -f2); do
	case $name in
	*.monitor) continue ;;
	esac
	pactl set-source-mute "$name" "$action" || exit 1
done
