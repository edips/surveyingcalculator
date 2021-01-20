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
import "degdec.js" as JS
import "../../../components/common/script.js" as Utils
import Fluid.Core 1.0 as FluidCore

FluidControls.Page{
    title:qsTr("Degree-Decimal")
    appBar.maxActionCount: 2
    id:degcalc
    Settings{
        id:degsetting
        property alias degChecked2: degcalc.deg_count
    }
    Loader{
            id: deg_loader
            source: "Degree2decimal.qml"
            anchors.fill: parent
    }
    Deg2DecHelp{
        id: degHelp
        visible: false
    }



    property int deg_count: 0
    property int deg_count2: 0
    actions: [
        /*FluidControls.Action {
          id:fav_action_deg
            onTriggered:{
                deg_count++
                JS.deg_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.deg_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:deg_action2
           onTriggered:{
                  degHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
