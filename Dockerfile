FROM ubuntu:16.04

MAINTAINER lei

RUN apt-get update
RUN apt-get -y install g++ gcc make git-core qtbase5-dev libqt5svg5-dev \
 qttools5-dev qtchooser qttools5-dev-tools libmuparser-dev librsvg2-bin \
 libboost-dev libfreetype6-dev libicu-dev pkg-config 
RUN apt-get -y install qt5-default xvfb wget unzip

#RUN mkdir /work

ADD . /work
#RUN cd /work && wget https://github.com/iamjinlei/dxf2png/archive/master.zip
#RUN cd /work && unzip master.zip
#RUN cd /work/dxf2png-master && qmake -r && make -j 8 && cp -rf unix /dxf2png && rm -rf /work/*
RUN cd /work && qmake -r && make -j 8 && cp -rf unix /dxf2png && rm -rf /work/*
