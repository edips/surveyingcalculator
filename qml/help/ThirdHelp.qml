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
    title: "Azimuth Calculation"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    anchors.horizontalCenter: parent.horizontalCenter
    id:optionsColumn
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang2.height
        width:ang2.width
        color: "transparent"
        Image {
            id:ang2
            width:200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/third.png"
        }
    }
    STextHelp{
            stext:qsTr("If azimuth angle <b>(AB)</b> and interior angle <b>β</b> or <b>(ABC)</b> is known azimuth angle <b>(BC)</b> can be calculated.<br><br>
<b> (BC) = (AB) + β </b><br><br>
If angle unit is degree:<br>
If 0≤(BC)180 => <b>(BC) = (BC) + 180</b> <br>
If 180≤(BC)≤360 => <b>(BC) = (BC) - 180</b> <br>
If 360≤(BC)≤540 => <b>(BC) = (BC) - 180</b> <br>
If 540≤(BC)≤720 => <b>(BC) = (BC) - 540</b> <br><br>

If angle unit is grad:<br>
If 0≤(BC)≤200 => <b>(BC) = (BC) + 200</b> <br>
If 200≤(BC)≤400 => <b>(BC) = (BC) - 200</b> <br>
If 400≤(BC)≤600 => <b>(BC) = (BC) - 200</b> <br>
If 600≤(BC)≤800 => <b>(BC) = (BC) - 600</b>
")
    }
}
    }
}
