import QtQuick 2.7
import QtGraphicalEffects 1.0
import QgsQuick 0.1 as QgsQuick
import QtSensors 5.12
import lc 1.0

Item {    
    property int rotation: 0;
    property bool nav_visible: parseFloat( (src.position.horizontalAccuracy) ) < 20 && __appSettings.autoCenterMapChecked

    id: crosshair
    property real size:{
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
        active: direction.visible
        skipDuplicates: true
        onReadingChanged: {
            //calib_level.text = calib_status(reading)
            crosshair.rotation = (reading.azimuth).toFixed(2)
        }
    }

    Image {
        id: direction
        visible: nav_visible
        source: "qrc:/assets/icons/material/maps/navigation.svg"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        rotation: -crosshair.rotation
        transformOrigin: Item.Center
        sourceSize.width: 40
        sourceSize.height: 40
        smooth: true
        //visible: (positionKit.hasPosition) ? true : false
        //visible: positionKit.hasPosition && positionKit.direction >= 0
        //x: marker_x - width/2
        //y: marker_y - height/2
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
