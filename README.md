# dxf2png

dxf2png was originally forked from [LibreCAD](https://github.com/LibreCAD/LibreCAD). Most of the unrelated code were stripped out. The goal is to allow you to convert DXF file to graphic format headlessly. It still relies on QT system for passing messages to draw things. It is the central piece of the LibreCAD UI framework. The implementation of exporting graphic files is simply a specialized implementation of the interface. It is possible to get rid of QT dependency but may require significant work. The workaround here is to invoke the binary using xvfb-run. Support png, bmp, jpg and svg. Other export types supported by LibreCAD can also be extended.

# Getting started

## Build docker image

docker build --rm -t dxf2png .

## Run

./convert.sh dxf_path dest_path

Path needs to be relative to current directory

Example:

./convert.sh data/test.dxf test.png

Additional parameters are supported to specify background color (png), dimension, the whitelist/blacklist of dxf layers. Check comment in convert.sh for detail.
