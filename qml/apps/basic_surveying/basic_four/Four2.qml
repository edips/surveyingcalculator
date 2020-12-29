import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "four.js" as JS
import "../../../help"
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("Interior Angle")
    appBar.maxActionCount: 2
    id:fourcalc
    Settings{
        id:foursetting
        property alias fourChecked2: fourcalc.four_count
    }
    Loader{
            id: four_loader
            source: "Four.qml"
            anchors.fill: parent
    }
    FourHelp{
        id:fourHelp
        visible: false
    }

    property int four_count: 0
    property int four_count2: 0
    actions: [
        /*FluidControls.Action {
          id:four_action
            onTriggered:{
                four_count++
                JS.four_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.four_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:four_action2
              onTriggered:{
                  fourHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
