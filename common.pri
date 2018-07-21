# Store intermedia stuff somewhere else
isEmpty(GENERATED_DIR){
 GENERATED_DIR = generated
}
 # Store intermedia stuff somewhere else
OBJECTS_DIR = $${GENERATED_DIR}/obj
MOC_DIR = $${GENERATED_DIR}/moc
RCC_DIR = $${GENERATED_DIR}/rcc

# Copy command
COPY = cp

QMAKE_CXXFLAGS_DEBUG += -g
QMAKE_CXXFLAGS += -g

# fix for GitHub Issue #880
# prevent QMake from using -isystem flag for system include path
# this breaks gcc 6 builds because of its #include_next feature
QMAKE_CFLAGS_ISYSTEM = ""

# svg support
QT += svg

greaterThan( QT_MAJOR_VERSION, 4) {
	CONFIG += c++11
}else{
	QMAKE_CXXFLAGS += -std=c++11
	QMAKE_CXXFLAGS_DEBUG += -std=c++11
}
