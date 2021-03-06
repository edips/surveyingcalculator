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

import QtQuick 2.3
import QtQml 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3

Item {
    id: positionMarker
    property double nav_direction: 0;

    Image {
        id: direction
        source: "../images/navigation"
        fillMode: Image.PreserveAspectFit
        rotation: nav_direction
        transformOrigin: Item.Center
        sourceSize.width: 40
        sourceSize.height: 40
        smooth: true
        Behavior on rotation { RotationAnimation { properties: "rotation"; direction: RotationAnimation.Shortest; duration: 500 }}
        //x: positionKit.screenPosition.x - width/2
        //y: positionKit.screenPosition.y - height/2
    }

   ColorOverlay {
        anchors.fill: direction
        source: direction
        color: "#00cc00"
        rotation: nav_direction
        transformOrigin: Item.Center
        Behavior on rotation { RotationAnimation { properties: "rotation"; direction: RotationAnimation.Shortest; duration: 500 }}
    }
}

