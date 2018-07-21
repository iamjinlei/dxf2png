#!/bin/bash

if [[ $1 == "bash" ]]; then
    docker run -i -t --rm -v `pwd`:/data --entrypoint /bin/bash dxf2png:latest
else
    # $1 dxf file path relative to current directory
    # $2 output file path relative to current directory. File exetension controls file type to convert (.png, .bmp, .jpg, .svg are supported)
    # $3 (optional) output file background color: black, white, transparent
    # $4 (optional) output file max width
    # $5 (optional) output file max height
    docker run -i -t --rm -v `pwd`:/data -u=$UID:$(id -g $USER) dxf2png:latest bash -c "pwd; xvfb-run -a /dxf2png/dxf2png /data/$1 /data/$2 $3 $4 $5"
fi
