// Author: Edip AHmet Taşkın
// Copy Right Edip Ahmet Taşkın

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.1
import Fluid.Controls 1.0 as FluidControls
import Fluid.Effects 1.0
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import QtMultimedia 5.8
import QtQml.Models 2.2
import "components"
import "../../components/common"
import "../../components//common/script.js" as Utils
import "../../help"
//import "mapviewer.js" as JS

FluidControls.Page{
    title:qsTr("")
    appBar.maxActionCount: 4
    id:window
    visible: true

    property int zMapCanvas: 1
    property int zPanel: 20
    property int zToolkits: 10
    property alias mycanvas: mapCanvas

    property int mycount_map
    property int map_count2: 0
    property int map_count: 0

    property alias myproject: openProjectPanel
    property alias myposition : positionKit

        function isPositionOutOfExtent(border) {
            return ((positionKit.screenPosition.x < border) ||
                    (positionKit.screenPosition.y < border) ||
                    (positionKit.screenPosition.x > mapCanvas.width -  border) ||
                    (positionKit.screenPosition.y > mapCanvas.height -  border)
                    )
        }

    Settings{
        id:mysetting4
        property alias ekranMapviewer: window.map_count
        property alias projectCounter : window.mycount_map
        property alias scale_units_settings : scale_units.currentIndex
    }

    Component.onCompleted:{
        if (__appSettings.defaultProject) {
            var path = __appSettings.defaultProject ? __appSettings.defaultProject : openProjectPanel.activeProjectPath
            var defaultIndex = __projectsModel.rowAccordingPath(path)
            var isValid = __projectsModel.data(__projectsModel.index(defaultIndex), ProjectModel.IsValid)
            if (isValid && __loader.load(path)) {
                openProjectPanel.activeProjectIndex = defaultIndex !== -1 ? defaultIndex : 0
                __appSettings.activeProject = path
            } else {
                // if default project load failed, delete default setting
                __appSettings.defaultProject = ""
                openProjectPanel.openPanel()
            }
        } else {
            openProjectPanel.openPanel()
        }
        __loader.positionKit = positionKit
        __loader.recording = digitizing.recording

        console.log("stateManager.state is ", stateManager.state)
    }


// Digitizing Panle Study
// States
    Item {
        id: stateManager
        states: [
            // Default state - when none of state below
            State {
                name: "view"
            },
            // When a user is in recording session - creating a new feature.
            State {
                name: "record"
            },
            // When a user is modifying geometry of an existing feature
            State {
                name: "edit"
            }
        ]

        onStateChanged: {
            if (stateManager.state === "view") {
                recordToolbar.visible = false
            }
            else if (stateManager.state === "record") {
                recordToolbar.visible = true
                recordToolbar.extraPanelVisible = true
                recordToolbar.activeLayerIndex = activeLayerPanel.activeLayerIndex
                updateRecordToolbar()
                recordToolbar.gpsSwitchClicked()
            }
            else if (stateManager.state === "edit") {
                featurePanel.visible = false
                recordToolbar.visible = true
                recordToolbar.extraPanelVisible = false
                recordToolbar.activeLayerIndex = __layersModel.rowAccordingName(featurePanel.feature.layer.name,
                                                                                   __layersModel.firstNonOnlyReadableLayerIndex())
                updateRecordToolbar()

                var screenPos = digitizing.pointFeatureMapCoordinates(featurePanel.feature)
                mapCanvas.mapSettings.setCenter(screenPos);
            }
        }
    }
// Save recorded feature function
    function saveRecordedFeature(pair) {
        if (digitizing.isPairValid(pair)) {
            digitizingHighlight.featureLayerPair = pair
            digitizingHighlight.visible = true
            featurePanel.show_panel(pair, "Add", "form")
        } else {
            popup.text = "Recording feature is not valid"
            popup.open()
        }
        stateManager.state = "view"
    }
// Edit feature
    function editFeature() {
        var layer = featurePanel.feature.layer
        if (!layer)
        {
            // nothing to do with no active layer
            return
        }

        if (digitizing.hasLineGeometry(layer)) {
            // TODO
        }
        else if (digitizing.hasPointGeometry(layer)) {
            // assuming layer with point geometry
            var screenPoint = Qt.point( mapCanvas.width/2, mapCanvas.height/2 )
            var centerPoint = mapCanvas.mapSettings.screenToCoordinate(screenPoint)

            featurePanel.feature = digitizing.changePointGeometry(featurePanel.feature, centerPoint)
            featurePanel.saveFeatureGeom()
            stateManager.state = "view"
            featurePanel.show_panel(featurePanel.feature, "Edit", "form")
        }
    }
// Record feature
    function recordFeature() {
        var screenPoint = Qt.point( mapCanvas.width/2, mapCanvas.height/2 )
        var centerPoint = mapCanvas.mapSettings.screenToCoordinate(screenPoint)

        if (digitizing.hasPointGeometry(activeLayerPanel.activeVectorLayer)) {
            var pair = digitizing.pointFeatureFromPoint(centerPoint)
            saveRecordedFeature(pair)
        } else {
            if (!digitizing.recording) {
                digitizing.startRecording()
            }
            digitizing.addRecordPoint(centerPoint)
        }
    }
// gps indicator color
    function getGpsIndicatorColor() {
        if (positionKit.accuracy <= 0) return "#FC9FB1"
        return positionKit.accuracy < __appSettings.gpsAccuracyTolerance ? "green" : "orange"
    }
// message
    function showMessage(message) {
        if (!__androidUtils.isAndroid) {
            popup.text = message
            popup.open()
        } else {
            __androidUtils.showToast(message)
        }
    }

// update record Toolbar
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
        recordToolbar.activeLayerName= __layersModel.data(__layersModel.index(recordToolbar.activeLayerIndex), LayersModel.Name)
        recordToolbar.activeLayerIcon = __layersModel.data(__layersModel.index(recordToolbar.activeLayerIndex), LayersModel.IconSource)
    }
