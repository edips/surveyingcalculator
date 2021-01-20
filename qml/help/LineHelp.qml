/***************************************************************************
  Copyright            : (C) 2021 by Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Line - Line Intersection"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g2.height
        width:sin_g2.width
        color: "transparent"
        Image {
            id:sin_g2
            width: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/line2line.png"
        }
    }
    STextHelp{
            stext:qsTr("
The intersection P point (NP, EP);")
    }

    Flickable {
        anchors.left: parent.left
        width: parent.width; height: sins2d.height
        contentWidth: sins2d.width+20; contentHeight: sins2d.height
        Image {
            id:sins2d
            height: 64
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/line/np.png"
        }
    }

    Flickable {
        anchors.left: parent.left
        width: parent.width; height: sinsd.height
        contentWidth: sinsd.width+20; contentHeight: sinsd.height
        Image {
            id:sinsd
            height: 64
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/line/ep.png"
        }
    }
//-----------------------------------------------------------


}
    }
}
