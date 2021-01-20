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
import Fluid.Core 1.0 as FluidCore
import Qt.labs.settings 1.1
import "../../"
import "maps.js" as JS

/*
TODO
- Grid designator will be in menu settins as checkable
- remove windoww.decimal or any related thing, use __appSettings instead
*/

FluidControls.Page{
    title: "UTM Map"
    appBar.maxActionCount: 1
    id:mapcalc
    /*onGoBack: {
    }*/
    Settings{
        id:mapssetting
        //property alias mapsChecked2: mapcalc.map_count
        property alias mgrs_enabled: mgrs_action.checked
        property alias compass_enabled: compass_action.checked
    }
    Mapview{
        id: map_loader
        //source: "Mapview.qml"
        anchors.fill: parent
    }
    property int map_count: 0
    property int map_count2: 0

    // Menu for UTM Map
    Menu {
        id: optionsMenu
        x: parent.width - width
        y: windoww.height
        width: mgrs_action.implicitWidth
        transformOrigin: Menu.TopRight
        modal: true
        // MGRS Coordinates
        MenuItem {
            id:mgrs_action
            text: "MGRS Coordinates"
            checkable: true
            checked: true
        }
        // Compass
        MenuItem {
            id:compass_action
            text: "Compass"
            checkable: true
            checked: true
        }
        // Grid designator
        MenuItem {
            id: designator
            text: "Grid Zone Code"
            checkable: true
            checked: __appSettings.gridZone
            onCheckedChanged: __appSettings.gridZone = checked
        }
    }


    actions: [
        /*FluidControls.Action {
          id:map_action
            onTriggered:{
                map_count++
                JS.map_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.map_icon())
            toolTip: qsTr("Favourite")
        },
        FluidControls.Action {
            id:mgrs_action
            text: qsTr("MGRS")
            //icon.source: FluidControls.Utils.iconUrl(JS.map_helpicon())
            toolTip: qsTr("MGRS")
            checkable: true
        },
        FluidControls.Action {
            id: compass_action
            text: qsTr("Compass")
            //icon.source: FluidControls.Utils.iconUrl(JS.map_helpicon())
            toolTip: qsTr("Compass")
            checkable: true
        },*/
        // UTM Map Menu
        FluidControls.Action {
            icon.source: "qrc:/assets/icons/material/navigation/more_vert.svg"
            toolTip: qsTr("Menu")
            onTriggered: optionsMenu.open()
        }
    ]
}
