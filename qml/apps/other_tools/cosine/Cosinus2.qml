import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../../help"
import "cosinus.js" as JS
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("Cosine Law")
    appBar.maxActionCount: 2
    id:coscalc
    Settings{
        id:cosinesetting
        property alias ekranChecked2: coscalc.cos_count
    }
    Loader{
            id: cos_loader
            source: "cosinus.qml"
            anchors.fill: parent
    }
    CosinusHelp{
        id: cosHelp
        visible: false
    }

    property int cos_count: 0
    property int cos_count2: 0
    actions: [
        /*FluidControls.Action {
          id:fav_action
            onTriggered:{
                cos_count++
                JS.cos_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.cos_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:cos_action2
              onTriggered:{
                  cosHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
