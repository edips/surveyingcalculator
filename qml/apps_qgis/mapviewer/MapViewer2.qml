// Author: Edip AHmet Taşkın
// Copy Right Edip Ahmet Taşkın

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.1
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import Fluid.Effects 1.0
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import QtMultimedia 5.8
import QtQml.Models 2.2
import "../../components/gis"
import "../../components/common"
import "../../components/common/script.js" as Util
import "../../help"
import "mapviewer.js" as JS

FluidControls.Page{
    title:qsTr("")
    appBar.maxActionCount: 3
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
            }
        ]

        onStateChanged: {
            if (stateManager.state === "view") {
                return
            }
        }
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

// Position Kit -----------------------------------------------------------------------------
    QgsQuick.PositionKit {
          id: positionKit
          mapSettings: mapCanvas.mapSettings
          simulatePositionLongLatRad: __use_simulated_position ? [-2.9207148, 51.3624998, 0.05] : []
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
    }  



    // North arrow
    Rectangle{
        width: north.width
        height: north.height
        color: "transparent"
        //anchors.top: parent
        anchors.top: parent.top
        anchors.left: parent.left
        z:1
        Image {
            id: north
            source: "qrc:/assets/icons/north-arrow.svg"
            sourceSize.width: 80
            sourceSize.height: 80
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

// ScaleBar in metric or imperial units ----------------------------------------------------------------------------
    ScaleBar {
        id: scaleBar
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        mapSettings: mapCanvas.mapSettings
        preferredWidth: Math.min(window.width, 180 * QgsQuick.Utils.dp)
        z: zToolkits
        systemOfMeasurement: Util.scalebar_settings()
        anchors.horizontalCenter: parent.horizontalCenter
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
        width: parent.width
        height: FluidControls.ApplicationWindow.contentItem.height + FluidCore.Device.gridUnit
    }

    // loader doesn't work error: Element is not creatable.
    /*Loader{
            id: maphelp
            source: "../../MapViewerHelp.qml"
            active:true
            height:FluidControls.ApplicationWindow.contentItem.height + FluidCore.Device.gridUnit
            width: parent.width
    }*/

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
            icon.source: "qrc:/assets/icons/material/maps/layers.svg"
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
            icon.source: "qrc:/assets/icons/material/maps/zoom_out_map.svg"
            toolTip: qsTr("Zoom Project")
        },
        FluidControls.Action {
          id:map_help
              onTriggered:{
                  maphelp.open()
              }

            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            text: qsTr("Help")
        },
        /*FluidControls.Action {
          id:map_action
            onTriggered:{
                map_count++
                JS.fav_mapview()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.mapview_icon())
            toolTip: qsTr("Favourite")
        },*/
        // GPS
        FluidControls.Action {
          id:favourite2
            onTriggered:{
                window.mycanvas.mapSettings.setCenter(window.myposition.projectedPosition)
            }
            text: qsTr("My Location")
            icon.source: "qrc:/assets/icons/material/maps/my_location.svg"
            toolTip: qsTr("My Location")
        }


    ]

    FluidControls.NavigationListView {
        id: navDrawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: parent.height
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
                        }
                    }
                }

            }
        }
    }



}
