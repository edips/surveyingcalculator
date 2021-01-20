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

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import QtQuick.Layouts 1.3
import lc 1.0
import QgsQuick 0.1 as QgsQuick
import "../common"
import "../common/script.js" as Util

TopSheet {
    title: "Select Point Layer"
    // new
    property string activeLayerId: __activeLayer.layerId
    signal activeLayerChangeRequested( var layerId )
    property color materialcolor: Universal.accent
    function openPanel() { layerPanel.visible = true }
    // active vector layer
    property QgsQuick.VectorLayer activeVectorLayer: __activeLayer.vectorLayer
    // active layer name
    property string activeLayerName: activeVectorLayer ? activeVectorLayer.name : ""
    id: layerPanel
    width: parent.width
    visible: false
    closePolicy: Popup.CloseOnEscape // prevents the drawer closing while moving canvas
    // Add Point Layer Dialog, disabled till finding a way to add a survey layer
    //NewLayer { id: newLayer }
    // Layer List
    Rectangle {
        anchors.topMargin: 5
        anchors.top: toolbar.bottom
        height: parent.height - layerPanel.toolbar.height
        width: parent.width
        color: "transparent"
        ListView {
            id:grid
            width: parent.width
            height: parent.height - layerPanel.toolbar.height
            focus: true
            interactive: true
            clip: true
            model: __recordingLayersModel
            boundsBehavior: Flickable.StopAtBounds
            delegate: ItemDelegate {
                Component.onCompleted: console.log( "istItem.height", listItem.height )
                id: listItem
                width: parent.width
                height: hasPointGeometry ? implicitHeight : 0
                //height: isVector && !isReadOnly && hasGeometry ? grid.cellHeight : 0
                SText {
                    text: layerName ? layerName : ""
                    font.pixelSize: 15
                    font.bold: listItem.highlighted
                    leftPadding: 50
                    width: parent.width - 60
                    clip: true
                    anchors.verticalCenter: parent.verticalCenter
                    color: Universal.foreground
                }
                icon.source: iconSource ? iconSource : ""
                icon.color: "transparent"
                opacity: enabled ? 1 : 0.5
                highlighted: layerId === activeLayerId
                onClicked: {
                    activeLayerChangeRequested( layerId )
                    // Update isGeographic and CRS of active layer
                    isLayerGeographic = __loader.isLayerGeographic()
                    layerEPSG = __loader.activeLayerCRS()
                    // Update active layer's crs name
                    epsgName = __loader.epsg_name()
                    layerPanel.visible = false
                }
            }
            // No layer found message text
            Label {
                anchors.fill: parent
                leftPadding: 10
                rightPadding: 10
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                visible: parent.count == 0
                text: qsTr("No point layer..")
                font.pixelSize: 18
                font.bold: true
                wrapMode: Label.WordWrap
            }
            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }
}