// Update Active Layer by name
    function updateActiveLayerByName(layerName) {
        activeLayerPanel.activeLayerIndex = __layersModel.rowAccordingName(layerName,
                                                                           __layersModel.firstNonOnlyReadableLayerIndex())
        activeLayerPanel.activeLayerIndexChanged()
        recordToolbar.activeLayerIndex = activeLayerPanel.activeLayerIndex
        recordToolbar.activeLayerIndexChanged()
    }



// Project Panel -----------------------------------------------------------------------------------
    ProjectPanel {
        id: openProjectPanel
        height: window.height
        width: window.width
        z: zPanel
        onActiveProjectIndexChanged: {
            openProjectPanel.activeProjectPath = __projectsModel.data(__projectsModel.index(openProjectPanel.activeProjectIndex), ProjectModel.Path)
            __appSettings.activeProject = openProjectPanel.activeProjectPath
            __loader.load(openProjectPanel.activeProjectPath)
        }
    }

// Input's feature panel
    FeaturePanel {
        id: featurePanel
        height: window.height
        width: window.width
        mapSettings: mapCanvas.mapSettings
        panelHeight: window.height
        previewHeight: window.height/3
        project: __loader.project
        z: 0 // to featureform editors be visible

        onVisibleChanged: {
            if (!visible) {
                digitizingHighlight.visible = false
                highlight.visible = false
            }
        }

        onEditGeometryClicked: {
            stateManager.state = "edit"
        }
    }

// FeaturePanel to edit features
    /*
    FeaturePanel {
        id: featurePanel
        height: window.height
        width: window.width
        edge: Qt.RightEdge
        mapSettings: mapCanvas.mapSettings
        project:  __loader.load(openProjectPanel.activeProjectPath)
        visible: false
      }
      */
// Position Kit -----------------------------------------------------------------------------
    QgsQuick.PositionKit {
          id: positionKit
          mapSettings: mapCanvas.mapSettings
          simulatePositionLongLatRad: __use_simulated_position ? [-2.9207148, 51.3624998, 0.05] : []

          onScreenPositionChanged: {
            if (__appSettings.autoCenterMapChecked) {
              var border = appBar.height
              if (isPositionOutOfExtent(border)) {
                mapCanvas.mapSettings.setCenter(positionKit.projectedPosition);
              }
            }
          }
        }
// Position Marker ---------------------------------------------------------------------------
        PositionMarker {
          id: positionMarker
          positionKit: positionKit
          z: zMapCanvas + 2
        }
// Map Transform
    Item {
        anchors.fill: mapCanvas
        transform: QgsQuick.MapTransform {
            mapSettings: mapCanvas.mapSettings
        }
        z: zMapCanvas + 1  // make sure items from here are on top of the Z-order
    }
// GPS STATUS
    Label {
        id: gpsPositionLabel
        text: {
          var label = "Signal Lost"
          if ( positionKit.hasPosition )
            label = QgsQuick.Utils.formatPoint( positionKit.position )
            if (positionKit.accuracy > 0)
              label += " (" + QgsQuick.Utils.formatDistance( positionKit.accuracy, positionKit.accuracyUnits, 0 ) + ")"
          label;
        }
        height: scaleBar.height
        x: window.width - width
        font.pixelSize: 16
        font.italic: true
        color: "steelblue"
        z: 1
      }
