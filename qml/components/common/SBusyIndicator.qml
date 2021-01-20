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
import QtQuick.Controls 2.2

Item {
    id: busyIndicator
    anchors.centerIn: parent
    width: 100
    height: 100
    property alias busy: busy_ind;
    // busy indicator for loading project list
    BusyIndicator {
        id: busy_ind
        opacity: 0
        anchors.centerIn: parent
        width: 45
        height: 45
        running: false
        visible: running
        z: openProjectPanel.z + 1
        OpacityAnimator on opacity {
            id: opac_anime
            target: busy_ind;
            running: busy_ind.running
            from: 0;
            to: 0.7;
            duration: 1000
        }
    }
}
