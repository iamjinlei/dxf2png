# LibreCAD project file
# (c) Ries van Twisk (librecad@rvt.dds.nl)
TEMPLATE = app

#uncomment to enable a Debugging menu entry for basic unit testing
#DEFINES += LC_DEBUGGING

DEFINES += DWGSUPPORT
DEFINES -= JWW_WRITE_SUPPORT

#LC_VERSION="2.2.0-alpha"
#VERSION=$${LC_VERSION}

# Store intermedia stuff somewhere else
GENERATED_DIR = ../generated/dxf2png
# Use common project definitions.
include(../common.pri)
include(./boost.pri)

CONFIG += qt \
    warn_on \
    link_prl \
    verbose \
    depend_includepath

QT += widgets printsupport
CONFIG += c++11
*-g++ {
    QMAKE_CXXFLAGS += -fext-numeric-literals
}

GEN_LIB_DIR = ../generated/lib
PRE_TARGETDEPS += $$GEN_LIB_DIR/libdxfrw.a \
		$$GEN_LIB_DIR/libjwwlib.a

DESTDIR = ../unix

# Make translations at the end of the process
unix {
    TARGET = dxf2png
    DEFINES += QC_APPDIR="\"dxf2png\""
    QMAKE_POST_LINK = cd $$_PRO_FILE_PWD_/.. && scripts/postprocess-unix.sh
}

# Additional libraries to load
LIBS += -L../generated/lib  \
    -ldxfrw \
    -ljwwlib

INCLUDEPATH += \
    ../libraries/libdxfrw/src \
    ../libraries/jwwlib/src \
    lib/creation \
    lib/debug \
    lib/engine \
    lib/fileio \
    lib/filters \
    lib/generators \
    lib/gui \
    lib/math \
    lib/modification \
    lib/information \
    main

# ################################################################################
# Library
HEADERS += \
    lib/creation/rs_creation.h \
    lib/debug/rs_debug.h \
    lib/engine/rs.h \
    lib/engine/rs_arc.h \
    lib/engine/rs_atomicentity.h \
    lib/engine/rs_block.h \
    lib/engine/rs_blocklist.h \
    lib/engine/rs_blocklistlistener.h \
    lib/engine/rs_clipboard.h \
    lib/engine/rs_circle.h \
    lib/engine/rs_color.h \
    lib/engine/rs_constructionline.h \
    lib/engine/rs_dimaligned.h \
    lib/engine/rs_dimangular.h \
    lib/engine/rs_dimdiametric.h \
    lib/engine/rs_dimension.h \
    lib/engine/rs_dimlinear.h \
    lib/engine/rs_dimradial.h \
    lib/engine/rs_document.h \
    lib/engine/rs_ellipse.h \
    lib/engine/rs_entity.h \
    lib/engine/rs_entitycontainer.h \
    lib/engine/rs_flags.h \
    lib/engine/rs_font.h \
    lib/engine/rs_fontchar.h \
    lib/engine/rs_fontlist.h \
    lib/engine/rs_graphic.h \
    lib/engine/rs_hatch.h \
    lib/engine/lc_hyperbola.h \
    lib/engine/rs_insert.h \
    lib/engine/rs_image.h \
    lib/engine/rs_layer.h \
    lib/engine/rs_layerlist.h \
    lib/engine/rs_layerlistlistener.h \
    lib/engine/rs_leader.h \
    lib/engine/rs_line.h \
    lib/engine/rs_mtext.h \
    lib/engine/rs_overlayline.h \
    lib/engine/rs_overlaybox.h \
    lib/engine/rs_pattern.h \
    lib/engine/rs_patternlist.h \
    lib/engine/rs_pen.h \
    lib/engine/rs_point.h \
    lib/engine/rs_polyline.h \
    lib/engine/rs_settings.h \
    lib/engine/rs_solid.h \
    lib/engine/rs_spline.h \
    lib/engine/lc_splinepoints.h \
    lib/engine/rs_system.h \
    lib/engine/rs_text.h \
    lib/engine/rs_undo.h \
    lib/engine/rs_undoable.h \
    lib/engine/rs_undocycle.h \
    lib/engine/rs_units.h \
    lib/engine/rs_utility.h \
    lib/engine/rs_variable.h \
    lib/engine/rs_variabledict.h \
    lib/engine/rs_vector.h \
    lib/fileio/rs_fileio.h \
    lib/filters/rs_filtercxf.h \
    lib/filters/rs_filterdxfrw.h \
    lib/filters/rs_filterdxf1.h \
    lib/filters/rs_filterjww.h \
    lib/filters/rs_filterlff.h \
    lib/filters/rs_filterinterface.h \
    lib/gui/rs_graphicview.h \
    lib/gui/rs_linetypepattern.h \
    lib/gui/rs_painter.h \
    lib/gui/rs_painterqt.h \
    lib/gui/rs_staticgraphicview.h \
    lib/information/rs_locale.h \
    lib/information/rs_information.h \
    lib/information/rs_infoarea.h \
    lib/modification/rs_modification.h \
    lib/modification/rs_selection.h \
    lib/math/rs_math.h \
    lib/math/lc_quadratic.h \
    lib/generators/lc_makercamsvg.h \
    lib/generators/lc_xmlwriterinterface.h \
    lib/generators/lc_xmlwriterqxmlstreamwriter.h \
    lib/engine/lc_rect.h \
    main/lc_application.h

