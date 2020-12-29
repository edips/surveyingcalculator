import QtQuick 2.11
import QtQuick.Controls 2.4
import QtLocation 5.11
import QtPositioning 5.11

Map {
    id: map
    property alias pluginHERE: pluginHERE
    property alias pluginOSM: pluginOSM
    property alias pluginESRI: pluginESRI

    property variant mapItems
    property int lastX : -1
    property int lastY : -1
    property int pressX : -1
    property int pressY : -1
    property int jitterThreshold : 30
    property variant scaleLengths: [5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000]
    property real mousex;
    property real mousey;

    property bool followme: true  //this is for "followme mode"
    property var currentPosition : src.position.coordinate

    signal coordinatesCaptured(double latitude, double longitude)
    signal showMainMenu(variant coordinate)
    signal showTargetMenu(variant coordinate)
    signal showPointMenu(variant coordinate)
    signal boxChanged(double longitudeMin, double longitudeMax, double latitudeMin, double latitudeMax)

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

    Plugin {
        id: pluginHERE
        name: "here"
        PluginParameter { name: "here.app_id"; value: "fFmCoRyhKZssyhhaYEL8" }
        PluginParameter { name: "here.token"; value: "9RNy9WvlxDuvkxSPYeA9KA" }
    }

    Plugin {
        id: pluginOSM
        name: "osm"

        //if this is activated, api key required brand appears. we had to disable it.
        // Todo: find a way to remove satellite but also remove api key required
        //PluginParameter { name: "osm.mapping.providersrepository.disabled"; value: "true"}

        //it works well with this parameters for Desktop, it doesn't work for android..
        PluginParameter { name: "osm.mapping.providersrepository.address"; value: "https://razoridunos.github.io/assets" }
        PluginParameter { name: "osm.mapping.highdpi_tiles"; value: true }
    }
    Plugin {
        id: pluginESRI
        name: "esri"
    }

    zoomLevel: 17
    center: currentPosition


    // Enable pan, flick, and pinch gestures to zoom in and out
    gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.FlickGesture | MapGestureArea.PinchGesture | MapGestureArea.TiltGesture
    gesture.flickDeceleration: 3000
    gesture.enabled: true

    focus: true
    copyrightsVisible: false


    MapQuickItem {
        id: yeahh
        sourceItem: Rectangle { width: 10; height: 10; color: "red"; border.width: 2; border.color: "blue"; smooth: true; radius: 20 }
        coordinate :src.position.coordinate
        opacity:.7
       anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
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

    Component.onCompleted: {
        mapItems = [];
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
            map.lastX = mouse.x
            map.lastY = mouse.y
            map.pressX = mouse.x
            map.pressY = mouse.y
            lastCoordinate = map.toCoordinate(Qt.point(mouse.x, mouse.y))
        }

        onPositionChanged: {
            if (mouse.button === Qt.LeftButton) {
                map.lastX = mouse.x
                map.lastY = mouse.y
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

            lastX = -1;
            lastY = -1;
        }

        onPressAndHold:{
            mousex = mouse.x
            mousey = mouse.y
            if (Math.abs(map.pressX - mouse.x ) < map.jitterThreshold
                    && Math.abs(map.pressY - mouse.y ) < map.jitterThreshold) {
                showMainMenu(lastCoordinate);
            }
        }
    }
}
