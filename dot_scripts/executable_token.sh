#!/bin/sh

softtoken -t redhat | tr -d '[:space:]' | xclip -sel clip -i
