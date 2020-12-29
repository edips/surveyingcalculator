import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import "../../../components/common/script.js" as Calc
import "four.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
import "../../../components/gis"

Item{
    SFlickable {
        id:optionsPage8
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:my_first
            property alias four1: pt_a.north_txt
            property alias four2: pt_a.east_txt
            property alias four3: pt_b.north_txt
            property alias four4: pt_b.east_txt
            property alias four5: pt_c.north_txt
            property alias four6: pt_c.east_txt
            property alias abc_to4_dec: abc_to4.decimal_txt
            property alias abc_to4_deg: abc_to4.degree_txt
            property alias abc_to4_min: abc_to4.minute_txt
            property alias abc_to4_sec: abc_to4.second_txt
            property alias abc_to4_gon: abc_to4.gon_txt
        }

        // Coordinate select from map dialog
        Loader {
            id: loadComponent
            anchors.fill: parent
            asynchronous: true
            active: false
            sourceComponent: macomponent
        }
        // Coordinate select from map dialog
        Component.onDestruction: loadComponent.active = false
        Component {
            id: macomponent
            CoordSelect {
                id: mapDialog
                onClosed: {
                    if( selected && coordName === "pt_a" ) {
                        pt_a.east.text = xCoord
                        pt_a.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_b" ) {
                        pt_b.east.text = xCoord
                        pt_b.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_c" ) {
                        pt_c.east.text = xCoord
                        pt_c.north.text = yCoord
                        selected = false
                    }
                }
            }
        }
        SErrorDialog {
            id: errDialog
        }


        Column{
            id:optionsColumn
            spacing: 10
            anchors.fill : parent
            anchors.topMargin    : 15
            anchors.bottomMargin : 15
            anchors.leftMargin :15
            anchors.rightMargin  : 15
            NEHeader {}
            // Point A
            NorthEastP{
                id: pt_a
                name: "A"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_a"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            // Point B
            NorthEastP{
                id: pt_b
                name: "B"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_b"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            // Point C
            NorthEastP{
                id: pt_c
                name: "C"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_c"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            //Hesap Form
            Hesap{
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.fourcalc()
                // Clear all text fields
                clear_list: [ pt_a.north, pt_a.east, pt_b.north, pt_b.east, pt_c.north, pt_c.east ]
                clear.onClicked:{
                    clearAll();
                    Calc.angle_clear([abc_to4])
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                SText {text: "(ABC): "; }
                SAngle{id:abc_to4; read_only: true; }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                height:geri.width
                width:geri.height
                color: "transparent"
                Image {
                    id:geri
                    width: 250
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/four.png"
                }
            }
        }
    }
}
