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
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 5
    width: parent.width
    anchors.top:parent.top
    anchors.topMargin    : 15
    anchors.bottomMargin : 5
    anchors.leftMargin :5
    anchors.rightMargin  : 5

    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: helpl.height
        width: helpl.width
        Label{
            id:helpl
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            text:qsTr("
This app is for finding the area and perimeter of any polygon when the coordinates of its vertices are known. It also displays the shape of area with distance, angle and point numbers.
This app calculates area from X,Y coordinates.
The unit of input coordinates is in meter. Latitude and longitude coordinates shouldn't be used for input.<br>
<br><br>

To calculate the area:
<br>* Number the vertices in order, it can be clockwise or counter-clockwise.
")

            //font.bold: true
        }
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
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: hefddf.height
        width: hefddf.width
        Label{
            id:hefddf
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("
<br> Write the coordinates of area in the text editor respectively. Seperator for coordinate pairs must be space or comma(,) like the figures below:
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
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

    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: sd4.height
        width: sd4.width
        Column{
            Label{
                id:sd4
                font.pixelSize:17
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Label.RichText

                text:qsTr("
<br> Press calculate button. You can choose area or perimeter units.
")
                wrapMode: Label.WordWrap
                width: optionsColumn.width-30
                //font.bold: true
            }
        }
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

    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: sd5.height
        width: sd5.width
        Column{
            Label{
                id:sd5
                font.pixelSize:17
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Label.RichText

                text:qsTr("
<br> You can turn on or turn off displaying options for the shape of the area from right menu with <b>Display Angle, Display Distance, Display Point Name</b>.<br>
")
                wrapMode: Label.WordWrap
                width: optionsColumn.width-30
                //font.bold: true
            }
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        height:areaimg2.height
        width:areaimg2.width
        color: "transparent"
        Image {
            id:ares
            width: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/area/display_options.png"
        }
    }
}
    }
}
