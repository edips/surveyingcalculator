import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../components/common/script.js" as Calc
import "wgs84.js" as Hesap
import "../other_tools/libs/proj4.js" as Proj4js
import QtLocation 5.6
import QtPositioning 5.6
import "../../components/common"
import "../../components/gis"


Item{
    // counter for GPS button on off
    property int mycount: 0
    Settings{
        id:wgs84settings
        // Tabbar index settings
        // LatLong to UTM page
        property alias degcheck:geoutm.checked
        // UTM to LatLOng Page
        property alias decimm:utmgeo.checked

        // Lat Long settings Decimal
        property alias wgs1:rect_input.lat_decimal_txt
        property alias wgs2:rect_input.lon_decimal_txt

        // Lat Long settings DMS
        // Latitude
        property alias wgs3:rect_input.latdeg_txt
        property alias wgs4:rect_input.londeg_txt
        property alias wgs5:rect_input.latmin_txt
        // Longitude
        property alias wgs6:rect_input.lonmin_txt
        property alias wgs7:rect_input.latsec_txt
        property alias wgs8:rect_input.lonsec_txt

        // Northing Easting UTM settings
        property alias wgs9:utm.north_txt
        property alias wgs10:utm.east_txt
        property alias wgs11:utm.zone_txt
        // Result of Northing Easting UTM settings
        property alias wgs12:utmres.north_txt
        property alias wgs13:utmres.east_txt
        property alias wgs14:utmres.zone_txt

        // Result of Lat Long DMS settings
        // Latitude Result
        property alias wgs15: rect_res.latdeg_txt
        property alias wgs16: rect_res.latmin_txt
        property alias wgs17: rect_res.latsec_txt
        // Longitude result
        property alias wgs18: rect_res.londeg_txt
        property alias wgs19: rect_res.lonmin_txt
        property alias wgs20: rect_res.lonsec_txt

        // Result of Lat Long decimal settings
        property alias wgs21: rect_res.lat_decimal_txt
        property alias wgs22: rect_res.lon_decimal_txt
        //property alias decimSettings: hesap_btn.decim
    }

    // Coordinate select from map dialog for LATITUDE LONGITUDE
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
                if( selected && coordName === "rect_input" ) {
                    rect_input.lat_decimal.text = yCoord
                    rect_input.lon_decimal.text = xCoord
                    selected = false
                }
            }
        }
    }
    SErrorDialog {
        id: errDialog
    }


    id:root_wgs
    width: parent.width
    height: parent.height
    // Flickable
    SFlickable {
        id:optionswgs
        // we added utmres height (northing and easting row height) because Column.implicitHeight doesn't automatically change
        contentHeight: wgs_column.implicitHeight
        width: parent.width
        Component.onCompleted: {
            // Clear Nan Values (when the app opens it sometimes gives Nan results)
            if( isNaN(rect_input.lat_decimal.text) || isNaN(rect_input.lon_decimal.text) || isNaN(rect_input.lat_deg.text) || isNaN(rect_input.lon_deg.text) || isNaN(rect_input.lat_min.text)
                    || isNaN(rect_input.lon_min.text) || isNaN(rect_input.lat_sec.text) || isNaN(rect_input.lon_sec.text))
            {
                rect_input.lat_decimal.text = ""
                rect_input.lon_decimal.text = ""
                rect_input.lat_deg.text = ""
                rect_input.lon_deg.text = ""
                rect_input.lat_min.text = ""
                rect_input.lon_min.text = ""
                rect_input.lat_sec.text = ""
                rect_input.lon_sec.text = ""
            }
        }
        // PositionSource to get currrent GPS coordinates
        PositionSource {
            id: src
            updateInterval: 1000
            // Active when the button is pressed
            active: Hesap.startgps(SharedWGS84.mycount)
            // Get the current position with Hesap.gps_active() function
            onPositionChanged: Hesap.gps_active()
        }
        // Main column
        Column{
            id: wgs_column
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15
            width: parent.width
            // Toolbar for Tabbar to be horizontal center of the app window
            TabBar{
                /* visible of degree decimal forms are active with this function:
                        Hesap.degdec_viz()
                    */
                id: bar
                //Universal.theme: Universal.Light
                width: parent.width
                background: Rectangle { color: Universal.chromeMediumColor; }
                TabButton{
                    id:geoutm;
                    checkable: true;
                    text: "Lat/Long to UTM";
                    font.bold: bar.currentIndex === 0 ? true : false
                    background: Rectangle {
                        color: bar.currentIndex === 0 ? Universal.listLowColor : Universal.chromeMediumColor
                    }
                }
                TabButton{
                    id:utmgeo;
                    checkable: true;
                    text: "UTM to Lat/Long";
                    font.bold: bar.currentIndex === 1 ? true : false
                    background: Rectangle {
                        color: bar.currentIndex === 1 ? Universal.listLowColor : Universal.chromeMediumColor
                    }
                }
            }

            // Input Form
            Rectangle {
                id:myrect2
                color:"transparent"
                height: 100
                width: utm.neWidth
                anchors.horizontalCenter: parent.horizontalCenter
                // Top Form Column
                Column{
                    id:mygrid2
                    spacing: 1
                    anchors.fill : parent
                    // LAT/LON
                    LatLong{
                        id:rect_input;
                        visible: Hesap.latlong_utm_viz();
                        mapBtn.onClicked: {
                            // send property to mapView component to detect which button is clicked
                            loadComponent.active = true
                            loadComponent.item.coordName = "rect_input"
                            coordinateSelector( loadComponent.item, errDialog )
                        }
                    }
                    // UTM result
                    NorthEast{id:utm; readonly: false; utm_exists: true; visible: Hesap.utm_latlong_viz(); }
                }
            }
            //Hesap Form
            Hesap{
                id: hesap_btn
                decimalCheck: true
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.wgs84()
                // Clear all text fields
                clear_list: [rect_input.lat_decimal, rect_input.lon_decimal, rect_input.lat_deg, rect_input.lat_min, rect_input.lat_sec, rect_input.lon_deg, rect_input.lon_min,
                    rect_input.lon_sec, rect_res.lat_decimal, rect_res.lon_decimal, rect_res.lat_deg, rect_res.lat_min, rect_res.lat_sec, rect_res.lon_deg, rect_res.lon_min,
                    rect_res.lon_sec, utm.northing, utm.easting, utm.zones, utmres.northing, utmres.easting, utmres.zones]
                clear.onClicked:{clearAll();}
            }
            // Result Form
            NorthEast{id:utmres; readonly: true; utm_exists: true; visible: Hesap.latlong_utm_viz(); }
            // lat long result
            LatLong{id:rect_res; visible: Hesap.utm_latlong_viz(); readonly: true; }
            // Accuracy Text
            STextTop {
                anchors.horizontalCenter: parent.horizontalCenter
                font.italic: true
                id: acrc
                visible: Hesap.startgps(SharedWGS84.mycount)
                text: "Accuracy: " + parseFloat((src.position.horizontalAccuracy).toFixed(2)) + " m"
            }

        }
    }
}
