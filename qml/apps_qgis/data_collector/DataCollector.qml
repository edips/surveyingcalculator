// Author: Edip AHmet Taşkın
// Copy Right Edip Ahmet Taşkın
import QtQuick 2.10
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import Fluid.Effects 1.0
import QtGraphicalEffects 1.0
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import QtQml.Models 2.2
import Qt.labs.settings 1.1
import "../../components/gis"
import "../../components/common"
import "../../components/common/script.js" as Util
import "data_collector.js" as JS
import "../../help"


FluidControls.Page{
    property color materialcolor: Universal.accent
    // counter for full screen round button for mapcanvas
    property int count_full: 0;
    // // Project's EPSG ID:
    property int epsgID;
    // Project's Ccoordinate System Name
    property string epsgName;
    // qgis file Path
    property string filePath;
    // is geographic
    property bool isGeographic;
    // screen point coordinates when clicking on map canvas
    property var screenPoint;
    // You can change UI based on the display mode
    //property bool portaitMode: Screen.desktopAvailableHeight > Screen.desktopAvailableWidth
    title:qsTr("")
    appBar.maxActionCount: 5
    anchors.fill: parent
    id:dataCollector
    visible: true

    // Edit feature function, it opens feature form to edit, save or delete the feature
    function editFeature(pair) {
        // If the feature geometry isPairValid and Toggle editing is checked, open the feature panel
        if (digitizing.isPairValid(pair)) {
            // Add the feature
            featurePanel.show_panel(pair, "Add", "form")
            console.log("Feature Panel must open")
        } else {
            console.log("Feature Panel didn't open")
            showMessage("Editing feature is not valid")
        }
    }

    /*!
    recordFeature(screenpoint X, screenpoint y)

    for recording cursor position:
    screenPoint X = mapView.mapCanvas.width/2
    screenPoint Y = mapView.mapCanvas.height/2
    In this case:
    recordFeature(mapView.mapCanvas.width/2, mapView.mapCanvas.height/2)

    for input coordinate dialog:
    recordFeature(CRS_to_screen[0], CRS_to_screen[1])
    */
    function recordFeature(screenX, screenY) {
        // Get screen point coordinates
        var screenPoint = Qt.point(screenX , screenY)
        // Convert screen points to QgsPoint in QGIS
        var recordedPoint = mapView.canvasMapSettings.screenToCoordinate(screenPoint)  // map CRS
        // Create coordinate pair for qgis
        var pair = digitizing.pointFeatureFromPoint( recordedPoint, digitizing.useGpsPoint )
        // Open feature panel to record features of this QgsPoint
        featurePanel.show_panel( pair, "Add", "form" )
    }
    // Map View component with map canvas and basic project browser
    /*
    TODO: Highlight fix: when user click on another place highlighted feature must turn off
    */
    MapView {
        id: mapView
        z: activeProjectIndex === -1 ? 10 : 0
        projectPanelEnabled: false
        anchors.fill: parent
        mapCanvas.onClicked: {
            if(count_full %2 === 0) {
                mapCanvas.forceActiveFocus()
                screenPoint = Qt.point( mouse.x, mouse.y );
                var res = identifyKit.identifyOne(screenPoint);
                if (res.valid) {
                    highlightMap.visible = true
                    highlightMap.featureLayerPair = res

                    // Add Menu Items

                    if( __surveyingUtils.featureIsPoint(res) ) {
                        featureMenu.editAttributeItem()
                        featureMenu.getCoordItem()
                    }
                    else if( __surveyingUtils.featureIsLine(res) ) {
                        featureMenu.editAttributeItem()
                        featureMenu.getCoordItem2()
                        featureMenu.lengthItem()
                    }
                    else if( __surveyingUtils.featureIsPolygon(res) ) {
                        featureMenu.editAttributeItem()
                        featureMenu.getCoordItem2()
                        featureMenu.areaItem()
                    }
                    featureMenu.popup(mouse.x, mouse.y)
                }
            }
        }
        // MapView's initialization
        Component.onCompleted: {
             isGeographic = __loader.isGeographic()
            //console.log("__activeLayer.layerId ): ", __activeLayer.layerId)
            //console.log("index of active layer ): ", __browseDataLayersModel.indexFromLayerId( __activeLayer.layerId ))

            __loader.mapSettings = mapView.canvasMapSettings
            //__loader.positionKit = positionKit
            __loader.recording = digitizing.recording
            //__layersModel.mapSettings= mapView.canvasMapSettings

            // Get project's EPSG ID and CRS name
            /*!
            We have to use loader instead of SurveyingUtils because Loader loads the project first, then it runs the function,
            But SurveyingUtils doesn't initializa project so it immediatelly run the function without initialization.
            We use mProject, but which project? QGIS confuses about it so it crash
            It is important to initialize project before running QGIS related projects
            */
            epsgID = !(__loader.epsg_code()) ? 4326 : __loader.epsg_code()
            epsgName = __loader.epsg_name()
        }
    }

    // map canvas menu
    // menu for Point geometry
    Menu {
        id: featureMenu
        modal: true
        dim: false
        onClosed: {
            highlightMap.visible = false
            // remove all menu items when closing the menu
            while(featureMenu.count > 0) {
                featureMenu.removeItem(featureMenu.itemAt(0));
            }
        }

        // Get Coordinates for line and polygon (it is used just because of plural Coordinates)
        function getCoordItem2() {
            featureMenu.addItem(get_coord.createObject(featureMenu, { text: "Get Coordinates" }))
        }

        // For Line
        // Length item
        function lengthItem() {
            featureMenu.addItem( length.createObject( featureMenu, { text: "Length" } ) )
        }
        Component {
            id: length
            MenuItem {
                onTriggered: {
                    var res = identifyKit.identifyOne(screenPoint);
                    var length_val = __surveyingUtils.getLength( res )
                    feature_dialog.title = "Length"
                    feature_dialog.text = length_val
                    feature_dialog.open()
                }
            }
        }
        // For Polygon
        // Area item
        function areaItem() {
            featureMenu.addItem( area.createObject( featureMenu, { text: "Area" } ) )
        }
        Component {
            id: area
            MenuItem {
                onTriggered: {
                    var res = identifyKit.identifyOne(screenPoint);
                    var area_val = __surveyingUtils.getArea( res )
                    feature_dialog.title = "Area"
                    feature_dialog.text = area_val
                    feature_dialog.open()
                }
            }
        }
        // Get Coordinates
        // For Point --------------------------------
        // Get Coordinate item
        function getCoordItem() {
            featureMenu.addItem(get_coord.createObject(featureMenu, { text: "Get Coordinate" }))
        }
        Component {
            id: get_coord
            MenuItem {
                onTriggered: {
                    var res = identifyKit.identifyOne(screenPoint);
                    var pointCoord = __surveyingUtils.qgsFeature2Coord(res)
                    coordList.editor.text = ""
                    coordList.editor.text = String( pointCoord )
                    coordList.open()
                }
            }
        }

        // Edit attribute menu item
        function editAttributeItem() {
            featureMenu.addItem(edit_attribute.createObject(featureMenu, { text: "Edit Attributes" }))
        }
        Component {
            id: edit_attribute
            MenuItem {
                onTriggered: {
                    var res = identifyKit.identifyOne(screenPoint);
                    if (res.valid) {
                        highlightMap.featureLayerPair = res
                        featurePanel.show_panel(res, "Edit" )
                    }
                    else if (featurePanel.visible) {
                        // closes feature/preview panel when there is nothing to show
                        featurePanel.visible = false
                    }
                }
            }
        }
    }

    // area and length dialog
    SErrorDialog {
        id: feature_dialog
    }

    Component.onCompleted: {
        recordToolbar.focus = true
        recordToolbar.visible = true
        recordToolbar.extraPanelVisible = true
    }
    // FeaturePanel to edit features
    QgsQuick.IdentifyKit {
        id: identifyKit
        //parent: mapView.mapCanvas
        mapSettings: mapView.canvasMapSettings
        identifyMode: QgsQuick.IdentifyKit.TopDownAll
    }
    // feature panel to edit features
    FeaturePanel {
        id: featurePanel
        width: dataCollector.width
        mapSettings: mapView.canvasMapSettings
        project: __loader.project
        visible: false
    }
    // Feature Heighlight
    QgsQuick.FeatureHighlight {
        anchors.fill: mapView
        id: highlightMap
        mapSettings: mapView.canvasMapSettings
        z: 2
    }
    // Coordinate view panel
    // Todo, rename as CoordinatePanel
    DataInputForm {
        id: collect_pane
    }
    // Input Point Dialog
    AddPoint {
        id: addPoint
    }
    // Digitizing Controller
    DigitizingController {
        id: digitizing
        //positionKit: positionMarker.positionKit
        layer: recordToolbar.activeVectorLayer
        lineRecordingInterval: __appSettings.lineRecordingInterval
        mapSettings: mapView.canvasMapSettings

        onRecordingChanged: {
            __loader.recording = digitizing.recording
        }
    }
    // Update record Toolbar
    function updateRecordToolbar() {
        var layer = recordToolbar.activeVectorLayer
        if (!layer)
        {
            // nothing to do with no active layer
            return
        }
        if (digitizing.hasPointGeometry(layer)) {
            recordToolbar.pointLayerSelected = true
        } else {
            recordToolbar.pointLayerSelected = false
        }
        recordToolbar.activeLayerName= recordToolbar.activeVectorLayer ? recordToolbar.activeVectorLayer.name : ""
        recordToolbar.activeLayerIcon = __loader.loadIconFromLayer( recordToolbar.activeVectorLayer )
    }
    // Record ToolBar
    RecordToolbar {
        id: recordToolbar
        width: dataCollector.width
        height: extraPanelHeight + 10
        anchors.top: parent.top
        z: 2
        y: dataCollector.height - height
        visible: false
        manualRecordig: digitizing.manualRecording
        onActiveLayerIndexChanged: {
            updateRecordToolbar()
        }
        // reset manualRecording after opening
        onVisibleChanged: if (visible) digitizing.manualRecording = true
        onAddClicked: recordFeature()
        onManualRecordingClicked: {
            digitizing.manualRecording = !digitizing.manualRecording
            if (!digitizing.manualRecording) {
                digitizing.startRecording()
            }
        }
        onRemovePointClicked: digitizing.removeLastPoint()
        onStopRecordingClicked: {
            digitizing.stopRecording()
            var pair = digitizing.lineOrPolygonFeature();
            editFeature(pair)
        }
        onLayerLabelClicked: {
            if (!digitizing.recording) {
                activeLayerPanel.openPanel()
            }
        }
    }
    // Active Layer Panel
    ActiveLayerPanel {
        id: activeLayerPanel
        z: 1
        onActiveLayerChangeRequested: {
            __loader.setActiveLayer( __recordingLayersModel.layerFromLayerId( layerId ) )
        }
    }
    // Record Button
    /*
    TODO
    code clear, add comments
    */
    RecordButton {
        id: recordButton
        highlighted: false
        z: highlightMap.z + 1
        anchors {
            bottom: collect_pane.top
            right: parent.right
            rightMargin: 5
            bottomMargin: 5
        }
    }
    // Settings dialog
    SettingsDialog {
        id: settingsDialog
    }
    // Menu
    Menu {
        id: moreMenu
        x: parent.width - width
        y: windoww.height
        transformOrigin: Menu.TopRight
        modal: true
        // Add Point
        MenuItem {
            id:setAction
            text: qsTr("Add Point")
            icon.source: "qrc:/assets/icons/material/maps/add_location.svg"
            onTriggered:{
                addPoint.xText = __loader.isGeographic() || !__loader.crsValid() ? "Latitude"+ ":  " : Util.textN() + ":  ";
                addPoint.yText = __loader.isGeographic() || !__loader.crsValid() ? "Longitude" + ":  " : Util.textE() + ":  ";

                addPoint.coord_row1.anchors.top = Util.coord_order() === "en" || Util.coord_order() === "lonlat" ? addPoint.coord_row2.bottom : parent.top
                addPoint.coord_row2.anchors.top = Util.coord_order() === "en" || Util.coord_order() === "lonlat" ? parent.top : addPoint.coord_row1.bottom

                console.log("Util.coord_order(): ", Util.coord_order())

                console.log("n_txt: ", addPoint.xText)
                console.log("e_txt: ", addPoint.yText)

                addPoint.open()
            }
        }
        // Extract Coordinates
        MenuItem{
            onTriggered:{
                coordList.editor.text = ""
                var coords = __loader.extractCoordinates()
                if( coords === "nolayer" ) {
                    error_dialog.text = "Active layer is not selected. Please select a point layer from active layer panel."
                    error_dialog.open()
                }
                else if( coords === "noPoint") {
                    error_dialog.text = "There is no point in the active layer."
                    error_dialog.open()
                }
                else {
                    coordList.editor.text = String(coords)
                    coordList.open()
                }
            }
            text: qsTr("Coordinate List")
            icon.source: "qrc:/assets/icons/material/content/content_paste.svg"
        }
        // Settings
        MenuItem{
            onTriggered: settingsDialog.open()
            text: qsTr("Settings")
            icon.source: "qrc:/assets/icons/material/action/settings.svg"
        }
        // Help
        MenuItem{
            onTriggered: maphelp.open()
            text: qsTr("Help")
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
        }

    }
    // Actions on toolbar
    actions: [
        // GPS button
        FluidControls.Action {
            id:gpsAction
            icon.color: {
                if(__appSettings.autoCenterMapChecked){
                    return "orange"
                }
                else{
                    return "white"
                }
            }
            onTriggered:{
                __appSettings.autoCenterMapChecked =!__appSettings.autoCenterMapChecked
            }
            toolTip: qsTr("Enable GPS")
            icon.source: "qrc:/assets/icons/material/maps/my_location.svg"
        },
        // Layers button
        FluidControls.Action {
            icon.source: "qrc:/assets/icons/material/maps/layers.svg"
            toolTip: qsTr("Layers")
            //visible: navDrawer.modal
            onTriggered: {
                // make focus false for TExtFields to prevent keyboard automatically show up
                //collect_pane.pointName.focus = false
                //collect_pane.pointDesc.focus = false
                //featurePanel.visible ? featurePanel.close() : featurePanel.open()
                navDrawer.open()
            }
        },
        // Zoom to Project
        FluidControls.Action {
            id:mya
            toolTip: qsTr("Zoom to Project")
            icon.source: "qrc:/assets/icons/material/maps/zoom_out_map.svg"
            onTriggered:{
                if(__appSettings.autoCenterMapChecked){
                    __appSettings.autoCenterMapChecked =!__appSettings.autoCenterMapChecked
                }
                __loader.zoomToProject(mapView.canvasMapSettings)
            }
        },
        // Menu
        FluidControls.Action {
            id:menuBar
            toolTip: "Menu"
            icon.source: "qrc:/assets/icons/material/navigation/more_vert.svg"
            onTriggered: {
                moreMenu.open()
                //fileDialog.open()

                //__loader.getCoordsTepe()


                //mapView.openProject = true
            }
        }
    ]

    // Error when EPSG isn't recognized
    SErrorDialog {
        id: error_dialog
    }

    // Help Page
    PointDataCollectorHelp {
        id: maphelp
        visible: false
    }

    // extracted coordinates from active layer dialog
    CoordinateList {
        id: coordList
        isGeographic: dataCollector.isGeographic
    }
    // ScaleBar in metric or imperial units
    ScaleBar {
        id: scaleBar
        height: 30
        anchors.bottom: collect_pane.top
        anchors.bottomMargin: 10
        mapSettings: mapView.canvasMapSettings
        preferredWidth: Math.min(dataCollector.width, 180 * QgsQuick.Utils.dp)
        z: 1
        systemOfMeasurement: Util.scalebar_settings()
        anchors.horizontalCenter: parent.horizontalCenter
    }
    // Record Crosshair
    RecordCrosshair {
        id: crosshair
        width: mapView.width
        height: mapView.height
        visible: true // recordToolbar.visible && digitizing.manualRecording
        z: 2
    }
    // Layers
    LayerPanel{ id: navDrawer }
    // Full screen and normal screen map
    FullMapBtn {
        id: fullMapBtn
        z: highlightMap.z + 1
        inputFormHeight: collect_pane.inputFormHeight
    }
    // when go back button pressed, the app must ensure to exit fullscreen settings
    Component.onDestruction: {
        if(count_full %2 === 1) {
            windoww.visibility = Window.AutomaticVisibility
            windoww.footer.visible = true
        }
    }
    // North arrow
    Rectangle{
        width: north.width
        height: north.height
        color: "transparent"
        anchors.top: count_full %2 === 0 ? recordToolbar.bottom : parent.top
        anchors.left: mapView.left
        z:1
        Image {
            id: north
            source: "qrc:/assets/icons/north-arrow.svg"
            sourceSize.width: 65
            sourceSize.height: 65
        }
    }
    // Cursor coordinate connection
    Connections {
        target: mapView.canvasMapSettings
        onExtentChanged: {
            collect_pane.coordinateText = (Util.datacollector_coord()).toString()
        }
    }
}
/** Coordinate transformater */
/*
QgsQuick.CoordinateTransformer {
    id: coordinateTransformer
    sourcePosition: positionKit.position
    sourceCrs: positionKit.positionCRS()
    destinationCrs: QgsQuick.Utils.coordinateReferenceSystemFromEpsgId( epsgID )
    transformContext: mapView.canvasMapSettings.transformContext()
}*/

/*
    var screenPoint = Qt.point( mapCanvas.width/2, mapCanvas.height/2 )
    var centerPoint = mapView.canvasMapSettings.screenToCoordinate(screenPoint)
*/
// display cursor coordinates project
/*
QgsQuick.CoordinateTransformer {
    id: cursorCoordinate
    sourcePosition: positionKit.position
    sourceCrs: positionKit.positionCRS()
    destinationCrs: QgsQuick.Utils.coordinateReferenceSystemFromEpsgId( epsgID )
    transformContext: mapView.canvasMapSettings.transformContext()
}*/
/*
SFileDialog {
    id: fileDialog
}
*/
