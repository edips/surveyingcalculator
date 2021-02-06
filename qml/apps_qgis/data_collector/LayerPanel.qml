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

import QtQuick 2.10
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Universal 2.12
import Fluid.Controls 1.0 as FluidControls
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import "../../components/common"

FluidControls.NavigationListView {
    id: navDrawer
    width: parent.width - 100
    height: parent.height

    readonly property bool mobileAspect: dataCollector.width < 500
    modal: true
    interactive: true
    visible: false
    ColumnLayout{
        width: parent.width
        ListView {
            id:my_layerlist
            implicitHeight: navDrawer.height - 70
            implicitWidth: parent.width
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model:__layersModel
            spacing: 1
            delegate: ItemDelegate {
                height: 60
                width: parent.width
                onClicked: {
                    __loader.layerChecked(layerId)
                    icon2.source = __loader.layerVisibility( layerId ) ? "qrc:/assets/icons/checkbox.svg" :
                                                  ( __appSettings.theme === 0 ? "qrc:/assets/icons/checkbox_outline_light.svg" : "qrc:/assets/icons/checkbox_outline_dark.svg" )
                }
                Row{
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: icon2
                        visible: false
                        anchors.verticalCenter: parent.verticalCenter
                        source: __loader.layerVisibility( layerId ) ? "qrc:/assets/icons/checkbox.svg" :
                                                   ( __appSettings.theme === 0 ? "qrc:/assets/icons/checkbox_outline_light.svg" : "qrc:/assets/icons/checkbox_outline_dark.svg" )
                        sourceSize.width: 25
                        sourceSize.height: 25

                    }
                    ColorOverlay{
                        width: icon2.width
                        height: icon2.height
                        source: icon2
                        color: "transparent"
                        transformOrigin: Item.Center
                    }


                    Image {
                        id: icon
                        anchors.verticalCenter: parent.verticalCenter
                        source: iconSource
                        sourceSize.width: 20
                        sourceSize.height: 20
                    }

                    SText{
                        font.pixelSize: 16
                        text: layerName
                    }

                }
            }
        }
    }
}
