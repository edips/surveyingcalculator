import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "first.js" as JS
import "../../../help"
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("X(N), Y(E) Calculation")
    appBar.maxActionCount: 1
    id:firstcalc
    Settings{
        id:firstsetting
        property alias firstChecked2: firstcalc.first_count
    }
    Loader{
            id: first_loader
            source: "First.qml"
            anchors.fill: parent
    }
    property int first_count: 0
    property int first_count2: 0

    FirstHelp{
        id:firstHelp
        visible: false
    }

    actions: [
        /*FluidControls.Action {
          id:first_action
            onTriggered:{
                first_count++
                JS.first_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.first_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
            id:first_action2
            onTriggered:{
                firstHelp.open()
            }

            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