SOURCES += \
    lib/creation/rs_creation.cpp \
    lib/debug/rs_debug.cpp \
    lib/engine/rs_arc.cpp \
    lib/engine/rs_block.cpp \
    lib/engine/rs_blocklist.cpp \
    lib/engine/rs_clipboard.cpp \
    lib/engine/rs_circle.cpp \
    lib/engine/rs_constructionline.cpp \
    lib/engine/rs_dimaligned.cpp \
    lib/engine/rs_dimangular.cpp \
    lib/engine/rs_dimdiametric.cpp \
    lib/engine/rs_dimension.cpp \
    lib/engine/rs_dimlinear.cpp \
    lib/engine/rs_dimradial.cpp \
    lib/engine/rs_document.cpp \
    lib/engine/rs_ellipse.cpp \
    lib/engine/rs_entity.cpp \
    lib/engine/rs_entitycontainer.cpp \
    lib/engine/rs_font.cpp \
    lib/engine/rs_fontlist.cpp \
    lib/engine/rs_graphic.cpp \
    lib/engine/rs_hatch.cpp \
    lib/engine/lc_hyperbola.cpp \
    lib/engine/rs_insert.cpp \
    lib/engine/rs_image.cpp \
    lib/engine/rs_layer.cpp \
    lib/engine/rs_layerlist.cpp \
    lib/engine/rs_leader.cpp \
    lib/engine/rs_line.cpp \
    lib/engine/rs_mtext.cpp \
    lib/engine/rs_overlayline.cpp \
    lib/engine/rs_overlaybox.cpp \
    lib/engine/rs_pattern.cpp \
    lib/engine/rs_patternlist.cpp \
    lib/engine/rs_point.cpp \
    lib/engine/rs_polyline.cpp \
    lib/engine/rs_settings.cpp \
    lib/engine/rs_solid.cpp \
    lib/engine/rs_spline.cpp \
    lib/engine/lc_splinepoints.cpp \
    lib/engine/rs_system.cpp \
    lib/engine/rs_text.cpp \
    lib/engine/rs_undo.cpp \
    lib/engine/rs_undoable.cpp \
    lib/engine/rs_units.cpp \
    lib/engine/rs_utility.cpp \
    lib/engine/rs_variabledict.cpp \
    lib/engine/rs_vector.cpp \
    lib/fileio/rs_fileio.cpp \
    lib/filters/rs_filtercxf.cpp \
    lib/filters/rs_filterdxfrw.cpp \
    lib/filters/rs_filterdxf1.cpp \
    lib/filters/rs_filterjww.cpp \
    lib/filters/rs_filterlff.cpp \
    lib/gui/rs_graphicview.cpp \
    lib/gui/rs_linetypepattern.cpp \
    lib/gui/rs_painter.cpp \
    lib/gui/rs_painterqt.cpp \
    lib/gui/rs_staticgraphicview.cpp \
    lib/information/rs_locale.cpp \
    lib/information/rs_information.cpp \
    lib/information/rs_infoarea.cpp \
    lib/math/rs_math.cpp \
    lib/math/lc_quadratic.cpp \
    lib/modification/rs_modification.cpp \
    lib/modification/rs_selection.cpp \
    lib/engine/rs_color.cpp \
    lib/engine/rs_pen.cpp \
    lib/generators/lc_xmlwriterqxmlstreamwriter.cpp \
    lib/generators/lc_makercamsvg.cpp \
    lib/engine/rs_atomicentity.cpp \
    lib/engine/rs_undocycle.cpp \
    lib/engine/rs_flags.cpp \
    lib/engine/lc_rect.cpp \
    lib/engine/rs.cpp \
    main/lc_application.cpp

# ################################################################################
# Main
HEADERS += \
    main/main.h \

SOURCES += \
    main/main.cpp \
