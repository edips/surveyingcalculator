/***************************************************************************
  Copyright            : (C)  Lutra Consulting
  Modified by          : Edip Ahmet Taşkın
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

    visible: __appSettings.autoCenterMapChecked

    //property QgsQuick.PositionKit positionKit

/*
    Rectangle {
        id: accuracyIndicator
        visible: withAccuracy &&
                 positionKit.hasPosition &&
                 (positionKit.accuracy > 0) &&
                 (accuracyIndicator.width > positionMarker.size / 2.0)
        x: positionKit.screenPosition.x - width/2
        y: positionKit.screenPosition.y - height/2
        width:positionKit.screenAccuracy
        height: accuracyIndicator.width
        color: "#FD9626"
        radius: width*0.5
        opacity: 0.2
    }
*/
    Image {
        id: direction
        source: "qrc:/assets/icons/material/maps/navigation.svg"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        //rotation: positionKit.direction
        transformOrigin: Item.Center
        sourceSize.width: 40
        sourceSize.height: 40
        smooth: true
        opacity: 0.5
    }
   ColorOverlay {
        anchors.fill: direction
        //visible: (positionKit.hasPosition) ? true : false
        //visible: positionKit.hasPosition && positionKit.direction >= 0
        source: direction
        color: "#009900"


        //rotation: positionKit.direction
        transformOrigin: Item.Center
    }
}

