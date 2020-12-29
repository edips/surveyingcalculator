import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../../help"
import "helmert.js" as JS
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("2D Helmert Similarity Transformation")
    appBar.maxActionCount: 2
    id:helmertcalc
    Settings{
        id:helmertsetting
        property alias helmertChecked2: helmertcalc.helmert_count
    }
    Loader{
            id: helmert_loader
            source: "Helmert.qml"
            anchors.fill: parent
    }
    HelmertHelp{
        id: helHelp
        visible: false
    }

    property int helmert_count: 0
    property int helmert_count2: 0
    actions: [
        /*FluidControls.Action {
          id:helmert_action
            onTriggered:{
                helmert_count++
                JS.helmert_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.helmert_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:helmert_action2
              onTriggered:{
                  helHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
