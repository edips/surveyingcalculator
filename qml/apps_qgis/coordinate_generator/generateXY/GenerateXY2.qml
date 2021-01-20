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
import "../../"
import "generateXY.js" as JS
import "../../../components/common/script.js" as Utils


FluidControls.Page{
    title:qsTr("Generate XY from a Line")
    appBar.maxActionCount: 2
    id:generate_xycalc
    Settings{
        id:generate_xyancesetting
        property alias generate_xyanceChecked2: generate_xycalc.generate_xy_count
    }
    Loader{
        id: generate_xy_loader
        source: "GenerateXY.qml"
        anchors.fill: parent
    }
    property int generate_xy_count: 0
    property int generate_xy_count2: 0
    actions: [
        /*FluidControls.Action {
          id:generate_xy_action
            onTriggered:{
                generate_xy_count++
                JS.generate_xy_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.generate_xy_icon())
            toolTip: qsTr("Favourite")
        }
        ,
        FluidControls.Action {
          id:generate_xy_action2
              onTriggered:{
                  generate_xy_count2++
                  generate_xy_loader.source=JS.generate_xy_help()
              }

            icon.source: FluidControls.Utils.iconUrl(JS.generate_xy_helpicon())
            toolTip: qsTr("Help")
        }*/
    ]
}
