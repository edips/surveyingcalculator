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
    title: "Distance, Azimuth"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang2.height
        width:ang2.width
        color: "transparent"
        Image {
            id:ang2
            width:170
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/first.png"
        }
    }
    STextHelp{
            stext:qsTr("If coordinates of <b>A</b> and <b>B</b> points are known distance <b>|AB|</b> and azimuth angle <b>(AB)</b> can be calculated.<br><br>
Calculate <b>(AB)</b> azimuth:
")
    }
    Rectangle{
        anchors.left: parent.left
        height:angt.height
        width:angt.width
        color: "transparent"
        Image {
            id:angt
            height: 50
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/basicsurvey/second_angle.png"
        }
    }
    STextHelp{
            stext:"If angle unit is degree:
"
    }
    Rectangle{
        anchors.left: parent.left
        height:ang22.height
        width:ang22.width
        color: "transparent"
        Image {
            id:ang22
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/basicsurvey/degree.png"
        }
    }
    STextHelp{
            stext:"If angle unit is grad:
"
    }
    Rectangle{
        anchors.left: parent.left
        height:angg.height
        width:angg.width
        color: "transparent"
        Image {
            id:angg
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/basicsurvey/grad.png"
        }
    }
    STextHelp{
            stext:"Calculate <b>|AB|</b> distance:
"
    }

    Rectangle{
        anchors.left: parent.left
        height:ang.height
        width:ang.width
        color: "transparent"
        Image {
            id:ang
            height: 38
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/basicsurvey/second_dist.png"
        }
    }


}
    }
}
