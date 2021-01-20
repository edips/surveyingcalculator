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
    title: "2D Helmert Transformation"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    STextHelp{
            stext:qsTr("
The Helmert transformation is used, among other things, in geodesy to transform the coordinates of
the point from one coordinate system into another. Using it, it becomes possible to convert regional
surveying points into another coordinate systems such as the WGS84 UTM locations used by GPS.
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g2.height
        width:sin_g2.width
        color: "transparent"
        Image {
            id:sin_g2
            width: 270
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/helmert.png"
        }
    }
    STextHelp{
            stext:qsTr("
First system coordinates:
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sins2d.height
        width:sins2d.width
        color: "transparent"
        Image {
            id:sins2d
            height: 32
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/helmert/firstsystm.png"
        }
    }
    STextHelp{
            stext:qsTr("
Second system coordinates:
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.left: parent.left
        height:sinsd.height
        width:sinsd.width
        color: "transparent"
        Image {
            id:sinsd
            height: 40
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/helmert/secondsystem.png"
        }
    }
//-----------------------------------------------------------



    Rectangle{
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        height:kj1.height
        width:kj1.width
        color: "transparent"
        Image {
            id:kj1
            width: 150
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/helmert/h1.png"
        }
    }
    STextHelp{
            stext:qsTr("
Distance between A' and B':
")
    }
    Rectangle{
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        height:kj2.height
        width:kj2.width
        color: "transparent"
        Image {
            id:kj2
            height: 40
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/helmert/h2.png"
        }
    }
    STextHelp{
            stext:qsTr("
<b>a</b> and <b>b</b> are factors for using calculation of <b>NP</b> and <b>EP</b>:
")
    }

    Rectangle{
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        height:kj1.height
        width:kj1.width
        color: "transparent"
        Image {
            id:kj3
            width: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/helmert/h3.png"
        }
    }
    STextHelp{
            stext:qsTr("
<b>N0'</b> and <b>E0'</b> are the origin of the first system in the second system:
")
    }
    Rectangle{
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        height:kj4.height
        width:kj4.width
        color: "transparent"
        Image {
            id:kj4
            height: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:assets/images/help/helmert/h4.png"
        }
    }


}
    }
}
