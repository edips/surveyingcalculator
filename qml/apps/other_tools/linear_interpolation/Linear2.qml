import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.0
import "../../../help"
import "linear.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Linear Interpolation")
    appBar.maxActionCount: 2
    id:linearcalc
    Settings{
        id:linearsetting
        property alias linearChecked2: linearcalc.linear_count
    }
    Loader{
            id: linear_loader
            source: "Linear.qml"
            anchors.fill: parent
    }
    LinearHelp{
        id: linearHelp
        visible: false
    }

    property int linear_count: 0
    property int linear_count2: 0
    actions: [
        /*FluidControls.Action {
          id:linear_action
            onTriggered:{
                linear_count++
                JS.linear_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.linear_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:linear_action2
              onTriggered:{
                  linearHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
