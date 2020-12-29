import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import "first.js" as Hesap
import Qt.labs.settings 1.0
import "../../../components/common/"
import "../../../components/gis"
import "../../../components/common/script.js" as Calc

Item{
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:my_first
            property alias first1: pt_a.north_txt
            property alias first2: pt_a.east_txt
            //property list<Rectangle> siblingRects
            property alias first3:ab_to1.text
            property alias first5: pt_b.north_txt
            property alias first6:pt_b.east_txt
            property alias fdecimal: abg_to1.decimal_txt
            property alias fdegree: abg_to1.degree_txt
            property alias fminute: abg_to1.minute_txt
            property alias fsecond: abg_to1.second_txt
            property alias fgon: abg_to1.gon_txt
        }

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
                    } //else if(selected && coordName === "pt_b")
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
            NorthEastP {
                id: pt_a
                name: "A"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_a"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            Column{
                id:row
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    SText {text: "AB: "; }
                    STextField{id:ab_to1; }
                }
                Row{
                    SText {text: "(AB): "; }
                    SAngle{id:abg_to1}
                }
            }
            //Hesap Form
            Hesap{
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.firstcalc()
                // Clear all text fields
                clear_list: [  pt_b.north, pt_b.east, ab_to1, pt_a.north, pt_a.east ]
                clear.onClicked:{
                    clearAll();
                    Calc.angle_clear([abg_to1])
                }
            }
            NEHeader {}
            NorthEastP{
                id: pt_b
                name: "B"
                readonly: true
            }
            Rectangle{
                height:geri.height
                width:geri.width
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    id:geri
                    width: 250
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/first.png"
                }
            }
        }
    }
}