// Feature Heighlight ------------------------------------------------------------------------------
    /*
    QgsQuick.FeatureHighlight {
        height: parent.height
        width: parent.width
      id: highlight
      color: "yellow"
      mapSettings: mapCanvas.mapSettings
      z: 1
    }
    */
    Highlight {
        id: highlight
        anchors.fill: mapCanvas

        property bool hasPolygon: featureLayerPair !== null ? digitizing.hasPolygonGeometry(featureLayerPair.layer) : false

        mapSettings: mapCanvas.mapSettings

        lineColor: Qt.rgba(1,0.2,0.2,1)
        lineWidth: 6 * QgsQuick.Utils.dp

        fillColor: Qt.rgba(1,0.2,0.2, 0.4)

        outlinePenWidth: 1 * QgsQuick.Utils.dp
        outlineColor: "white"

        markerType: "image"
        markerImageSource: "qrc:/marker.svg"
        markerWidth: 60 * QgsQuick.Utils.dp
        markerHeight: 70 * QgsQuick.Utils.dp
        markerAnchorY: 48 * QgsQuick.Utils.dp

        // enable anti-aliasing to make the higlight look nicer
        // https://stackoverflow.com/questions/48895449/how-do-i-enable-antialiasing-on-qml-shapes
        layer.enabled: true
        layer.samples: 4
    }

    Highlight {
      id: digitizingHighlight
      anchors.fill: mapCanvas

      property bool hasPolygon: featureLayerPair !== null ? digitizing.hasPolygonGeometry(featureLayerPair.layer) : false

      mapSettings: mapCanvas.mapSettings

      lineColor: highlight.lineColor
      lineWidth: highlight.lineWidth

      fillColor: highlight.fillColor

      outlinePenWidth: highlight.outlinePenWidth
      outlineColor: highlight.outlineColor

      markerType: highlight.markerType
      markerImageSource: highlight.markerImageSource
      markerWidth: highlight.markerWidth
      markerHeight: highlight.markerHeight
      markerAnchorY: highlight.markerAnchorY

      // enable anti-aliasing to make the higlight look nicer
      // https://stackoverflow.com/questions/48895449/how-do-i-enable-antialiasing-on-qml-shapes
      layer.enabled: true
      layer.samples: 4
    }


// Digitizing Controller
    DigitizingController {
        id: digitizing
        positionKit: positionMarker.positionKit
        layer: activeLayerPanel.activeVectorLayer
        lineRecordingInterval: __appSettings.lineRecordingInterval
        mapSettings: mapCanvas.mapSettings

        onRecordingChanged: {
            __loader.recording = digitizing.recording
        }
    }
    // Highlighting a new feature while digitizing
    Connections {
        target: digitizing.recordingFeatureModel
        onFeatureLayerPairChanged: {
            if (digitizing.recording) {
                digitizingHighlight.visible = true
                digitizingHighlight.featureLayerPair = digitizing.recordingFeatureModel.featureLayerPair
            }
        }
    }

// Record ToolBar
    RecordToolbar {
        id: recordToolbar
        width: window.width
        height: 64* QgsQuick.Utils.dp + ((extraPanelVisible) ? extraPanelHeight : 0)
        z: zToolkits + 1
        y: window.height - height
        visible: false
        gpsIndicatorColor: getGpsIndicatorColor()
        manualRecordig: digitizing.manualRecording
        activeLayerIndex: activeLayerPanel.activeLayerIndex
        // reset manualRecording after opening
        onVisibleChanged: if (visible) digitizing.manualRecording = true

        onActiveLayerIndexChanged: {
            updateRecordToolbar()
        }

        onAddClicked: {
            if (stateManager.state === "record") {
                recordFeature()
            } else if (stateManager.state === "edit") {
                editFeature()
            }
        }

        onGpsSwitchClicked: {
            if (!positionKit.hasPosition) {
                popup.text = qsTr("The GPS is currently not available")
                popup.open()
                return // leaving when no gps is available
            }
            mapCanvas.mapSettings.setCenter(positionKit.projectedPosition)
        }

        onManualRecordingClicked: {
            digitizing.manualRecording = !digitizing.manualRecording
            if (!digitizing.manualRecording && stateManager.state === "record") {
                digitizing.startRecording()
            }
        }

        onRemovePointClicked: {
            digitizing.removeLastPoint()
        }

         onStopRecordingClicked: {
             digitizing.stopRecording()
             var pair = digitizing.lineOrPolygonFeature();
             saveRecordedFeature(pair)
             stateManager.state = "view"
         }

         onLayerLabelClicked: {
             if (!digitizing.recording) {
                 activeLayerPanel.openPanel()
             }
         }
    }

