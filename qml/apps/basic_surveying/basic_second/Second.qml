import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../../components/common/script.js" as Calc
import "second.js" as Hesap
import "../../../components/common"
import "../../../components/gis"
import Qt.labs.settings 1.0
Item{
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:my_first
            property alias second1: pt_a.north_txt
            property alias second2: pt_a.east_txt
            property alias second3:ab_to2.text
            property alias second5: pt_b.north_txt
            property alias second6: pt_b.east_txt
            property alias sabg_to2_dec: abg_to2.decimal_txt
            property alias sabg_to2_deg: abg_to2.degree_txt
            property alias sabg_to2_min: abg_to2.minute_txt
            property alias sabg_to2_sec: abg_to2.second_txt
            property alias sabg_to2_gon: abg_to2.gon_txt
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
            //Hesap Form
            Hesap{
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.secondcalc()
                // Clear all text fields
                clear_list: [  pt_b.north, pt_b.east, ab_to2, pt_a.north, pt_a.east ]
                clear.onClicked:{
                    clearAll();
                    Calc.angle_clear([abg_to2])
                }
            }
            Column{
                id:row
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:10
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    SText {text: "AB: "; }
                    STextField { id: ab_to2; readOnly: true; placeholderText: "m"; }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    SText { id: ab_label; text: "(AB) : "; }
                    SAngle{ read_only: true; id: abg_to2; }
                }
            }
            Rectangle{
                height:geri.height
                width:geri.width
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    width: 250
                    //height: 300
                    fillMode: Image.PreserveAspectFit
                    id:geri
                    source:"qrc:/assets/images/first.png"
                }
            }
        }
    }
}
