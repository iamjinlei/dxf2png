#!/bin/sh

THISDIR="`pwd`"
RESOURCEDIR="${THISDIR}/unix/resources"
SPTDIR="${THISDIR}/support"

cd "${THISDIR}"

mkdir -p "${RESOURCEDIR}"/fonts
cp "${SPTDIR}"/fonts/*.lff* "${RESOURCEDIR}"/fonts
