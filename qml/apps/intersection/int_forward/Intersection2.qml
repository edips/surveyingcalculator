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
import "intersection.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Forward Intersection")
    appBar.maxActionCount: 2
    id:intercalc
    Settings{
        id:intersetting
        property alias interChecked2: intercalc.inter_count
    }
    Loader{
            id: inter_loader
            source: "Intersection.qml"
            anchors.fill: parent
    }
    ForwardHelp{
        id:forHelp
        visible: false
    }
    property int inter_count: 0
    property int inter_count2: 0
    actions: [
        /*FluidControls.Action {
          id:inter_action
            onTriggered:{
                inter_count++
                JS.inter_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.inter_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:inter_action2
              onTriggered:{
                  forHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
