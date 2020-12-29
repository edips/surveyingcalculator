import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../../help"
import "circle.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr("Circle by 3 Points")
    appBar.maxActionCount: 2
    id:circlecalc
    Settings{
        id:circlesetting
        property alias circleChecked2: circlecalc.circle_count
    }
    Loader{
            id: circle_loader
            source: "Circle.qml"
            anchors.fill: parent
    }
    CircleHelp{
        id:circleHelp
        visible: false
    }
    property int circle_count: 0
    property int circle_count2: 0
    actions: [
        /*FluidControls.Action {
          id:circle_action
            onTriggered:{
                circle_count++
                JS.circle_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.circle_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:circle_action2
              onTriggered:{
                  circleHelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
