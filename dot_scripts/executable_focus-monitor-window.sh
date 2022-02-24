#!/bin/bash

N=`date +%s%N`; export PS4='+[$(((`date +%s%N`-$N)/1000000))ms][${BASH_SOURCE}:${LINENO}]: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'; set -x;


direction=$1

#monitors=`xrandr --query | grep " connected" | cut -d "+" -f 2`
#IFS=$'\n' monitors=($(sort <<<"${monitors[*]}"))
#unset IFS

# Hardcoded as xrandr is slooow.
monitors=(0 1920 3840)

# TODO: Code below is awful and will break. We want left boundary of active window.
active_left=$(xdotool getwindowfocus getwindowgeometry | grep Pos | cut -d "," -f 1 | cut -d " " -f 4)

for i in ${!monitors[@]}; do
    if [[ $active_left -ge ${monitors[i]} ]]; then
        if (( $i == ${#monitors[@]} - 1 )) || [[ $active_left < ${monitors[i+1]} ]]; then
            current_monitor=$i
        fi
    fi
done

if [[ $direction == "left" ]]; then
    move=-1
else
    move=1
fi

move_monitor=$(expr $current_monitor + $move)
if (( $move_monitor < 0 )) || [[ $move_monitor > $(expr ${#monitors[@]} - 1) ]]; then
    exit
fi

echo $current_monitor
echo $move_monitor

IFS=', ' read -r -a windows <<< $(xprop -root | grep '_NET_CLIENT_LIST_STACKING(WINDOW)' | cut -d'#' -f 2)
unset IFS

echo ${windows[@]}

for (( i = ${#windows[*]}-1; i >= 0; i-- )) do
    # Same code that'll break.
    window_left=$(xdotool getwindowgeometry ${windows[$i]} | grep Pos | cut -d "," -f 1 | cut -d " " -f 4)
    echo $window_left ${windows[$i]}
    
    # Check virtual desktop
    if [[ $move_monitor == 1 ]]; then # Terrible.
        current_desktop=$(xdotool get_desktop)
        window_desktop=$(xdotool get_desktop_for_window ${windows[$i]})
        if [[ $current_desktop != $window_desktop ]]; then
            continue
        fi
    fi
    
    if [[ $window_left -ge ${monitors[$move_monitor]} ]]; then
        if (( $move_monitor == ${#monitors[@]} - 1 )) || (( $window_left < ${monitors[$move_monitor+1]} )); then
            echo ${windows[$i]}
            wmctrl -iR ${windows[$i]}
            #xdotool mousemove --window ${windows[$i]} 500 200
            exit
        fi
    fi
done
