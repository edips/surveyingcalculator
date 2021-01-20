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

import QtQuick 2.11
import QtQuick.Controls 2.4

Menu {
    property variant coordinate
    property int markersCount
    property int mapItemsCount
    signal itemClicked(string item)
    modal: true

    Action {
        text: qsTr("Get coordinate")
        onTriggered: itemClicked("getCoordinate")
    }

    function update() {
    }
}
