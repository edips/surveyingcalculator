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

import QtQuick 2.10
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0 as FluidControls
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import Qt.labs.settings 1.1
import "../../components/common"
import "../../components/common/script.js" as Util

/*
* TODO: Fix the error: 80:13: QML Rectangle: Cannot anchor to an item that isn't a parent or sibling.
* Re design qml structure, make it simple
*/
// Add Point Dialog --------------------------------------------------------------------------------------
FluidControls.AlertDialog {
    property string xText: "";
    property string yText: "";
    property alias coord_row1: row1;
    property alias coord_row2: row2;

    Settings {
        id: add_point_settings
        // will be disabled after finishing testing and fixing bugs
        property alias input_northing: add_N.text
        property alias input_easting: add_E.text
    }

    id: addPoint
    title: qsTr("Add Point")
    closePolicy: Popup.CloseOnEscape // prevents the drawer closing while moving canvas
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: parent.width
    height: point_column.height + 50
    standardButtons: Dialog.Ok | Dialog.Cancel
    Rectangle {
        height: 200
        width: 200
        color: "transparent"
        id: point_column
        // Coordinate Rectangle
        Rectangle {
            id: mainrect
            height: 100
            width: 200
            color: "transparent"

            Rectangle {
                id:row1
                // setting coordinate order
                anchors.top : isLayerGeographic ? ( Util.coord_order() === "lonlat" ? row2.bottom : parent.top ) : ( Util.coord_order() === "en" ? row2.bottom : parent.top )
                width: parent.width
                height: parent.height/2
                color: "transparent"
                SText {
                    id: n_txt
                    text: xText
                    anchors.left: parent.left
                    font.bold: true
                }
                // Editing lat long or N,E
                STextField {
                    visible: !( lat_DMS.visible )
                    id: add_N
                    anchors.left: n_txt.right
                    width: 150
                    font.pixelSize: 16
                    selectByMouse: true
                }
                Row {
                    id: lat_DMS
                    spacing: 5
                    visible: Util.visibility_latlong()
                    anchors.left: n_txt.right
                    STextField{ id:latdeg; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16 }
                    STextField{ id:latmin; implicitWidth: 35; placeholderText: "'";  font.pixelSize: 16 }
                    STextField{ id:latsec; implicitWidth: 100; placeholderText: "''"; font.pixelSize: 16 }
                }
            }
            // Latitude: N; Longitude: E
            Rectangle {
                id:row2
                // setting coordinate order
                anchors.top : isLayerGeographic ? ( Util.coord_order() === "lonlat" ? parent.top : row1.bottom ) : ( Util.coord_order() === "en" ? parent.top : row1.bottom )
                // Util.coord_order() === "en" || Util.coord_order() === "lonlat" ? parent.top : row1.bottom
                width: parent.width
                height: parent.height/2
                color: "transparent"
                SText {
                    id: e_txt
                    text: yText
                    anchors.left: parent.left
                    font.bold: true
                }
                // Editing lat long or N,E
                STextField {
                    visible: !( lat_DMS.visible )
                    id: add_E
                    anchors.left:e_txt.right
                    width: 150
                    font.pixelSize: 16
                    selectByMouse: true
                }
                Row {
                    spacing: 5
                    visible: lat_DMS.visible
                    anchors.left:e_txt.right
                    STextField{ id:londeg; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; }
                    STextField{ id:lonmin; implicitWidth: 35; placeholderText: "'";  font.pixelSize: 16; }
                    STextField{ id:lonsec; implicitWidth: 100; placeholderText: "''";font.pixelSize: 16; }
                }
            }
        }
    }

    onAccepted: {
        // to initialization
        var latlong_visible = Util.visibility_latlong()
        Util.add_point()
    }
}
