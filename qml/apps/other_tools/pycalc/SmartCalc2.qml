import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.0
import "../../../help"
import "smartcalc.js" as JS
import "../../../components/common/script.js" as Util
FluidControls.Page{
    title:qsTr( "PyCalculator")
    appBar.maxActionCount: 3
    id:pycalccalc
    Settings{
        id:pycalcinesetting
        property alias pycalcChecked2: pycalccalc.pycalc_count
    }
    Loader{
            id: pycalc_loader
            source: "SmartCalc.qml"
            anchors.fill: parent
    }
    PyCalculatorHelp{
        id: pyHelp
        visible: false
    }

    property int pycalc_count: 0
    property int pycalc_count2: 0
    actions: [
        FluidControls.Action {
          id:fav_action
            onTriggered:{
                pycalc_count++
                JS.pycalc_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.pycalc_icon())
            toolTip: qsTr("Favourite")
        },
        FluidControls.Action {
          id:pycalc_action2
              onTriggered:{
                  pyHelp.open()
              }

            
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]

}
