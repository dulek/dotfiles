#!/bin/bash

for domain in `virsh list --name --state-running`; do
    virsh suspend $domain
done

xdg-screensaver lock
systemctl suspend
