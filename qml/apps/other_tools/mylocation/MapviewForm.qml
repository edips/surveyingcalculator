import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtSensors 5.12
import Qt.labs.settings 1.1
import QtGraphicalEffects 1.0
import Fluid.Controls 1.0 as FluidControls
import "../../../components/common/script.js" as Script
import "../../other_tools/libs/proj4.js" as Proj4js
import "../../../components/common"
import "components"

Item {
    property var map;
    property var currentIndex_osm: 0;
    property var currentIndex_here: 0;
    property var currentIndex_esri: 0;
    property var checkedRadio: true
    property int count_full: 0;
    property var counter_settings: 0;
    property var mylist: mapModel
    property alias osm_btn_checked: osm_btn.checked
    property bool here_btn_checked: here_btn.checked
    property bool esri_btn_checked: esri_btn.checked
    property alias mapComponent: mapComponent
    property alias selectmap: selectmap
    property alias rectMap: rectMap
    property string selectedMapType
    signal recreateMap(string mapType)

    id: mapview

    // Settings
    Settings{
        id:mycombo
        property alias mapstyle1: mapview.currentIndex_osm
        property alias yuppiii: mapview.currentIndex_here
        property alias mapstyle3: mapview.currentIndex_esri
        property alias osmBtn: osm_btn.checked
        property alias hereBtn:here_btn.checked
        property alias esriBtn:esri_btn.checked
        property alias app_initializer: mapview.counter_settings
        property alias radiochecked: mapview.checkedRadio
    }
    // State for full screen and normal screen map
    states:[
        State {
            name: "normal"
            PropertyChanges{
                target: rectMap
                height: mapview.height/2
                width: mapview.width
            }
        },
        State{
            name: "full"
            PropertyChanges{
                target: rectMap
                height: mapview.height
                width: mapview.width
            }
        }
    ]
    state: "normal"

    // new added ****************************************************
    property int rotation: 0;
    /*
    // Calibration level of a Compass
    function calib_status(reading){
        if (!reading)
            return qsTr("Compass is not available");
        if (reading.calibrationLevel < 1.0 / 3)
            return qsTr("Low calibration level");
        if (reading.calibrationLevel < 1.0 / 2)
            return qsTr("Medium calibration level");
        if (reading.calibrationLevel < 1.0)
            return qsTr("High calibration level");
        return qsTr("Compass is calibrated");
    }*/
    function normAngle(angle) {
            return (angle + 360) % 360;
        }

    // todo: enable timer and compass when compass azimuth is active
    Timer {
        interval: 300; running: mapssetting.compass_enabled; repeat: true
        onTriggered: compass_txt.text = normAngle(parseInt(rotation)) + " °"
    }
    Compass {
        id: compass
        active: mapssetting.compass_enabled
        skipDuplicates: true
        onReadingChanged: {
            //calib_level.text = calib_status(reading)
            mapview.rotation = (reading.azimuth).toFixed(2)
        }
    }
    // new added ****************************************************

    // Position Source for current location
    PositionSource {
        id: src
        updateInterval: 1000
        active: true
        onPositionChanged: {
            var currentPosition = src.position.coordinate
            coord_capture2(currentPosition, enlem, boylam, dilimno, mgrs, northing, easting)
        }
    }
    // Map component is filling rectMap
    Rectangle{
        id:rectMap
        width:parent.width
        height: parent.height/2
        color: "transparent"
    }
    // Map component
    Component {
        id: mapComponent
        MapComponent{
            id: mymap
            width:rectMap.width
            height: rectMap.height
            anchors.horizontalCenter: parent.horizontalCenter
            activeMapType: supportedMapTypes[selectmap.currentIndex]
            // Compass Image
            Image {
                visible: mapssetting.compass_enabled
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.leftMargin: 5
                id: arrowImage
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/images/compass.png"
                rotation: -mapview.rotation
                height: 70;
                opacity: 0.5
                Behavior on rotation { RotationAnimation { properties: "rotation"; direction: RotationAnimation.Shortest; duration: 500 }}
            }
            // full screen and normal screen map
            RoundBtn{
                z:1
                id:gps
                background_color: "#80d9d9d9"
                anchors{
                    right: parent.right
                    top:parent.top
                    margins: 10
                }
                onClicked: {
                        count_full++
                        mapview.state = mapview.state === "full" ? "normal" : "full";
                    }
                icon.source:{
                    if (count_full %2 === 0){
                        return "qrc:/assets/icons/material/navigation/fullscreen.svg"
                    }
                    else if(count_full %2 === 1){
                        return "qrc:/assets/icons/material/navigation/fullscreen_exit.svg"
                    }
                }
                icon.height: 40
                icon.width: 40
            }
            // CoordinatesCaptured signal
            onCoordinatesCaptured:{
                coordCaptureDialog.text = coordCapture(latitude, longitude)
            }
            // ErrorChanged signal to show error string
            onErrorChanged: {
                if (map.error !== Map.NoError) {
                    coordCaptureDialog.text = map.errorString;
                }
            }
            // ShowMainMenu signal gets coordinate from touched place of the map and it displays coordinates on dialog
            onShowMainMenu: show(coordinate, mousex, mousey, mapPopupMenu)
        }
    }
    // Get Coordinates Menu
    MapPopupMenu {
        id: mapPopupMenu
        onItemClicked: {
            coordCaptureDialog.open()
            switch (item) {
            case "getCoordinate":
                // Using coordinatesCaptured signal to get coordinates and display on dialog
                map.coordinatesCaptured(coordinate.latitude, coordinate.longitude)
                break
            default:
                console.log("Unsupported operation")
            }
        }
    }
    // Get Coordinates Dialog
    AlertDialog {
        id: coordCaptureDialog
        title: qsTr("Coordinates")
    }
    // Flickable form
    SFlickable {
        id:optionsPage
        height: 400
        anchors.top: rectMap.bottom
        contentHeight: Math.max(mapColumn.implicitHeight + 20, height)
        // Main Form column
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            id:mapColumn
            width: mapview.width
            spacing: 20
            anchors.fill : parent
            anchors.topMargin    : 10
            anchors.bottomMargin : 10
            anchors.leftMargin :10
            anchors.rightMargin  : 10
            // Northing, Easting, Lat, Long, MGRS, UTM Zone and Accuracy
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                // Latitude and Longitude
                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    layoutDirection: Script.coord_direction_latlong()
                    // Latitude
                    Row{
                        id:latlonRow
                        spacing:1
                        Label {
                            text: qsTr("Lat: ")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id:enlem
                            anchors.margins: 1
                            width: Label.implicitWidth
                            font.bold: true
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    // Longitude
                    Row{
                        id: coordsRow
                        spacing:1
                        Label {
                            text: qsTr("Long: ")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id:boylam
                            anchors.margins: 1
                            width: Label.implicitWidth
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            font.pixelSize: 14
                        }
                    }
                }
                // Northing and Easting
                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    layoutDirection: Script.coord_display()
                    // Northing
                    Row{
                        spacing:1
                        Label {
                            text: qsTr("Northing: ")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id:northing
                            anchors.margins: 1
                            width: Label.implicitWidth
                            font.bold: true
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    // Easting
                    Row{
                        spacing:1
                        Label {
                            text: qsTr("Easting: ")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id:easting
                            anchors.margins: 1
                            width: Label.implicitWidth
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            font.pixelSize: 14
                        }
                    }
                }
                // MGRS Coordinate
                Row{
                    spacing: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: mapssetting.mgrs_enabled
                    Row{
                        spacing:1
                        Label {
                            text: qsTr("MGRS: ")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id:mgrs
                            anchors.margins: 1
                            // IMPORTANT! width is changing dynamically with Label's implicitWidth
                            width: Label.implicitWidth
                            font.bold: true
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                 }
                // Accuracy and UTM Zone
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    // Accuracy
                    Row{
                        spacing:1
                        Label {
                            text: qsTr("Accuracy:")
                            font.pixelSize: 12
                            font.italic: true
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id: acrc
                            text: (src.position.horizontalAccuracy).toFixed(2) + " m"
                            font.italic: true
                            font.bold: true
                            font.pixelSize: 14
                        }
                    }
                    // UTM Zone
                    Row{
                        spacing:1
                        Label {
                            text: qsTr("UTM Zone: ")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label{
                            id:dilimno
                            anchors.margins: 1
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            font.pixelSize: 14
                        }
                    }
                }
                // new added ****************************************************
                // Compass azimuth
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 7
                    visible: mapssetting.compass_enabled
                    Row{
                        spacing: 5
                        Label {
                            text: qsTr("Compass Azimuth:")
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            id: compass_txt
                            font.bold: true
                            font.pixelSize: 14
                        }
                    }
                }
                // new added ****************************************************

            }
            // Map type and Map Provider
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Label{
                    id:typeTxt
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: "Map Type: "
                    font.pixelSize: 12
                }
                // Map type CustomComboBox
                CustomComboBox {
                    id: selectmap
                    width: 190
                    popup.modal: true
                    onCurrentIndexChanged: {
                    }
                    Component.onDestruction:{
                        if(osm_btn.checked){
                            mapview.currentIndex_osm = currentIndex
                        }else if(here_btn.checked){
                            mapview.currentIndex_here = currentIndex
                        }else if(esri_btn.checked){
                            mapview.currentIndex_esri = currentIndex
                        }
                        mapview.map.destroy()
                    }
                }
                // Map Provider Button
                FlatButton {
                    id: providerBtn
                    icon.source: "qrc:/assets/icons/material/navigation/more_vert.svg"
                    onClicked: providerMenu.open()
                    width: 35
                    // Map Provider Menu
                    Menu {
                        id: providerMenu
                        transformOrigin: Menu.TopRight
                        modal: true
                        STextTop{
                            text: "Select Map Provider"
                            font.bold: true
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            bottomPadding: 5
                            topPadding: 5
                        }
                        // OSM RadioButton
                        RadioButton {
                            id: osm_btn
                            text: "Open Street Maps"
                            onClicked: {
                                if (selectedMapType.length > 0) {
                                    var mapProvider = "osm";
                                    if (mapProvider !== selectedMapType) {
                                        provider.setMapType(mapProvider);
                                    }
                                }
                                providerMenu.close()
                            }
                            onCheckedChanged:{
                                if(!(osm_btn.checked)){
                                    mapview.currentIndex_osm = selectmap.currentIndex
                                }
                            }
                        }
                        // Here RadioButton
                        RadioButton {
                            id: here_btn
                            text: "Here"
                            onClicked:{
                                if (selectedMapType.length > 0) {
                                    var mapProvider = "here";
                                    if (mapProvider !== selectedMapType) {
                                        provider.setMapType(mapProvider);
                                    }
                                }
                                providerMenu.close()
                            }
                            onCheckedChanged:{
                                if(!(here_btn.checked)){
                                    mapview.currentIndex_here = selectmap.currentIndex
                                }
                            }
                        }
                        // Esri RadioButton
                        RadioButton {
                            id:esri_btn
                            text: "Esri"
                            onClicked:{
                                if (selectedMapType.length > 0) {
                                    var mapProvider = "esri";
                                    if (mapProvider !== selectedMapType) {
                                        provider.setMapType(mapProvider);
                                    }
                                }
                                providerMenu.close()
                            }
                            onCheckedChanged:{
                                if(!(esri_btn.checked)){
                                    mapview.currentIndex_esri = selectmap.currentIndex
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
