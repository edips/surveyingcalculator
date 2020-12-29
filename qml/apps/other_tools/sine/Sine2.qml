import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.0
import "../../../help"
import "sine.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Sine Law")
    appBar.maxActionCount: 3
    id:sinecalc
    Settings{
        id:sineinesetting
        property alias sinusChecked2: sinecalc.sine_count
    }
    Loader{
            id: sine_loader
            source: "Sine.qml"
            anchors.fill: parent
    }
    SineHelp{
        id: sin
        visible: false
    }

    property int sine_count: 0
    property int sine_count2: 0
    actions: [
        /*FluidControls.Action {
          id:fav_action
            onTriggered:{
                sine_count++
                JS.sine_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.sine_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:sine_action2
              onTriggered:{
                  sin.open()
              }

            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
