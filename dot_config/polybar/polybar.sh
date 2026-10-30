#!/usr/bin/env bash

# ponytail: one backlight, else intel then amdgpu. Several cards of the same
# vendor need an explicit card.
shopt -s nullglob
cards=(/sys/class/backlight/*)
card=
for c in "${cards[@]}"; do
	base=${c##*/}
	if [[ $base == intel_backlight ]]; then
		card=$base
		break
	fi
done
if [[ -z $card ]]; then
	for c in "${cards[@]}"; do
		base=${c##*/}
		if [[ $base == amdgpu_bl* ]]; then
			card=$base
			break
		fi
	done
fi
if [[ -z $card && ${#cards[@]} -gt 0 ]]; then
	card=${cards[0]##*/}
fi
if [[ -n $card ]]; then
	export POLYBAR_BACKLIGHT=$card
fi

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log
polybar example 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bar launched..."
