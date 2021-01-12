import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1
import "../../components/common"
import "../../components/gis"
import "../../components/common/script.js" as Utils
import "js/latlongdist.js" as Hesap

// Latitude Longitude distance
Column {
    // Coordinate select from map dialog for LATITUDE LONGITUDE
    Loader {
        id: loadComponent
        parent: basic_surveying
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
            isGeographic: true
            error_txt: latlong_feature_error
            onClosed: {
                if ( selected && coordName === "dist_latlon1" ) {
                    dist_latlon1.lat_decimal.text = yCoord
                    dist_latlon1.lon_decimal.text = xCoord
                    selected = false
                }
                else if ( selected && coordName === "dist_latlon2" ) {
                    dist_latlon2.lat_decimal.text = yCoord
                    dist_latlon2.lon_decimal.text = xCoord
                    selected = false
                }
            }
        }
    }

    Column {
        spacing: 15
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Settings {
            id: latlong_settings
            property double length_metric;
            // Latitude and longitude
            property alias latdeg1: dist_latlon1.latdeg_txt
            property alias latmin1: dist_latlon1.latmin_txt
            property alias latsec1: dist_latlon1.latsec_txt
            property alias latdeg2: dist_latlon2.latdeg_txt
            property alias latmin2: dist_latlon2.latmin_txt
            property alias latsec2: dist_latlon2.latsec_txt
            property alias londeg1: dist_latlon1.londeg_txt
            property alias lonmin1: dist_latlon1.lonmin_txt
            property alias lonsec1: dist_latlon1.lonsec_txt
            property alias londeg2: dist_latlon2.londeg_txt
            property alias lonmin2: dist_latlon2.lonmin_txt
            property alias lonsec2: dist_latlon2.lonsec_txt
            // Remove it for Surveying Calculator
            //property alias decimal_check: decim.checked
            property alias londec1: dist_latlon1.lon_decimal_txt
            property alias londec2: dist_latlon2.lon_decimal_txt
            property alias latdec1: dist_latlon1.lat_decimal_txt
            property alias latdec2: dist_latlon2.lat_decimal_txt
            property alias azimuth2: azimuth_txt.text
            // Result
            // LatLOng result
            property alias dist_result:    dist.text
        }
        // Lat Long 1
        LatLong{
            id: dist_latlon1
            text_lat: "Latitude1 : "
            text_lon: "Longitude1 : "
            mapBtn.onClicked: {
                // send property to mapView component to detect which button is clicked
                loadComponent.active = true
                loadComponent.item.coordName = "dist_latlon1"
                loadComponent.item.open()
            }
        }
        // Lat Long 2
        LatLong {
            id: dist_latlon2
            text_lat: "Latitude2 : "
            text_lon: "Longitude2 : "
            mapBtn.onClicked: {
                // send property to mapView component to detect which button is clicked
                loadComponent.active = true
                loadComponent.item.coordName = "dist_latlon2"
                loadComponent.item.open()
            }
        }
        // Calculate
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Hesapla {
                id: hesap_btn
                decimalCheck: true
                // Calculate the result
                hesap.onClicked: Hesap.distance_latlong()
                // Clear all text fields
                clear_list: [
                    dist_latlon1.lat_deg, dist_latlon1.lat_min, dist_latlon1.lat_sec,
                    dist_latlon2.lat_deg, dist_latlon2.lat_min, dist_latlon2.lat_sec,
                    dist_latlon1.lon_deg, dist_latlon1.lon_min, dist_latlon1.lon_sec,
                    dist_latlon2.lon_deg, dist_latlon2.lon_min, dist_latlon2.lon_sec,
                    dist_latlon1.lon_decimal,dist_latlon2.lon_decimal,
                    dist_latlon1.lat_decimal,dist_latlon2.lat_decimal,
                    dist, azimuth_txt
                ]
                clear.onClicked:{
                    clearAll();
                }

            }
        }
        // Result
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "Distance: "
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                height: parent.height
            }
            STextField{
                id: dist
                implicitWidth: 150
                font.pixelSize: 16
                placeholderText: Utils.length_txt( )
                readOnly: true
            }
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "Azimuth: "
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                height: parent.height
            }
            STextField{
                id: azimuth_txt
                implicitWidth: 150
                font.pixelSize: 16
                placeholderText: "°"
                readOnly: true
            }
        }
    }
}
