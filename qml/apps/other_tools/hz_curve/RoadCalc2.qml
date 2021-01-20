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
import "roadcalc.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title: qsTr("Horizontal Curve")
    appBar.maxActionCount: 2
    id:roadcalc
    Settings{
        id:roadsetting
        property alias roadChecked2: roadcalc.road_count
    }
    Loader{
            id: road_loader
            source: "RoadCalc.qml"
            anchors.fill: parent
    }
    RoadHelp{
        id: roadHelp
        visible: false
    }

    property int road_count2: 0
    property int road_count: 0
    actions: [
        /*FluidControls.Action {
          id:road_action
            onTriggered:{
                road_count++
                JS.road_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.road_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:road_action2
              onTriggered:{
                  roadHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
