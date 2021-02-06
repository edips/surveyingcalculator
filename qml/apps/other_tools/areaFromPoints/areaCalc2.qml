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
    title:qsTr("Area from XY")
    appBar.maxActionCount: 2
    id:areacalccalc
    Settings{
        id:areacalcancesetting
        property alias pointName: point_menu.checked
        property alias distanceTxt: dist_menu.checked
        property alias angleTxt: angle_menu.checked
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

    Menu {
        id: optionsMenu
        x: parent.width - width
        y: windoww.height
        width: point_menu.implicitWidth
        transformOrigin: Menu.TopRight
        modal: true

        MenuItem {
            id: angle_menu
            text: "Display Angle"
            checkable: true
        }

        MenuItem {
            id: dist_menu
            text: "Display Distance"
            checkable: true
        }

        MenuItem {
            id: point_menu
            text: "Display Point Name"
            checkable: true
            checked: true
        }
    }

    actions: [
        FluidControls.Action {
            id:areacalc_action2
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
            onTriggered: areaHelp.open()
        },
        FluidControls.Action {
            id: menu2
            toolTip: qsTr("Menu")
            icon.source: "qrc:/assets/icons/material/navigation/more_vert.svg"
            onTriggered: optionsMenu.open()
        }
    ]
}
