#!/bin/bash

softtoken -t redhat | tr -d '[:space:]' | xclip -sel clip -i
nmcli con up id "Amsterdam (AMS2)"