// Record Crosshair
    RecordCrosshair {
        id: crosshair
        width: mapCanvas.width
        height: mapCanvas.height
        visible: recordToolbar.visible && digitizing.manualRecording
        z: positionMarker.z + 1
    }

// Active Layer Panel
    ActiveLayerPanel {
        id: activeLayerPanel
        height: window.height/2
        width: window.width
        edge: Qt.BottomEdge
        z: zPanel

        onLayerSettingChanged: {
            recordToolbar.activeLayerIndex = activeLayerPanel.activeLayerIndex
            updateRecordToolbar()
        }
    }

// Notification
    Notification {
        id: popup
        text: ""
        width: 400 * QgsQuick.Utils.dp
        height: 160 * QgsQuick.Utils.dp
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        z: zPanel + 1000 // the most top
    }

// Map Canvas ----------------------------------------------------------------------------
    QgsQuick.MapCanvas {
      id: mapCanvas

      height: parent.height
      width: parent.width
      z: 0

      mapSettings.layers: __layersModel.layers
      mapSettings.project: __loader.project

      QgsQuick.IdentifyKit {
        id: identifyKit
        mapSettings: mapCanvas.mapSettings
        identifyMode: QgsQuick.IdentifyKit.TopDownAll
      }
      onClicked: {
          // no identify action in record state
          if (stateManager.state === "record") return




          mapCanvas.forceActiveFocus()
          var screenPoint = Qt.point( mouse.x, mouse.y );
          var res = identifyKit.identifyOne(screenPoint);
          if (res.valid) {
              highlight.featureLayerPair = res
              // update extent to fit feature above preview panel
              if (mouse.y > window.height - featurePanel.previewHeight) {
                  var panelOffsetRatio = featurePanel.previewHeight/window.height
                  __inputUtils.setExtentToFeature(res, mapCanvas.mapSettings, panelOffsetRatio)
              }

              highlight.visible = true

              featurePanel.show_panel(res, "ReadOnly", "preview" )

              //featurePanel.show_panel(res, "Edit" )
                }
          else if (featurePanel.visible) {
                      // closes feature/preview panel when there is nothing to show
                      featurePanel.visible = false
                  }
      }
    }  



// QGIS log panel
    Drawer {
        id: logPanel
        visible: false
        modal: true
        interactive: true
        height: window.height
        width: window.width
        edge: Qt.RightEdge
        z: 2 // make sure items from here are on top of the Z-order

        background: Rectangle {
          color: "white"
        }

        QgsQuick.MessageLog {
          id: messageLog
          width: parent.width
          height: parent.height
          model: QgsQuick.MessageLogModel {}
        }
      }

/** Coordinate transformater */
      QgsQuick.CoordinateTransformer {
        id: coordinateTransformer
        sourcePosition: positionKit.position
        sourceCrs: positionKit.positionCRS()
        destinationCrs: QgsQuick.Utils.coordinateReferenceSystemFromEpsgId( 3857 ) //web mercator
        transformContext: mapCanvas.mapSettings.transformContext()
      }
      Label {
          id: webPositionLabel
          text: {
            if ( positionKit.hasPosition )
               QgsQuick.Utils.formatPoint( coordinateTransformer.projectedPosition ) + " (web mercator)"
          }
          height: scaleBar.height
          x: window.width - width
          y: gpsPositionLabel.height + 2 * QgsQuick.Utils.dp
          font.pixelSize: 16
          font.italic: true
          color: "steelblue"
          z: 1
        }

// ScaleBar in metric or imperial units ----------------------------------------------------------------------------
    ScaleBar {
        id: scaleBar
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        mapSettings: mapCanvas.mapSettings
        preferredWidth: Math.min(window.width, 180 * QgsQuick.Utils.dp)
        z: zToolkits
        systemOfMeasurement: scale_units.currentIndex===0 ? QgsQuick.QgsUnitTypes.MetricSystem : QgsQuick.QgsUnitTypes.ImperialSystem
        anchors.horizontalCenter: parent.horizontalCenter
    }
    // scalebar settings
    FluidControls.AlertDialog {
        id: mapview_settings
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width
        height: mayrow22.height*4
        title: qsTr("Settings")
        Flickable{
            id:settings_flickable
        Column{
            id:settings_column
            spacing: 15

            RowLayout{
                id:mayrow22
                spacing: 15
                SText{
                    text:qsTr("Scale bar unit:  ")
                }
                CustomComboBox {
                    id: scale_units
                    width: 100
                    currentIndex: 0

                    model: ListModel {
                        ListElement { text: qsTr("Metric") }
                        ListElement { text: qsTr("Imperial") }
                    }
                }

            }
        }

    }
    }
    // SCALEBAR connection -------------------------------
    Connections {
        target: mapCanvas.mapSettings
        onExtentChanged: {
            scaleBar.visible = true
        }
    }

