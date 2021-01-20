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
    title: "Horizontal Curve"

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
            height: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/karayolu.png"
        }
    }
    STextHelp{
      stext:qsTr("
<b>α :</b> Defection Angle<br>
<br><b>R :</b> Radius<br>
<br><b>T :</b> Tangent Length<br>
<br><b>L :</b> Curve Length<br>
<br><b>BS :</b> External Distance<br>

<br><b>Formula:</b><br>
")

    }
    Rectangle{
        anchors.left: parent.left
        height:sins2d.height
        width:sins2d.width
        color: "transparent"
        Image {
            id:sins2d
            height: 35
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/road/road_t.png"
        }
    }
    Rectangle{
        anchors.left: parent.left
        height:sinsd.height
        width:sinsd.width
        color: "transparent"
        Image {
            id:sinsd
            height: 45
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/road/road_bs.png"
        }
    }
    STextHelp{
            stext:qsTr("
If angle unit is in degree:
")

    }
    Rectangle{
        anchors.left: parent.left
        height:sin_g.height
        width:sin_g.width
        color: "transparent"
        Image {
            id:sin_g
            height: 55
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/road/road_T_deg.png"
        }
    }
    STextHelp{
            stext:qsTr("
If angle unit is in grad:
")
    }
    Rectangle{
        anchors.left: parent.left
        height:sin2_img.height
        width:sin2_img.width
        color: "transparent"
        Image {
            id:sin2_img
            height: 55
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/road/road_T_gon.png"
        }
    }

}
    }
}
