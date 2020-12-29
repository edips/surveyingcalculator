import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "second.js" as JS
import "../../../help"
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("Distance, Azimuth")
    appBar.maxActionCount: 2
    id:seccalc
    Settings{
        id:secondsetting
        property alias secondChecked2: seccalc.sec_count
    }
    Loader{
            id: sec_loader
            source: "Second.qml"
            anchors.fill: parent
    }
    SecondHelp{
        id: secondHelp
        visible: false
    }

    property int sec_count2: 0
    property int sec_count: 0
    actions: [
        /*FluidControls.Action {
          id:sec_action
            onTriggered:{
                sec_count++
                JS.sec_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.sec_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:sec_action2
              onTriggered:{
                  secondHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