// help page ------------------------------------------------------------------------
    MapViewerHelp{
        id:maphelp
        z:200
        visible: false
        anchors.fill: parent
    }

// Actions------------------------------------------------------------------------------

    actions: [
        FluidControls.Action {
            id:myaction2
            text: qsTr("Jobs")
            icon.source: FluidControls.Utils.iconUrl(window.myproject.openPanelIcon())
            toolTip: qsTr("Jobs")
            onTriggered:{
                  mycount_map++
                  window.myproject.openPanel()
            }
        },
        FluidControls.Action {
            icon.source: FluidControls.Utils.iconUrl("av/album")
            toolTip: qsTr("Record")
            text: qsTr("Record")
            //visible: navDrawer.modal
            onTriggered: {
                stateManager.state = "record"
            }
        },
        FluidControls.Action {
            icon.source: FluidControls.Utils.iconUrl("maps/layers")
            toolTip: qsTr("Layers")
            text: qsTr("Layers")
            //visible: navDrawer.modal
            onTriggered: {
                //featurePanel.visible ? featurePanel.close() : featurePanel.open()
                navDrawer.visible ? navDrawer.close() : navDrawer.open()
            }
        },

        FluidControls.Action {
          id:mya
              onTriggered:{
                  __loader.zoomToProject(window.mycanvas.mapSettings)
              }
            text: qsTr("Zoom Project")
            icon.source: FluidControls.Utils.iconUrl("maps/zoom_out_map")
            toolTip: qsTr("Zoom Project")
        },
        FluidControls.Action {
          id:map_help
              onTriggered:{
                  map_count2++
                  maphelp.visible = JS.mapview_help()
              }
            
            icon.source: FluidControls.Utils.iconUrl(JS.mapview_helpicon())
            toolTip: qsTr("Help")
        },
        FluidControls.Action {
          id:map_action
            onTriggered:{
                map_count++
                JS.fav_mapview()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.mapview_icon())
            toolTip: qsTr("Favourite")
        },
        // GPS
        FluidControls.Action {
          id:favourite2
            onTriggered:{
                window.mycanvas.mapSettings.setCenter(window.myposition.projectedPosition)
            }
            text: qsTr("My Location")
            icon.source: FluidControls.Utils.iconUrl("maps/my_location")
            toolTip: qsTr("My Location")
        },
        FluidControls.Action {
            id:setAction
            text: qsTr("Settings")
            icon.source: FluidControls.Utils.iconUrl("action/settings")
            onTriggered:{
                mapview_settings.open()
            }
            }


    ]

    FluidControls.NavigationListView {
        id: navDrawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        readonly property bool mobileAspect: window.width < 500

        modal: true
        interactive: true
        visible: false
    ColumnLayout{
        width: parent.width
            ListView {
                id:my_layerlist
                implicitHeight: navDrawer.height
                implicitWidth: parent.width
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                model:__layersModel

                delegate:FluidControls.Card{
                    height: 50
                    width: parent.width
                    Row{
                        spacing: 10
                        leftPadding: 15
                        anchors.verticalCenter: parent.verticalCenter
                        Image {
                            id: icon
                            source: iconSource
                            sourceSize.width: 20
                            sourceSize.height: 20

                        }
                        SText{
                            font.pixelSize: 16
                            text:name
                            // layer name
                            //text:VectorLayer.name
                            // layer type
                            //text: Layer
                            // layer visible
                            //text:Visible
                        }

                        //CheckBox{
                         //   width: parent.width
                        //    checked: true
                         //   font.pixelSize: 17
                        //    text: name
                       // }
            }
            }
                /*

                delegate:FluidControls.Card{
                    height: 50
                    width: parent.width
                    Row{
                        spacing: 10
                        leftPadding: 15
                        anchors.verticalCenter: parent.verticalCenter
                        //Layout.fillHeight: true
                        //Layout.alignment: Qt.AlignVCenter
                        //Layout.leftMargin: 20
                        Image {
                            id: icon
                            source: iconSource
                            width: 20
                            height: 20

                        }
                        SText{
                            font.pixelSize: 16
                            text:name
                        }

                        //CheckBox{
                         //   width: parent.width
                        //    checked: true
                         //   font.pixelSize: 17
                        //    text: name
                       // }
            }
            }
*/

        }
    }





    }
}
