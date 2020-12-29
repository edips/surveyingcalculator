import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../../components/common/script.js" as Calc
import "degdec.js" as Hesap
import "../../../components/common"
//"../../components/common"
Item{
    SFlickable {
        id:optionsPage
        contentHeight: main_column.implicitHeight
        // Settings
        Settings{
            id:deg2dec_settings
            // controls
            property alias tabdeg: degree2dec.checked
            property alias tabdec: dec2degree.checked
            property alias dmcheck_dg : dm.checked
            property alias latlong_check : latlon.checked

            // Angle DMS, DM and decimal
            property alias input_deg_dms: input_field.degdms_ang_txt
            property alias input_min_dms: input_field.mindms_ang_txt
            property alias input_sec_dms: input_field.secdms_ang_txt

            property alias input_deg_dm: input_field.degdm_ang_txt
            property alias input_min_dm: input_field.mindm_ang_txt

            property alias input_decimal:input_field.decimalang_txt

            // Lat Long settings Decimal
            property alias input_lat_decimal_txt:input_field.lat_decimal_txt
            property alias input_lon_decimal_txt:input_field.lon_decimal_txt

            // Lat Long settings DMS
            // Latitude
            property alias input_latdeg_txt:input_field.latdeg_txt
            property alias input_latmin_txt:input_field.latmin_txt
            property alias input_latsec_txt:input_field.latsec_txt
            // Longitude
            property alias input_londeg_txt:input_field.londeg_txt
            property alias input_lonmin_txt:input_field.lonmin_txt
            property alias input_lonsec_txt:input_field.lonsec_txt

            // Lat Long settings DM
            // Latitude
            property alias input_latdeg_dm_txt:input_field.latdeg_dm_txt
            property alias input_latmin_dm_txt:input_field.latmin_dm_txt
            // Longitude
            property alias input_londeg_dm_txt:input_field.londeg_dm_txt
            property alias input_lonmin_dm_txt:input_field.lonmin_dm_txt

            // Result of Lat Long DMS settings
            // Latitude Result
            property alias output_latdeg_txt: output_field.latdeg_txt
            property alias output_latmin_txt: output_field.latmin_txt
            property alias output_latsec_txt: output_field.latsec_txt
            // Longitude result
            property alias output_londeg_txt: output_field.londeg_txt
            property alias output_lonmin_txt: output_field.lonmin_txt
            property alias output_lonsec_txt: output_field.lonsec_txt
            // Result Lat Long settings DM
            // Latitude
            property alias output_latdeg_dm_txt:output_field.latdeg_dm_txt
            property alias output_latmin_dm_txt:output_field.latmin_dm_txt
            // Longitude
            property alias output_londeg_dm_txt:output_field.londeg_dm_txt
            property alias output_lonmin_dm_txt:output_field.lonmin_dm_txt

            // Result of Lat Long decimal settings
            property alias output_lat_decimal_txt: output_field.lat_decimal_txt
            property alias output_lon_decimal_txt: output_field.lon_decimal_txt

            // Angle Decimal, DM and DMS
            property alias output_deg_dms: output_field.degdms_ang_txt
            property alias output_min_dms: output_field.mindms_ang_txt
            property alias output_sec_dms: output_field.secdms_ang_txt

            property alias output_deg_dm: output_field.degdm_ang_txt
            property alias output_min_dm: output_field.mindm_ang_txt

            property alias output_decimal:output_field.decimalang_txt
        }
    //---------------Derece Başlangıç-----------------------------
        // Main column
        Column{
            id: main_column
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            // Toolbar for Tabbar to be horizontal center of the app window
            TabBar{
                    /* visible of degree decimal forms are active with this function:
                        Hesap.degdec_viz()
                    */
                    id: bar
                    width: parent.width
                    background: Rectangle { color: Universal.chromeMediumColor; }
                    TabButton{
                        id:degree2dec;
                        checkable: true;
                        text: "Degree to Decimal";
                        font.bold: bar.currentIndex === 0 ? true : false
                        background: Rectangle {
                            color: bar.currentIndex === 0 ? Universal.listLowColor : Universal.chromeMediumColor
                        }
                    }
                    TabButton{
                        id:dec2degree;
                        checkable: true;
                        text: "Decimal to Degree";
                        font.bold: bar.currentIndex === 1 ? true : false
                        background: Rectangle {
                            color: bar.currentIndex === 1 ? Universal.listLowColor : Universal.chromeMediumColor
                        }
                    }
                }

            Rectangle{
                height: 5
                width: 5
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            DegreeDecimal{
                id: input_field
                input: true
            }
            Hesap{
                id: hesaplak
                row_spacing: 50
                anchors.horizontalCenter: parent.horizontalCenter
                hesap.onClicked: Hesap.degtodec()
                // Clear all text fields
                clear_list: [
                    input_field.degdms_ang,
                    input_field.mindms_ang,
                    input_field.secdms_ang,
                    input_field.degdm_ang,
                    input_field.mindm_ang,
                    input_field.decimalang,
                    input_field.lat_decimal,
                    input_field.lon_decimal,
                    input_field.lat_deg,
                    input_field.lat_min,
                    input_field.lat_sec,
                    input_field.lon_deg,
                    input_field.lon_min,
                    input_field.lon_sec,
                    input_field.lat_deg_dm,
                    input_field.lat_min_dm,
                    input_field.lon_deg_dm,
                    input_field.lon_min_dm,

                    output_field.degdms_ang,
                    output_field.mindms_ang,
                    output_field.secdms_ang,
                    output_field.degdm_ang,
                    output_field.mindm_ang,
                    output_field.decimalang,
                    output_field.lat_decimal,
                    output_field.lon_decimal,
                    output_field.lat_deg,
                    output_field.lat_min,
                    output_field.lat_sec,
                    output_field.lon_deg,
                    output_field.lon_min,
                    output_field.lon_sec,
                    output_field.lat_deg_dm,
                    output_field.lat_min_dm,
                    output_field.lon_deg_dm,
                    output_field.lon_min_dm
                ]
                clear.onClicked:{clearAll();}
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                CheckBox{
                    id:latlon
                    //height: hesaplak.height
                    text:"Lat Long"
                    checked: true
                }
                CheckBox{
                    id:dm
                    //height: hesaplak.height
                    text:"Degree Minute"
                    checked: false
                }
             }
            DegreeDecimal{
                id: output_field
                readonly: true
            }
        }
    }
}
