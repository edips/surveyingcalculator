import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.0
import "../../../help"
import "mapscale.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Map Scale Calculator")
    appBar.maxActionCount: 2
    id:scalecalc
    Settings{
        id:scalesetting
        property alias scaleanceChecked2: scalecalc.scale_count
    }
    Loader{
            id: scale_loader
            source: "MapScale.qml"
            anchors.fill: parent
    }
    MapScaleHelp{
        id: scaleHelp
        visible: false
    }

    property int scale_count: 0
    property int scale_count2: 0
    actions: [
        /*FluidControls.Action {
          id:scale_action
            onTriggered:{
                scale_count++
                JS.scale_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.scale_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:scale_action2
              onTriggered:{
                  scaleHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
