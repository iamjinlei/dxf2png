#!/bin/sh

THISDIR="`pwd`"
LCDIR="${THISDIR}/librecad"
RESOURCEDIR="${THISDIR}/unix/resources"
APPDATADIR="${THISDIR}/unix/appdata"
SPTDIR="${LCDIR}/support"

cd "${THISDIR}"

# Postprocess for unix
mkdir -p "${RESOURCEDIR}"/fonts
mkdir -p "${RESOURCEDIR}"/patterns
#cp "${SPTDIR}"/patterns/*.dxf "${RESOURCEDIR}"/patterns
cp "${SPTDIR}"/fonts/*.lff* "${RESOURCEDIR}"/fonts
#find "${SPTDIR}"/library -type d | sed 's:^.*support/::' | xargs -IFILES  mkdir -p "${RESOURCEDIR}"/FILES
#find "${SPTDIR}"/library -type f -iname *.dxf | sed 's/^.*support//' | xargs -IFILES  cp "${SPTDIR}"/FILES "${RESOURCEDIR}"/FILES

# copy appdata.xml to unix/appdata/librecad.appdata.xml
mkdir -p "${APPDATADIR}"
cp "${SPTDIR}"/librecad.appdata.xml "${APPDATADIR}"/
