import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "third.js" as JS
import "../../../help"
import "../../../components/common/script.js" as Utils
FluidControls.Page{
    title:qsTr("Azimuth Calculation")
    appBar.maxActionCount: 2
    id:thirdcalc
    Settings{
        id:thirdsetting
        property alias thirdChecked2: thirdcalc.third_count
    }
    Loader{
            id: third_loader
            source: "Third.qml"
            anchors.fill: parent
    }
    ThirdHelp{
        id: thirdHelp
        visible: false
    }

    property int third_count: 0
    property int third_count2: 0
    actions: [
        /*FluidControls.Action {
          id:fav_third
            onTriggered:{
                third_count++
                JS.third_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.third_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:third_action2
              onTriggered:{
                  thirdHelp.open()
              }

            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
