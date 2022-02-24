#!/bin/bash

num=`dconf read /org/gnome/desktop/wm/preferences/num-workspaces`
if [ "$num" -eq 5 ]; then
    dconf write /org/gnome/desktop/wm/preferences/num-workspaces 4
else
    dconf write /org/gnome/desktop/wm/preferences/num-workspaces 5
fi
