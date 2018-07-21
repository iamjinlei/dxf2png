#-------------------------------------------------
#
# Project created by QtCreator 2011-07-31T10:54:43
#
#-------------------------------------------------

include(../../common.pri)
include(./freetype.pri)

QT -= core gui svg
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app
DEFINES += VERSION="\"0.0.0.2\""

GENERATED_DIR = ../../generated/tools/ttf2lff
SOURCES += main.cpp

unix {
    TARGET = ../../unix/ttf2lff
}
