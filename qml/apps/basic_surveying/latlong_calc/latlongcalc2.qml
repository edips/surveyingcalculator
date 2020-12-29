import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "latlongcalc.js" as JS
import "../../../components/common/script.js" as Utils


FluidControls.Page{
    title:qsTr("Lat/Lon Calculation")
    appBar.maxActionCount: 2
    id:latlongcalc
    Settings{
        id:latlongancesetting
        property alias latlonganceChecked2: latlongcalc.latlong_count
    }
    Loader{
            id: latlong_loader
            source: "latlongcalc.qml"
            anchors.fill: parent
    }
    property int latlong_count: 0
    property int latlong_count2: 0
    actions: [
       /* FluidControls.Action {
          id:latlong_action
            onTriggered:{
                latlong_count++
                JS.latlong_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.latlong_icon())
            toolTip: qsTr("Favourite")
        }
        FluidControls.Action {
          id:latlong_action2
              onTriggered:{
                  latlong_count2++
                  latlong_loader.source=JS.latlong_help()
              }
            
            icon.source: FluidControls.Utils.iconUrl(JS.latlong_helpicon())
            toolTip: qsTr("Help")
        }*/
    ]
}
