#!/bin/bash

#docker run -i -t --rm -v /Users/lei/code/librecad:/work -u=$UID:$(id -g $USER) --entrypoint /bin/bash dxf2png:latest
docker run -i -t --rm -v `pwd`:/work --entrypoint /bin/bash dxf2png:latest
