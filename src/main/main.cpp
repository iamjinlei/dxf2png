/****************************************************************************
**
** This file is part of the LibreCAD project, a 2D CAD program
**
** Copyright (C) 2018 A. Stebich (librecad@mail.lordofbikes.de)
** Copyright (C) 2018 Simon Wells <simonrwells@gmail.com>
** Copyright (C) 2015-2016 ravas (github.com/r-a-v-a-s)
** Copyright (C) 2010 R. van Twisk (librecad@rvt.dds.nl)
** Copyright (C) 2001-2003 RibbonSoft. All rights reserved.
**
** This file may be distributed and/or modified under the terms of the
** GNU General Public License version 2 as published by the Free Software
** Foundation and appearing in the file gpl-2.0.txt included in the
** packaging of this file.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
**
** This copyright notice MUST APPEAR in all copies of the script!
**
**********************************************************************/
#include <clocale>
#include <cmath>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <string>
#include <vector>

#include <QDebug>
#include <QApplication>
#include <QSplashScreen>
#include <QSettings>
#include <QMessageBox>
#include <QFileInfo>
#include <QtSvg>

#include "main.h"
#include "rs_fontlist.h"
#include "rs_patternlist.h"
#include "rs_settings.h"
#include "rs_system.h"
#include "rs_graphic.h"
#include "rs_painterqt.h"
#include "rs_staticgraphicview.h"
#include "rs.h"

#include "lc_application.h"
#include "rs_debug.h"

std::vector<std::string> splitToSet(const std::string &s, char delim) {
    std::stringstream ss(s);
    std::string item;
    std::vector<std::string> v;
    while (std::getline(ss, item, delim)) {
        v.push_back(item);
    }
    return v;
}

/**
 * Exports the drawing as a bitmap or another picture format.
 *
 * @param name File name.
 * @param format File format (e.g. "png")
 * @param size Size of the bitmap in pixel
 * @param black true: Black background, false: white
 * @param bw true: black/white export, false: color
 */
bool slotFileExport(
    RS_Graphic* graphic,
    const QString& name,
    const QString& format,
    const QSize& size,
    const QSize& borders,
    const std::string& bgColor) {

    QApplication::setOverrideCursor( QCursor(Qt::WaitCursor) );

    bool ret = false;
    // set vars for normal pictures and vectors (svg)
    QPixmap* picture = new QPixmap(size);
    if (bgColor == "transparent") {
        picture->fill(Qt::transparent);
    }

    QSvgGenerator* vector = new QSvgGenerator();
    // set buffer var
    QPaintDevice* buffer;
    if(format.toLower() != "svg") {
        buffer = picture;
    } else {
        vector->setSize(size);
        vector->setViewBox(QRectF(QPointF(0,0),size));
        vector->setFileName(name);
        buffer = vector;
    }

    // set painter with buffer
    RS_PainterQt painter(buffer);
    if (bgColor == "black") {
		painter.setBackground(Qt::black);
    } else if (bgColor == "white") {
        painter.eraseRect(0,0, size.width(), size.height());
		painter.setBackground(Qt::white);
    }

	RS_StaticGraphicView gv(size.width(), size.height(), &painter, &borders);
    if (bgColor == "black") {
		gv.setBackground(Qt::black);
    } else if (bgColor == "white") {
		gv.setBackground(Qt::white);
    }

    gv.setContainer(graphic);
    gv.zoomAuto(false);
	gv.drawEntity(&painter, gv.getContainer());

    // end the picture output
    if(format.toLower() != "svg") {
        QImageWriter iio;
        QImage img = picture->toImage();
        iio.setFileName(name);
        iio.setFormat(format.toLatin1());
        if (iio.write(img)) {
            ret = true;
        }
    }
    QApplication::restoreOverrideCursor();

    // GraphicView deletes painter
    painter.end();
    // delete vars
    delete picture;
    delete vector;

    return ret;
}


