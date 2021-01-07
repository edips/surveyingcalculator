import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../../components/common/script.js" as Calc
import "circle.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
import "../../../components/gis"
Item{
    SFlickable{
        id:optizz
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:mysetting45
            property alias circle1: pt_k.north_txt
            property alias circle2: pt_k.east_txt
            property alias circle3: pt_l.north_txt
            property alias circle4: pt_l.east_txt
            property alias circle5: pt_m.north_txt
            property alias circle6: pt_m.east_txt
            property alias circle7: pt_c.north_txt
            property alias circle8: pt_c.east_txt
            property alias circle9: rc.text
            property alias circle10: area.text
            property alias circle11: per.text
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
                    if( selected && coordName === "pt_k" ) {
                        pt_k.east.text = xCoord
                        pt_k.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_l" ) {
                        pt_l.east.text = xCoord
                        pt_l.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_m" ) {
                        pt_m.east.text = xCoord
                        pt_m.north.text = yCoord
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
            // coordinate header NE OR XY
            NEHeader {}
            // Point K
            NorthEastP{
                id: pt_k
                name: "K"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_k"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            // Point L
            NorthEastP{
                id: pt_l
                name: "L"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_l"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            // Point M
            NorthEastP{
                id: pt_m
                name: "M"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_m"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            //Hesap Form
            Hesapla {
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.circlecalc()
                // Clear all text fields
                clear_list: [ pt_k.north, pt_k.east, pt_l.north, pt_l.east, pt_m.north, pt_m.east, pt_c.north, pt_c.east,
                    rc, area, per]
                clear.onClicked:{
                    clearAll();
                }
            }

            NEHeader {}
            // Point C
            NorthEastP{
                id: pt_c
                name: "C"
                readonly: true
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                SText {text: qsTr("Radius: "); }
                STextField{id:rc; readOnly:true; }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter

                Row{
                    SText {text: qsTr("Area:"); }
                    STextField{id:area; implicitWidth: 100; readOnly:true; }
                }
                Row{
                    SText {text: qsTr("Perimeter:"); }
                    STextField{id:per; implicitWidth: 100; readOnly:true; }
                }
            }
            Rectangle{
                height:geri.height
                width:geri.width
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    width: 200
                    fillMode: Image.PreserveAspectFit
                    id:geri
                    source:"qrc:/assets/images/circle.png"
                }
            }
        }
    }
}
