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
#include "main.h"

#include <QDebug>
#include <QApplication>
#include <QSplashScreen>
#include <QSettings>
#include <QMessageBox>
#include <QFileInfo>
#include <QtSvg>

#include "rs_fontlist.h"
#include "rs_patternlist.h"
#include "rs_settings.h"
#include "rs_system.h"
//#include "qg_dlginitial.h"
#include "rs_graphic.h"
#include "rs_painterqt.h"
#include "rs_staticgraphicview.h"
#include "rs.h"

#include "lc_application.h"
//#include "qc_applicationwindow.h"
#include "rs_debug.h"

RS_Graphic* slotFileOpen(const QString& fileName, RS2::FormatType type) {

  RS_Graphic* doc = new RS_Graphic();

     doc->newDoc();

                // cosmetics..
                // RVT_PORT qApp->processEvents(1000);
       //qApp->processEvents(QEventLoop::AllEvents, 1000);

     bool ret = doc->open(fileName, type);

        if (!ret) {
return nullptr;
        }

    RS_DEBUG->print("QC_MDIWindow::slotFileOpen: OK");

    return doc;
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
    QSize size,
    QSize borders,
    bool black,
    bool bw) {

    QApplication::setOverrideCursor( QCursor(Qt::WaitCursor) );

    bool ret = false;
    // set vars for normal pictures and vectors (svg)
    QPixmap* picture = new QPixmap(size);
    picture->fill(Qt::transparent);

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

    // black background:
    if (black) {
		//painter.setBackground(Qt::black);
    } else {
		painter.setBackground(Qt::white);
    }

    // black/white:
    if (bw) {
        painter.setDrawingMode(RS2::ModeBW);
    }

    //painter.eraseRect(0,0, size.width(), size.height());

	RS_StaticGraphicView gv(size.width(), size.height(), &painter, &borders);
    if (black) {
		//gv.setBackground(Qt::black);
    } else {
		gv.setBackground(Qt::white);
    }
    gv.setContainer(graphic);
    gv.zoomAuto(false);
	gv.drawEntity(&painter, gv.getContainer());

    // end the picture output
    if(format.toLower() != "svg")
    {
        // RVT_PORT QImageIO iio;
        QImageWriter iio;
        QImage img = picture->toImage();
        // RVT_PORT iio.setImage(img);
        iio.setFileName(name);
        iio.setFormat(format.toLatin1());
        // RVT_PORT if (iio.write()) {
        if (iio.write(img)) {
            ret = true;
        }
//        QString error=iio.errorString();
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

    QFileInfo prgInfo( QFile::decodeName(argv[0]) );
    QString prgDir(prgInfo.absolutePath());
    RS_SYSTEM->init(app.applicationName(), app.applicationVersion(), XSTR(QC_APPDIR), prgDir);
    RS_FONTLIST->init();

    RS_Graphic* doc = slotFileOpen("/work/160+160_t3.dxf",  RS2::FormatUnknown);
    QSize size(1600,1200);
    QSize borders(0, 0);

const RS_Vector& sz = doc->getSize();
double ratio = std::min(1600 / sz.x, 1200 / sz.y);

int w = (int)lrint(sz.x * ratio);
int h = (int)lrint(sz.y * ratio);

slotFileExport(
    doc,
    "/work/test.png",
    "png",
    QSize(w, h),
    QSize(0, 0),
    true,
    false);

    app.processEvents(QEventLoop::AllEvents, 1000);
return 0;
}
