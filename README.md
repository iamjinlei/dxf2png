# dxf2png

dxf2png is a fork and stripped down version of LibreCAD that allows you to convert DXF file to bitmap format (e.g. png) headlessly

# Getting started

docker build --rm -t dxf2png .

./convert.sh dxf_path dest_path

Path needs to be relative to current directory

Example:

./convert.sh data/test.dxf test.png
