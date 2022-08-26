#!/bin/bash
Xvfb :99 -ac -listen tcp -screen 0 2560x1440x24 &
sleep 3

x11vnc -forever -usepw -create &
/bin/bash
