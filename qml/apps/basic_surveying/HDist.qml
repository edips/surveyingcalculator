import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1
import QtQuick.Layouts 1.12
import "../../components/common"
import "../../components/gis"
import "../../components/common/script.js" as Utils
import "js/dist2d.js" as Hesap

Column {
    // Coordinate select from map dialog for LATITUDE LONGITUDE
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
                if ( selected && coordName === "dist2d_1" ) {
                    dist2d_1.east.text = xCoord
                    dist2d_1.north.text = yCoord
                    selected = false
                }
                else if ( selected && coordName === "dist2d_2" ) {
                    dist2d_2.east.text = xCoord
                    dist2d_2.north.text = yCoord
                    selected = false
                }
            }
        }
    }

    Column {
        Settings {
            id: mycombooo
            // input
            property alias easting1:       dist2d_1.east_txt
            property alias northing1:      dist2d_1.north_txt
            property alias easting2:       dist2d_2.east_txt
            property alias northing2:      dist2d_2.north_txt
            // result
            property alias distance2d:    dist_2d.text
            property alias dsabg_to2_dec: abg_to2.decimal_txt
            property alias dsabg_to2_deg: abg_to2.degree_txt
            property alias dsabg_to2_min: abg_to2.minute_txt
            property alias dsabg_to2_sec: abg_to2.second_txt
            property alias dsabg_to2_gon: abg_to2.gon_txt
        }
        spacing: 15
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter

        NEHeader {rightPadding: 50; }
        // Point A
        NorthEastP{
            id: dist2d_1
            name: "1"
            mapBtn.onClicked: {
                // send property to mapView component to detect which button is clicked
                loadComponent.active = true
                loadComponent.item.coordName = "dist2d_1"
                loadComponent.item.open()
            }
        }
        // Point B
        NorthEastP{
            id: dist2d_2
            name: "2"
            mapBtn.onClicked: {
                // send property to mapView component to detect which button is clicked
                loadComponent.active = true
                loadComponent.item.coordName = "dist2d_2"
                loadComponent.item.open()
            }
        }
        // Calculation
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Hesapla {
                id: hesap_btn
                decimalCheck: false
                // Calculate the result
                hesap.onClicked: Hesap.calc2d()
                // Clear all text fields
                clear_list: [ dist2d_1.east, dist2d_1.north, dist2d_2.east, dist2d_2.north, dist_2d ]
                clear.onClicked:{
                    clearAll();
                    Utils.angle_clear( [ abg_to2 ] )
                }
            }
        }
        // result
        Column {
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter
            // Distance
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    text: "Distance: "
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                }
                STextField{
                    id: dist_2d
                    implicitWidth: 150
                    font.pixelSize: 16
                    readOnly: true
                    placeholderText: Utils.length_txt( )
                }
            }
            // Bearing
            Row{
                Label {
                    text: "Bearing: "
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                }
                SAngle{ read_only: true; id:abg_to2 }
            }
        }
    }
}
