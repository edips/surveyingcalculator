import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "distance.js" as JS
import "../../help"
import "../../components/common/script.js" as Utils


FluidControls.Page{
    title:qsTr("Distance Calculator")
    appBar.maxActionCount: 2
    id:distcalc
    Settings{
        id:distancesetting
        property alias distanceChecked2: distcalc.dist_count
    }
    Loader{
            id: dist_loader
            source: "Distance.qml"
            anchors.fill: parent
    }
    property int dist_count: 0
    property int dist_count2: 0

    DistanceHelp{
        id:disthelp
        visible: false
    }

    actions: [
        /*FluidControls.Action {
          id:dist_action
            onTriggered:{
                dist_count++
                JS.dist_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.dist_icon())
            toolTip: qsTr("Favourite")
        },*/
        FluidControls.Action {
          id:dist_action2
              onTriggered:{
                  // delete this dist_count2++
                  disthelp.open()
              }
            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}
