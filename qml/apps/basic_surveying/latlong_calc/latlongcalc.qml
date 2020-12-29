import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../../" 1.0
//import Shared 1.0
import "../../../components/common/script.js" as Util
import "latlongcalc.js" as Hesap
import "../../other_tools/libs/geographiclib.js" as MyGeo
import "../../../components/common"
import "../../../components/gis"
Item{
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(wgs_column.implicitHeight)
        Settings{
            id:dist_settings

            property alias bearing_to2_dec: bearing.decimal_txt
            property alias bearing_to2_deg: bearing.degree_txt
            property alias bearing_to2_min: bearing.minute_txt
            property alias bearing_to2_sec: bearing.second_txt
            property alias bearing_to2_gon: bearing.gon_txt

            property alias stg_latlon1: dist.text

            property alias stg_latlon2: rect_input.latdeg_txt
            property alias stg_latlon3: rect_input.latmin_txt
            property alias stg_latlon4: rect_input.latsec_txt

            property alias stg_latlon5: rect_input.londeg_txt
            property alias stg_latlon6: rect_input.lonmin_txt
            property alias stg_latlon7: rect_input.lonsec_txt

            property alias stg_latlon12: rect_input.lat_decimal_txt
            property alias stg_latlon13: rect_input.lon_decimal_txt

            property alias stg_latlon14: rect_res.latdeg_txt
            property alias stg_latlon15: rect_res.latmin_txt
            property alias stg_latlon16: rect_res.latsec_txt

            property alias stg_latlon17: rect_res.londeg_txt
            property alias stg_latlon18: rect_res.lonmin_txt
            property alias stg_latlon19: rect_res.lonsec_txt

            property alias stg_latlon24: rect_res.lat_decimal_txt
            property alias stg_latlon25: rect_res.lon_decimal_txt
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


        //--------Lat/Lon Distance calculation DMS------------------------------------------------
        // Main column
        Column{
            id: wgs_column
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15
            width: parent.width
            topPadding: 15
            // input latitude longitude
            LatLong {
                id: rect_input
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "rect_input"
                    coordinateSelector( loadComponent.item, errDialog )
                }
            }
            // distance bearing
            Column{
                id:col_dist
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                Row{
                    SText {text: "Distance: "}
                    STextField{id:dist; implicitWidth: 150; placeholderText: "m"}
                }
                Row{
                    SText {text: "Bearing: "}
                    SAngle{id:bearing}
                }
            }
            //-----------Hesap-------------------------------------
            Hesap{
                id: hesap_btn
                decimalCheck: true
                anchors.horizontalCenter: parent.horizontalCenter
                hesap.onClicked: Hesap.distancecalc()

                clear_list: [rect_input.lat_deg, rect_input.lat_min, rect_input.lat_sec,rect_input.lon_deg, rect_input.lon_min,
                    rect_input.lon_sec, dist, rect_res.lat_deg, rect_res.lat_min, rect_res.lat_sec, rect_res.lon_deg, rect_res.lon_min,
                    rect_res.lon_sec, rect_res.lat_decimal, rect_res.lon_decimal, rect_input.lat_decimal, rect_input.lon_decimal]
                clear.onClicked:{
                    clearAll()
                    Util.angle_clear([bearing])
                }
            }


            // lat long result
            LatLong{
                id:rect_res
                readonly: true
            }

        }
    }
}
