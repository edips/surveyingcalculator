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
import "line.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Line-Line Intersection")
    appBar.maxActionCount: 2
    id:linecalc
    Settings{
        id:linesetting
        property alias lineChecked2: linecalc.line_count
    }
    Loader{
            id: line_loader
            source: "LineLineIntersection.qml"
            anchors.fill: parent
    }
    LineHelp{
        id:lineHelp
        visible: false
    }
    property int line_count: 0
    property int line_count2: 0
    actions: [
        /*FluidControls.Action {
          id:line_action
            onTriggered:{
                line_count++
                JS.line_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.line_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:line_action2
              onTriggered:{
                  lineHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
