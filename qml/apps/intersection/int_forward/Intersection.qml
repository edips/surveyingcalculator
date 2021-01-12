import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../../components/common/script.js" as Calc
import "intersection.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
import "../../../components/gis"

/*
TODO:
- fix "please enter values", it doesn't work after filling coords but when angles are empty
*/

Item{
    SFlickable {
        id:optionsPage2
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:my_first
            property alias ia2_dec: a2.decimal_txt
            property alias ia2_deg: a2.degree_txt
            property alias ia2_min: a2.minute_txt
            property alias ia2_sec: a2.second_txt
            property alias ia2_gon: a2.gon_txt
            property alias ib2_dec: b2.decimal_txt
            property alias ib2_deg: b2.degree_txt
            property alias ib2_min: b2.minute_txt
            property alias ib2_sec: b2.second_txt
            property alias ib2_gon: b2.gon_txt

            property alias intersect3: pt_1.north_txt
            property alias intersect4: pt_1.east_txt
            property alias intersect5: pt_2.north_txt
            property alias intersect6: pt_2.east_txt
            property alias intersect7: xp_2.text
            property alias intersect8: yp_2.text
            property alias intersect9: s_1.text
            property alias intersect100: s_2.text
        }

        // Coordinate select from map dialog
        Loader {
            id: loadComponent
            anchors.fill: parent
            active: false
            sourceComponent: macomponent
        }
        // Coordinate select from map dialog
        Component.onDestruction: loadComponent.active = false
        Component {
            id: macomponent
            CoordSelect {
                id: mapDialog
                error_txt: xy_feature_error
                onClosed: {
                    if( selected && coordName === "pt_1" ) {
                        pt_1.east.text = xCoord
                        pt_1.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_2" ) {
                        pt_2.east.text = xCoord
                        pt_2.north.text = yCoord
                        selected = false
                    }
                }
            }
        }

        Column{
            id:optionsColumn
            spacing: 10
            anchors.topMargin    : 15
            anchors.bottomMargin : 15
            anchors.leftMargin :15
            anchors.rightMargin  : 15
            anchors.fill: parent
            // coordinate header NE OR XY
            NEHeader {}
            // Point 1
            NorthEastP {
                id: pt_1
                name: "P1"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_1"
                    loadComponent.item.open()
                }
            }
            // Point 2
            NorthEastP {
                id: pt_2
                name: "P2"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_2"
                    loadComponent.item.open()
                }
            }
            // angles alpha and beta
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:10
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    SText {text: "α: "; }
                    SAngle{ id: a2 }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    SText {text: "β: "; }
                    SAngle{ id: b2 }
                }
            }
            //-----------Hesap-------------------------------------------
            //Hesap Form
            Hesapla {
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.intersectioncalc()
                // Clear all text fields
                clear_list: [ pt_1.north, pt_1.east, pt_2.north, pt_2.east, xp_2, yp_2, s_1, s_2]
                clear.onClicked:{
                    clearAll();
                    Calc.angle_clear([a2, b2])
                }
            }


            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                layoutDirection: Calc.coord_display()
                spacing:10
                Row{
                    SText {text: Calc.textN() + "P: "; }
                    STextField{id:xp_2; readOnly:true}
                }
                Row{
                    SText {text: Calc.textE() + "P: "; }
                    STextField{id:yp_2; readOnly:true}
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:10
                Row{
                    SText {text: "|P1-P|:"; font.pixelSize: 12}
                    STextField{id:s_1; readOnly:true; implicitWidth: 100}
                }
                Row{
                    SText {text: "|P2-P|:"; font.pixelSize: 12}
                    STextField{id:s_2; readOnly:true; implicitWidth: 100}
                }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                height:geri.height
                width:geri.width
                color: "transparent"
                Image {
                    id:geri
                    width: 200
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/onden.png"
                }
            }
        }
    }
}
