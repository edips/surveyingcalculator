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

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../../help"
import "backazimuth.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Resection from 3 Points")
    appBar.maxActionCount: 3
    id:backaz
    Settings{
        id:mysetting3
        property alias ekranBack: backaz.count_back
    }
    Loader {
            id: loader3
            source: "Backazimuth.qml"
            anchors.fill: parent
    }
    BackazimuthHelp{
        id:backHelp
        visible: false
    }

    property int count_back: 0
    property int count_back2: 0
    FluidControls.AlertDialog {
             id: warning
             x: (parent.width - width) / 2
             y: (parent.height - height) / 2
             width: parent.width
                 title: qsTr("Warning")
             Label {
                 onLinkActivated: Qt.openUrlExternally(link)
                 anchors.horizontalCenter: parent.horizontalCenter
                 width: parent.width
                 textFormat: Label.RichText
                 font.pixelSize:16
                 wrapMode: Label.WordWrap
                 text:qsTr("<b>Resection from 3 Points</b> is based on Tienstra's method and it should not be used in field works.
                 The results are indeterminate if all four points lie on or sufficiently close to a circle or the 3 known reference points lie on a straight line.")
                      }
    }
    actions: [
        FluidControls.Action {
          id:favourite
            onTriggered:{
                count_back++
                JS.back_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.back_icon())
            toolTip: qsTr("Favourite")
        },
        FluidControls.Action {
          id:yea
            onTriggered:{
                warning.open()
            }
            text: qsTr("Warning")
            icon.source: "qrc:/assets/icons/material/alert/warning.svg"
            toolTip: qsTr("Warning")
        },
        FluidControls.Action {
          id:myaction
              onTriggered:{
                  backHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
