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
import QtQuick.Controls 2.3
import Qt.labs.settings 1.1
import "../../components/common"

Rectangle {
    property int currentIndex: ucd.currentIndex
    Settings {
        id: comboSettings
        property alias combo_index: ucd.currentIndex
    }

    id:comborect
    width: parent.width
    height: ucd.height
    color:"transparent"
    //anchors.horizontalCenter: parent.horizontalCenter
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        CustomComboBox {
            id: ucd
            currentIndex: 0
            width: comborect.width - 20
            height: 38
            model: ListModel {
                id: model
                ListElement { text: "Measure Distance, Bearing" }
                ListElement { text: "Sloped Distance" }
                ListElement { text: "Distance, Azimuth from Lat/Long" }
                ListElement { text: "XY from Distance, Bearing" }
                ListElement { text: "Lat,Long from Distance, Azimuth" }
                ListElement { text: "Bearing Calculation" }
                ListElement { text: "Measure Angle from 3 Points" }
            }
            onAccepted: {
                id:maccepted
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }
    }
}
