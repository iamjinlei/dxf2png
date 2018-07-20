FROM ubuntu:16.04

MAINTAINER lei

RUN apt-get update
RUN apt-get -y install g++ gcc make git-core qtbase5-dev libqt5svg5-dev \
 qttools5-dev qtchooser qttools5-dev-tools libmuparser-dev librsvg2-bin \
 libboost-dev libfreetype6-dev libicu-dev pkg-config 
RUN apt-get -y install qt5-default 
RUN apt-get -y install xvfb

RUN mkdir /work

#ADD libdxfrw.zip /work/libdxfrw.zip
#RUN cd /work && unzip libdxfrw.zip

#RUN qmake -r
#RUN  make
