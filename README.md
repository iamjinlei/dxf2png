# dxf2png

dxf2png is a fork and stripped down version of LibreCAD that allows you to convert DXF file to graphic format headlessly. Support png, bmp, jpg and svg.
Other export types supported LibreCAD can also be extended.

# Getting started

docker build --rm -t dxf2png .

./convert.sh dxf_path dest_path

Path needs to be relative to current directory

Example:

./convert.sh data/test.dxf test.png
