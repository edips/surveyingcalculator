import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1
import "../../components/common"
import "../../components/gis"
import "../../components/common/script.js" as Utils
import "js/xycalc.js" as Hesap

Column {
    Loader {
        id: loadComponent
        parent: basic_surveying
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
            error_txt: xy_feature_error
            onClosed: {
                if( selected && coordName === "pt_a" ) {
                    pt_a.east.text = xCoord
                    pt_a.north.text = yCoord
                    selected = false
                } //else if(selected && coordName === "pt_b")
            }
        }
    }


    Column {
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
        spacing: 15
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter

        // Point A
        NorthEastP {
            id: pt_a
            name: "A"
            mapBtn.onClicked: {
                // send property to mapView component to detect which button is clicked
                loadComponent.active = true
                loadComponent.item.coordName = "pt_a"
                loadComponent.item.open()
            }
        }
        Column {
            id:row
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                SText {text: "AB: "; }
                STextField{ id: ab_to1; placeholderText: Utils.length_txt(); }
            }
            Row{
                SText {text: "(AB): "; }
                SAngle{id:abg_to1}
            }
        }
        //Hesap Form
        Hesapla {
            id: hesap_btn
            anchors.horizontalCenter: parent.horizontalCenter
            // Calculate the result
            hesap.onClicked: Hesap.firstcalc()
            // Clear all text fields
            clear_list: [  pt_b.north, pt_b.east, ab_to1, pt_a.north, pt_a.east ]
            clear.onClicked:{
                clearAll();
                Utils.angle_clear([abg_to1])
            }
        }
        NorthEastP {
            id: pt_b
            name: "B"
            readonly: true
        }
        Rectangle {
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
