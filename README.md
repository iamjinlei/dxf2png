# dxf2png

dxf2png is a fork and stripped down version of LibreCAD that allows you to convert DXF file to bitmap format (e.g. png) headlessly

# Getting started

docker build --rm -t dxf2png .

./run.sh

xvfb-run -a ./unix/librecad
