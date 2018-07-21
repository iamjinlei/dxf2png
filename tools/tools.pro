#-------------------------------------------------
#
# Project created by QtCreator 2011-03-22T19:33:11
#
#-------------------------------------------------

TEMPLATE = subdirs

unix {
    packagesExist(freetype2){
	SUBDIRS = ttf2lff
    } else{
        message( "package freetype2 is not found. Ignoring ttf2lff")
    }
}
