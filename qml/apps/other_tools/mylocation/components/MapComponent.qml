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
import QtLocation 5.11
import QtPositioning 5.11
import QtSensors 5.12
import QtGraphicalEffects 1.0

Map {
    id: map
    property double speed_limit: 4.16
    // For marker icon
    property int rotation: 0;
    // Map provider's plugin
    property alias pluginHERE: pluginHERE
    property alias pluginOSM: pluginOSM
    property alias pluginESRI: pluginESRI

    // For opening the menu on the map. When user presses and holds on map, menu will be open from pressX and pressY parameters
    property int pressX : -1
    property int pressY : -1

    // It is a tolerance of moving touch area, like it has limit of 30 pixel on the map
    property int jitterThreshold : 30
    property variant scaleLengths: [5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000]
    property real mousex;
    property real mousey;

    property bool followme: mapcalc.followme



    signal coordinatesCaptured(double latitude, double longitude)
    signal showMainMenu(variant coordinate)
    signal showTargetMenu(variant coordinate)
    signal showPointMenu(variant coordinate)
    signal boxChanged(double longitudeMin, double longitudeMax, double latitudeMin, double latitudeMax)

    signal targetChanged(string tgtName)
    property string targetName;

    function formatDistance(meters)
    {
        var dist = Math.round(meters)
        if (dist > 1000 ){
            if (dist > 100000){
                dist = Math.round(dist / 1000)
            }
            else{
                dist = Math.round(dist / 100)
                dist = dist / 10
            }
            dist = qsTr("%1 km").arg(dist)
        }
        else{
            dist = qsTr("%1 m").arg(dist)
        }
        return dist
    }

    function calculateScale() {
        var coord1, coord2, dist, text, f
        f = 0
        coord1 = map.toCoordinate(Qt.point(0, scale.y))
        coord2 = map.toCoordinate(Qt.point(0 + scaleImage.sourceSize.width, scale.y))
        dist = Math.round(coord1.distanceTo(coord2))

        if (dist === 0) {
            // not visible
        } else {
            for (var i = 0; i < scaleLengths.length - 1; i++) {
                if (dist < (scaleLengths[i] + scaleLengths[i + 1]) / 2 ) {
                    f = scaleLengths[i] / dist
                    dist = scaleLengths[i]
                    break;
                }
            }
            if (f === 0) {
                f = dist / scaleLengths[i]
                dist = scaleLengths[i]
            }
        }

        text = formatDistance(dist)
        scaleImage.width = (scaleImage.sourceSize.width * f) - 2 * scaleImageLeft.sourceSize.width
        scaleText.text = text

        coord1 = map.toCoordinate(Qt.point(0, 0))
        coord2 = map.toCoordinate(Qt.point(map.width, map.height))
        boxChanged(coord1.longitude, coord2.longitude, coord2.latitude, coord1.latitude)
    }

    // Marker direction
    function direction( positionSrc ) {
        var dir_val;
        if( positionSrc.position.speedValid && positionSrc.position.directionValid && positionSrc.position.speed >= speed_limit ) {
            dir_val = positionSrc.position.direction
        } else {
            dir_val = map.rotation
        }
        return dir_val
    }



//////// Go to Coordinates part **********************************************************************************************************

    property int heading: 90
    property int kitHdg: 90
    property int orbitRadius: 0
    property double xPos: 0
    property double yPos: 0
    property int tgtCount: 0
    property variant targetList: []
    property var kitList: []
    property int kitStartNr: 1234
    property int curTarget: -1

    // Method to set current target to be followed by kit
    function changeTarget(tgt) {
        targetList[tgt - 1].makeVisible = true

        // for first target selection
        if(curTarget !== -1) {
            targetList[curTarget].makeVisible = true
        }
        curTarget = tgt - 1
    }

    function midPoint(coord1, coord2) {

        var delta = coord2.longitude - coord1.longitude
        delta = delta * Math.PI / 180.0

        var rLat1 = coord1.latitude * Math.PI / 180.0
        var rLat2 = coord2.latitude * Math.PI / 180.0
        var rLon1 = coord1.longitude * Math.PI / 180.0

        var Bx = Math.cos(rLat2) * Math.cos(delta)
        var By = Math.cos(rLat2) * Math.sin(delta)
        var lat3 = Math.atan2(Math.sin(rLat1) + Math.sin(rLat2),
                              Math.sqrt( (Math.cos(rLat1) + Bx) * (Math.cos(rLat1) + Bx) + By * By))
        var lon3 = rLon1 + Math.atan2(By, Math.cos(rLat1) + Bx)

        return QtPositioning.coordinate(lat3 * 180.0 / Math.PI, lon3 * 180.0 / Math.PI)
    }

    function addNewTarget() {

        // tgtCount is 0 be default
        tgtCount += 1;

        var comp;
        comp = Qt.createComponent("qrc:///qml/apps/other_tools/mylocation/components/target.qml")

        if( comp.status !== Component.Ready )
        {
            if( comp.status === Component.Error )
                console.debug("Error:"+ comp.errorString() );
            return; // or maybe throw
        }

        // Create object dynamically
        var target = comp.createObject( window,
                                       { text: tgtCount,
                                           coordinate: QtPositioning.coordinate( map.toCoordinate(Qt.point(xPos, yPos)).latitude,
                                                                                map.toCoordinate(Qt.point(xPos, yPos)).longitude ) } )
        targetList.push( target )

        map.targetName = target.text
        target.targetChanged.connect( changeTarget )
        map.targetChanged.connect( changeTarget )
        map.addMapItemGroup( target )
    }

    function addTargetFromCoord( lat, lon ) {

        // tgtCount is 0 be default
        tgtCount += 1;

        console.log("we are in go to coordinate function")

        var comp;
        comp = Qt.createComponent("qrc:///qml/apps/other_tools/mylocation/components/target.qml")

        if( comp.status !== Component.Ready )
        {
            if( comp.status === Component.Error )
                console.debug("Error:"+ comp.errorString() );
            return; // or maybe throw
        }

        // Create object dynamically
        var target = comp.createObject( window,
                                       { text: tgtCount,
                                           coordinate: QtPositioning.coordinate( lat, lon ) } )
        targetList.push( target )

        map.targetName = target.text
        target.targetChanged.connect( changeTarget )
        map.targetChanged.connect( changeTarget )
        map.addMapItemGroup( target )
    }


    function computeNextPosition() {
        var lat = kit1234.coordinate.latitude;
        var lon = kit1234.coordinate.longitude;

        var earthRadius = 6371 * 1000; // In meters
        var speed = 10; // m/s
        var time = 1; // second
        var distance = speed * time;
        var d = distance / earthRadius;
        var rLat = lat * Math.PI / 180.0;
        var rLon = lon * Math.PI / 180.0;

        var tgtCoordinate;
        var distToTarget

        if( targetList.length > 0 && curTarget != -1) {
            tgtCoordinate = targetList[curTarget].coordinate
            distToTarget = kit1234.coordinate.distanceTo( tgtCoordinate )
            var dst = ''
            if( distToTarget > 1000 ) {
                dst = (distToTarget / 1000)
                dst = dst.toFixed(2) + ' km'
            }
            else if ( distToTarget < 1000 ) {
                dst = distToTarget.toFixed(0) + ' m'
            }
            else {
                dst = ''
            }

            distText.text = dst
            distText.coordinate = midPoint( kit1234.coordinate, tgtCoordinate )
            //console.log( "DTT: ", distToTarget, distText.text )

            if( distToTarget <= 10 ) {
                // look for the next target
                if(targetList.length - 1 >= curTarget) {
                    targetList[curTarget].makeVisible = true
                    targetList[curTarget].color = "orange"
                    if( curTarget < targetList.length - 1)
                        curTarget += 1
                }
            }
        }
        else {
            orbitRadius += 1
            if(orbitRadius >= 5) {
                orbitRadius = 0;
            }
        }

        var path = kitToTarget.path;

        if(targetList.length > 0 && curTarget != -1) {
            path[1].latitude = tgtCoordinate.latitude;
            path[1].longitude = tgtCoordinate.longitude;
            path[0].latitude = kit1234.coordinate.latitude;
            path[0].longitude = kit1234.coordinate.longitude;
        }

        kitToTarget.path = path;
    }

    function setTimeout(callback, delay) {
        if(timer.running) {
            console.error("Nested call not supported");
            return;
        }
        timer.callback = callback;
        timer.interval = delay + 1;
        timer.running = true;
        timer.repeat = true;
    }

    Timer {
        id: timer
        running:  false
        repeat: false
        property var callback
        onTriggered: callback()
    }

    Plugin {
        id: pluginHERE
        name: "here"
        PluginParameter { name: "here.app_id"; value: "fdsf546sdfsd4f65sdfsd" }
        PluginParameter { name: "here.token"; value: "we53r4w6fds5f3we1s5f3s" }
    }

    Plugin {
        id: pluginOSM
        name: "osm"
        PluginParameter { name: "osm.mapping.providersrepos"; value: "https://tiktonio.com/assets" }
        PluginParameter { name: "osm.mapping.highdpi_tiles"; value: true }
    }
    Plugin {
        id: pluginESRI
        name: "esri"
    }

    zoomLevel: 17
    center: mapcalc.mapCenter


    // Enable pan, flick, and pinch gestures to zoom in and out
    gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.FlickGesture | MapGestureArea.PinchGesture | MapGestureArea.TiltGesture
    gesture.flickDeceleration: 3000
    gesture.enabled: true

    focus: true
    copyrightsVisible: false

    Compass {
        id: compass
        alwaysOn: false
        active: direction.visible //&& src.ready && src.position.speedValid !== null && src.position.speedValid && src.position.speed < 2.78
        skipDuplicates: true
        onReadingChanged: {
            //calib_level.text = calib_status(reading)
            map.rotation = ( reading.azimuth ).toFixed(2)
        }
    }

    MapQuickItem {
        id: kit1234
        //sourceItem: Rectangle { width: 10; height: 10; color: "red"; border.width: 2; border.color: "blue"; smooth: true; radius: 20 }
        coordinate :src.position.coordinate
        opacity:.7
        anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)

        sourceItem: Rectangle {
            width: 40
            height: width
            color: "transparent"
            Image {
                visible: mapcalc.followme
                anchors.centerIn: parent
                height: 20
                width: height
                source: "qrc:/assets/icons/crosshair2.svg"
                sourceSize.width: width
                sourceSize.height: height
                z: direction.z + 1
            }
            Image {
                id: direction
                source: "qrc:/assets/icons/material/maps/navigation.svg"
                sourceSize.width: 40
                sourceSize.height: 40
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                rotation: map.direction( src )
                transformOrigin: Item.Center
                Behavior on rotation { RotationAnimation { properties: "rotation"; direction: RotationAnimation.Shortest; duration: 500 }}
            }
            ColorOverlay {
                anchors.fill: direction
                source: direction
                color: "#009900"
                rotation: direction.rotation
                transformOrigin: Item.Center
            }
        }
    }

    MapPolyline {
        id: kitToTarget
        line.width: 1
        line.color: 'blue'
        antialiasing: true
        z: map.z + 1
        path: [
            { latitude: 0, longitude: 0 },
            { latitude: 0, longitude: 0 }
        ]
    }
    MapQuickItem {
        id: distText
        property string text: ''
        z: map.z + 2
        sourceItem: Label {
            id: name
            text: distText.text
            font.bold: false
            font.pixelSize: 14
            color: "black"
            //                styleColor: "#ECECEC"
            //                style: Text.Outline
        }
    }

    Component.onCompleted: {
        setTimeout(computeNextPosition, 500)
    }


    onCenterChanged: {
        scaleTimer.restart()
    }

    onZoomLevelChanged: {
        scaleTimer.restart()
    }

    onWidthChanged: {
        scaleTimer.restart()
    }

    onHeightChanged: {
        scaleTimer.restart()
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Plus) {
            map.zoomLevel++;
        } else if (event.key === Qt.Key_Minus) {
            map.zoomLevel--;
        } else if (event.key === Qt.Key_Left || event.key === Qt.Key_Right ||
                   event.key === Qt.Key_Up   || event.key === Qt.Key_Down) {
            var dx = 0;
            var dy = 0;

            switch (event.key) {

            case Qt.Key_Left: dx = map.width / 4; break;
            case Qt.Key_Right: dx = -map.width / 4; break;
            case Qt.Key_Up: dy = map.height / 4; break;
            case Qt.Key_Down: dy = -map.height / 4; break;

            }

            var mapCenterPoint = Qt.point(map.width / 2.0 - dx, map.height / 2.0 - dy);
            map.center = map.toCoordinate(mapCenterPoint);
        }
    }

    Timer {
        id: scaleTimer
        interval: 100
        running: false
        repeat: false
        onTriggered: {
            map.calculateScale()
        }
    }

    Rectangle{
        height: scale.height
        width: scale.width + 10
        color: "#80d9d9d9"

        anchors.bottom: parent.bottom;
        anchors.right: parent.right
        anchors.margins: 5
        radius: 7
        Column{
            anchors.centerIn: parent
            Label {
                id: scaleText
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("%1 m").arg(0)
                font.pixelSize: 12
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    id: scaleImageLeft
                    source: "qrc:/assets/images/scale_end.png"
                }
                Image {
                    id: scaleImage
                    source: "qrc:/assets/images/scale.png"
                }
                Image {
                    id: scaleImageRight
                    source: "qrc:/assets/images/scale_end.png"
                }
            }
        }
        Rectangle {
            id: scale
            z: map.z + 3
            visible: scaleText.text !== qsTr("%1 m").arg(0)
            height: scaleText.height * 2
            width: scaleImage.width
            color: "transparent"
            anchors.centerIn: parent
            Component.onCompleted: {
                map.calculateScale();
            }
        }
    }
    MouseArea {
        id: mouseArea
        property variant lastCoordinate
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onPressed : {
            map.pressX = mouse.x
            map.pressY = mouse.y
            lastCoordinate = map.toCoordinate(Qt.point(mouse.x, mouse.y))
        }

        onPositionChanged: {
            if (mouse.button === Qt.LeftButton) {
            }
        }

        onDoubleClicked: {
            var mouseGeoPos = map.toCoordinate(Qt.point(mouse.x, mouse.y));
            var preZoomPoint = map.fromCoordinate(mouseGeoPos, false);
            if (mouse.button === Qt.LeftButton) {
                map.zoomLevel = Math.floor(map.zoomLevel + 1)
            } else if (mouse.button === Qt.RightButton) {
                map.zoomLevel = Math.floor(map.zoomLevel - 1)
            }
            var postZoomPoint = map.fromCoordinate(mouseGeoPos, false);
            var dx = postZoomPoint.x - preZoomPoint.x;
            var dy = postZoomPoint.y - preZoomPoint.y;

            var mapCenterPoint = Qt.point(map.width / 2.0 + dx, map.height / 2.0 + dy);
            map.center = map.toCoordinate(mapCenterPoint);
        }

        onPressAndHold:{
            // Go to Coordinate
            var isTargetClicked = -1
            for(var i = 0; i < targetList.length; ++i) {
                if(targetList[i].track === true) {
                    isTargetClicked = i
                    console.log("Follow target ", i+1)
                    targetList[i].track = false
                }
            }
            console.log('latitude = '+ (map.toCoordinate(Qt.point(mouse.x,mouse.y)).latitude),
                        'longitude = '+ (map.toCoordinate(Qt.point(mouse.x,mouse.y)).longitude));
            xPos = mouse.x
            yPos = mouse.y

            // Other params
            mousex = mouse.x
            mousey = mouse.y
            if ( Math.abs( map.pressX - mouse.x ) < map.jitterThreshold
                    && Math.abs( map.pressY - mouse.y ) < map.jitterThreshold ) {
                showMainMenu( lastCoordinate );
            }
        }
    }
}
