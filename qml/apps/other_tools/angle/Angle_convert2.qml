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
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../../help"
import "angle.js" as JS
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("Angle Converter")
    topPadding: 15
    appBar.maxActionCount: 2
    id:angconv
    Settings{
        id:mysetting4
        property alias ekranAngle: angconv.countt2
    }

    Loader{
            id: loader5
            source: "Angle_convert.qml"
            anchors.fill: parent
    }
    AngleHelp{
        id:anHelp
        visible: false
    }

    property int countt22: 0
    property int countt2: 0
    actions: [
        /*FluidControls.Action {
          id:favourite2
            onTriggered:{
                countt2++
                JS.fav_angle()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.angle_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:myaction2
              onTriggered:{
                  anHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
