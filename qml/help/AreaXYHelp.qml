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
    title: "Area Calculation"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    STextHelp{
            stext:qsTr("
This app is for finding the area of any polygon when the coordinates of its vertices are known.
To calculate the area:
<br>* Number the vertices in order, it can be clockwise or counter-clockwise.
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sins2d1.height
        width:sins2d1.width
        color: "transparent"
        Image {
            id:sins2d1
            width: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/area/area1.png"
        }
    }
    STextHelp{
            stext:qsTr("
<br> Write the coordinates of area in the text editor respectively. Seperator for coordinate pairs must be space or comma(,) like the figures below:
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sins2d.height
        width:sins2d.width
        color: "transparent"
        Image {
            id:sins2d
            width: 270
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/area/area2_space.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:areaimg1.height
        width:areaimg1.width
        color: "transparent"
        Image {
            id:areaimg1
            width: 270
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/area/area3_comma.png"
        }
    }

    STextHelp{
            stext:qsTr("
<br> Press calculate button. You can choose area units as square meter(m²), square kilometer(km²), square mile(mi²),
 square yard(yd²), acre, square foot(ft²), or hectare(ha).
")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:areaimg2.height
        width:areaimg2.width
        color: "transparent"
        Image {
            id:areaimg2
            width: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/area/area4_units.png"
        }
    }


}
    }
}
