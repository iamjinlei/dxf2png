FROM ubuntu:16.04

MAINTAINER lei

RUN apt-get update
RUN apt-get -y install g++ gcc make git-core qtbase5-dev libqt5svg5-dev \
 qttools5-dev qtchooser qttools5-dev-tools libmuparser-dev librsvg2-bin \
 libboost-dev libfreetype6-dev libicu-dev pkg-config 
RUN apt-get -y install qt5-default 
RUN apt-get -y install xvfb

RUN mkdir /work

ADD dxf2png.zip /work/dxf2png.zip
RUN cd /work && unzip dxf2png.zip
RUN cd dxf2png && qmake -r && make -j 8 && cp -rf unix /dxf2png
