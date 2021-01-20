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
import "../../../components/common/script.js" as Utils
import "areaCalc.js" as JS


FluidControls.Page{
    title:qsTr("Calculate Area by XY")
    appBar.maxActionCount: 2
    id:areacalccalc
    Settings{
        id:areacalcancesetting
        property alias areacalcanceChecked2: areacalccalc.areacalc_count
    }
    Loader{
            id: areacalc_loader
            source: "areaCalc.qml"
            anchors.fill: parent
    }
    AreaXYHelp{
        id: areaHelp
        visible: false
    }

    property int areacalc_count: 0
    property int areacalc_count2: 0
    actions: [
        /*FluidControls.Action {
          id:areacalc_action
            onTriggered:{
                areacalc_count++
                JS.areacalc_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.areacalc_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:areacalc_action2
              onTriggered:{
                  areaHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
