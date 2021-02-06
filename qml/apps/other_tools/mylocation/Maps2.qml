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
import QtPositioning 5.2
import Qt.labs.settings 1.1
import "../../"
import "maps.js" as JS
import "../../../help"

/*
TODO
- Grid designator will be in menu settins as checkable
- remove windoww.decimal or any related thing, use __appSettings instead
*/

FluidControls.Page {
    property bool followme: true
    property variant mapCenter: QtPositioning.coordinate( 0.0, 0.0 )
    property bool goCoordActive: false

    id:mapcalc
    title: "UTM Map"
    appBar.maxActionCount: 3

    Settings{
        id:mapssetting
        //property alias mapsChecked2: mapcalc.map_count
        property alias mgrs_enabled: mgrs_action.checked
        property alias compass_enabled: compass_action.checked
        property alias gpsLock: mapcalc.followme
        property alias map_center_utm: mapcalc.mapCenter
        property alias map_cross_hair: crossHair.checked
    }

    // Help
    UTMMapHelp {
        id: utmHelp
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
            id: addPoint
            text: "Go to Coordinate"
            onTriggered: goCoordActive = true
            icon.source: "qrc:/assets/icons/material/maps/near_me.svg"
        }
        // MGRS Coordinates
        MenuItem {
            id:mgrs_action
            text: "Display MGRS Coordinates"
            checkable: true
            checked: true
        }
        // Compass
        MenuItem {
            id:compass_action
            text: "Display Compass"
            checkable: true
            checked: true
        }
        // Grid designator
        MenuItem {
            id: designator
            text: "Display Grid Zone Code"
            checkable: true
            checked: __appSettings.gridZone
            onCheckedChanged: __appSettings.gridZone = checked
        }
        // Grid designator
        MenuItem {
            id: crossHair
            text: "Display Crosshair"
            checkable: true
            checked: true
        }
    }


    actions: [
        FluidControls.Action {
            icon.source: "qrc:/assets/icons/material/maps/my_location.svg"
            icon.color: {
                if( mapcalc.followme ) {
                    return Universal.color( Universal.Orange )
                }
                else {
                    return __appSettings.theme === 0 ? "black" : "white"
                }
            }
            toolTip: qsTr("Enable GPS")
            onTriggered: mapcalc.followme = !mapcalc.followme
        },
        FluidControls.Action {
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
            onTriggered: utmHelp.open()
        },
        // UTM Map Menu
        FluidControls.Action {
            icon.source: "qrc:/assets/icons/material/navigation/more_vert.svg"
            toolTip: qsTr("Menu")
            onTriggered: optionsMenu.open()
        }
    ]
}