int main(int argc, char** argv) {
    QT_REQUIRE_VERSION(argc, argv, "5.2.1");
    RS_DEBUG->setLevel(RS_Debug::D_WARNING);

    LC_Application app(argc, argv);

    QFileInfo prgInfo(QFile::decodeName(argv[0]));
    RS_SYSTEM->init(
        app.applicationName(),
        app.applicationVersion(),
         XSTR(QC_APPDIR),
        QString(prgInfo.absolutePath()));
    RS_FONTLIST->init();

    if (argc < 3 || argc > 7) {
        std::cout << "invalid arguments" << std::endl;
        std::cout << "dxf2png dxf_path png_path [black|white|transparent] [width] [height] [layer_filter]" << std::endl;
        return 1;
    }

    std::string dxfPath(argv[1]);
    std::string outPath(argv[2]);
    std::string bgColor = "transparent";
    std::vector<std::string> layerFilter;
    bool inclusion = false;

    if (argc >= 4) {
      bgColor = argv[3];
    }
    int w = 1600;
    int h = 1200;
    if (argc >= 5) {
        w = std::atoi(argv[4]);
    }
    if (argc >= 6) {
        h = std::atoi(argv[5]);
    }
    if (argc == 7) {
        std::string filterStr(argv[6]);
        if (filterStr.size() > 0) {
            if (filterStr[0] == '-') {
                inclusion = false;
                filterStr = filterStr.substr(1);
            } else if (filterStr[0] == '+') {
                inclusion = true;
                filterStr = filterStr.substr(1);
            } else {
                inclusion = true;
            }
            layerFilter = splitToSet(filterStr, ',');
        }
    }

    if (bgColor != "black" && bgColor != "white" && bgColor != "transparent") {
        std::cout << "background color must be: black, white or transparent" << std::endl;
        return 1;
    }
    std::size_t pos = outPath.find_last_of(".");
    if (pos == std::string::npos) {
        std::cout << "output file name must contain extension" << std::endl;
        return 1;
    }

    std::string ext = outPath.substr(pos + 1);
    std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
    if (ext != "png" && ext != "jpg" && ext != "bmp" && ext != "svg") {
        std::cout << "supported output types: png, jpg" << std::endl;
        return 1;
    }

    std::cout << "converting file " << dxfPath << " to " << outPath << std::endl;

    RS_Graphic* doc = new RS_Graphic();
    doc->newDoc();
    if (!doc->open(QString::fromStdString(dxfPath), RS2::FormatUnknown)) {
        std::cout << "failed to open file " << dxfPath << std::endl;
        return 1;
    }

    // Toggle layers in filter
    for (const std::string& layerName : layerFilter) {
        if (inclusion) {
            std::cout << "select layer: " << layerName << std::endl;
        } else {
            std::cout << "skip layer: " << layerName << std::endl;
        }
        doc->toggleLayer(QString::fromStdString(layerName));
    }
    // Reverse selection if filter is a whitelist
    if (inclusion) {
        RS_LayerList* layers = doc->getLayerList();
        for (QList<RS_Layer*>::const_iterator it = layers->begin(); it != layers->end(); it++) {
            doc->toggleLayer(*it);
        }
    }

    doc->calculateBorders();
    const RS_Vector& sz = doc->getSize();
    double ratio = std::min(w / sz.x, h / sz.y);
    w = (int)lrint(sz.x * ratio);
    h = (int)lrint(sz.y * ratio);

    std::cout << "doc dimension [" << sz.x << " x " << sz.y
        << "], scaled to [" << w << " x " << h << "]" << std::endl;

    slotFileExport(
        doc,
        QString::fromStdString(outPath),
        QString::fromStdString(ext),
        QSize(w, h),
        QSize(0, 0),
        bgColor);

    app.processEvents(QEventLoop::AllEvents, 1000);
    return 0;
}
