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

import QtQuick 2.12
import QtQuick.Controls 2.12
import "script.js" as Script
/*
This component is used with manuel and map input like that:
1: ____   ____ BTN
2: ____   ____ BTN
*/
Row {
    property string name;
    property alias north: x1;
    property alias east: y1;
    property alias north_txt: x1.text;
    property alias east_txt: y1.text;
    property alias mapBtn: btn
    property bool readonly : false

    // todo: edit comments
    // Coordinate Selector function opens coordinate selector dialog if the coordinate input is convenient for the coordinate system
    // if the input coordinates are XY and current project is in projected CRS, it opens the coordinate chooser dialog, else it gives error as it isn't projected crs
    // if the input coordinates are latitude and longitude and the current project CRS is in geographic, coordinate chooser dialog opens, else it gives error
    // as it isn't geographic crs
    // requirements: mapDialog: CoordinateSelect Dialog, and errDialog Error dialog ID

    anchors.horizontalCenter: parent.horizontalCenter
    spacing:5
    SText {text: name + " "; }
    Row {
        spacing: 10
        Row{
            spacing: 10
            layoutDirection: Script.coord_display()
            STextField{id:y1; readOnly: readonly; placeholderText: Script.textE() + name; } // easting
            STextField{id:x1; readOnly: readonly; placeholderText: Script.textN() + name; } // northing
        }
        Button {
            id: btn
            visible: !readonly
            anchors.verticalCenter: parent.verticalCenter
            height: x1.height
            icon.source: "qrc:/assets/icons/material/maps/map.svg"
        }
    }
}
