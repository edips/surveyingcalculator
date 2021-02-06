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

import QtQuick 2.7
import QtGraphicalEffects 1.0
import QgsQuick 0.1 as QgsQuick
import QtSensors 5.12
import lc 1.0

Item {    
    property int rotation: 0;
    property bool nav_visible: false

    property double speed_limit: 4.16 // 4.16 m/s = 15 km/h. If user's speed is over speed_limit, it will use position's direction.

    function direction( positionSrc ) {
        var dir_val;
        if( positionSrc.position.speedValid && positionSrc.position.directionValid && positionSrc.position.speed >= speed_limit ) {
            dir_val = positionSrc.position.direction
        } else {
            dir_val = crosshair.rotation
        }

        return dir_val
    }

    id: crosshair
    property real size: {
        if (__appSettings.autoCenterMapChecked){
            return 20
        }else{
            return 45
        }
    }
    Image {
        anchors.centerIn: parent
        height: crosshair.size
        width: height
        source:{
            if (__appSettings.autoCenterMapChecked){
                "qrc:/assets/icons/crosshair2.svg"
            }else{
                "qrc:/assets/icons/crosshair.svg"
            }
        }
        sourceSize.width: width
        sourceSize.height: height
        z: direction.z + 1
    }


    // todo: enable the compass when compass azimuth is active
    Compass {
        id: compass
        alwaysOn: false
        active: direction.visible //&& src.ready && src.position.speedValid !== null && src.position.speedValid && src.position.speed < 2.78
        skipDuplicates: true
        onReadingChanged: {
            //calib_level.text = calib_status(reading)
            crosshair.rotation = ( reading.azimuth ).toFixed(2)
        }
    }

    Image {
        id: direction
        visible: nav_visible
        source: "qrc:/assets/icons/material/maps/navigation.svg"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        rotation: crosshair.direction( src )
        transformOrigin: Item.Center
        sourceSize.width: 40
        sourceSize.height: 40
        smooth: true
        opacity: 0.5
        Behavior on rotation { RotationAnimation { properties: "rotation"; direction: RotationAnimation.Shortest; duration: 500 }}
    }

    ColorOverlay {
        anchors.fill: direction
        visible: nav_visible
        //visible: (positionKit.hasPosition) ? true : false
        //visible: positionKit.hasPosition && positionKit.direction >= 0
        source: direction
        color: "#009900"
        rotation: direction.rotation
        transformOrigin: Item.Center
    }
}
