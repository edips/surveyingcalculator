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
    id: mapviewer_help
    title: "Distance Help"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    STextHelp{
            stext:qsTr("
<b>2D Distance</b><br>
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sisd2.height
        width:sisd2.width
        color: "transparent"
        Image {
            id:sisd2
            height: 35
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/distance/2d.png"
        }
    }
    STextHelp{
            stext:qsTr("
<br><b>3D Distance</b><br>
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sisd.height
        width:sisd.width
        color: "transparent"
        Image {
            id:sisd
            height: 35
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/distance/3d.png"
        }
    }
    STextHelp{
            stext:qsTr("
<br><b>Distance between Lat/Lon</b><br>
   <b>(Great Circle Distance)</b>
")
    }
    STextHelp{
            stext:qsTr("
This uses the ‘haversine’ formula to calculate the great-circle distance between two points. Radius unit is meter but you can change the value to any units.<br><br>
<b>φ :</b> Latitude<br>
<b>λ :</b> Longitude<br>
<b>R :</b> Earth Radius (mean radius = 6371m )<br>
<b>d :</b> Distance<br>
")
    }
    Flickable {
        anchors.left: parent.left
        width: parent.width; height: sins2ds.height
        contentWidth: sins2ds.width+20; contentHeight: sins2ds.height
        Image {
            id:sins2ds
            width:380
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/dist.png"
        }
    }

}
    }
}
