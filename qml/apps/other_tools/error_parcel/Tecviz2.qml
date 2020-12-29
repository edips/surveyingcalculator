import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../../help"
import "tecviz.js" as JS
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title: qsTr("Error Limit of Parcel Area")
    appBar.maxActionCount: 2
    id:teccalc
    Settings{
        id:tecvizsetting
        property alias tecvizChecked2: teccalc.tecviz_count
    }
    Loader{
            id: tecviz_loader
            source: "tecviz.qml"
            anchors.fill: parent
    }
    ParcelHelp{
        id: parHelp
        visible: false
    }

    property int tecviz_count: 0
    property int tecviz_count2: 0
    actions: [
        /*FluidControls.Action {
          id:tec_action
            onTriggered:{
                tecviz_count++
                JS.tec_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.tec_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:tec_action2
              onTriggered:{
                  parHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
