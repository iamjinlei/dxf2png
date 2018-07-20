#!/bin/sh

THISDIR="`pwd`"
LCDIR="${THISDIR}/core"
RESOURCEDIR="${THISDIR}/unix/resources"
SPTDIR="${LCDIR}/support"

cd "${THISDIR}"

# Postprocess for unix
mkdir -p "${RESOURCEDIR}"/fonts
cp "${SPTDIR}"/fonts/*.lff* "${RESOURCEDIR}"/fonts
