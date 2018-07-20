#!/bin/bash

#docker run -i -t --rm -v `pwd`:/data -u=$UID:$(id -g $USER) dxf2png:latest bash -c "pwd; xvfb-run -a /dxf2png/dxf2png /data/$1 /data/$2"
#docker run -i -t --rm -v `pwd`:/data -u=$UID:$(id -g $USER) dxf2png:latest bash -c "pwd; xvfb-run -a /dxf2png/dxf2png /data/$1 /data/$2 black 1024 768"
docker run -i -t --rm -v `pwd`:/data --entrypoint /bin/bash dxf2png:latest
