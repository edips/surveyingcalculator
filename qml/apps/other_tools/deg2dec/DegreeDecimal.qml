import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3
import "../../../components/common"

Item{
    id: l_root
    height: 100
    width: parent.width

    // Visible option for the component
    property bool input: false

    // width of DMS lat long
    property int wDMS: txt_dms_lat.width + 2*latdeg.width + 110
    property int wDec: lon_decimal.width + txt_dec_lat.width + 10

    // Latitude and Longitude
    // Properties Decimal latlong
    property alias lat_decimal : lat_decimal
    property alias lon_decimal : lon_decimal

    // Properties DMS latlong
    property alias lat_deg : latdeg
    property alias lat_min : latmin
    property alias lat_sec : latsec

    property alias lon_deg : londeg
    property alias lon_min : lonmin
    property alias lon_sec : lonsec
    property bool readonly : false

    // properties DM latlong
    property alias lat_deg_dm : latdeg_dm
    property alias lat_min_dm : latmin_dm

    property alias lon_deg_dm : londeg_dm
    property alias lon_min_dm : lonmin_dm

    // Angle
    // Properties decimal angle
    property alias decimalang : decimal_ang
    // Properties DM angle
    property alias degdm_ang : deg_dm_ang
    property alias mindm_ang : min_dm_ang
    // Properties DMS angle
    property alias degdms_ang : deg_dms_ang
    property alias mindms_ang : min_dms_ang
    property alias secdms_ang : sec_dms_ang

    // Settings
    // Lat Long
    // DMS latlong
    property alias latdeg_txt: latdeg.text
    property alias latmin_txt: latmin.text
    property alias latsec_txt: latsec.text
    property alias londeg_txt: londeg.text
    property alias lonmin_txt: lonmin.text
    property alias lonsec_txt: lonsec.text
    // DM latlong
    property alias latdeg_dm_txt : latdeg_dm.text
    property alias latmin_dm_txt : latmin_dm.text
    property alias londeg_dm_txt : londeg_dm.text
    property alias lonmin_dm_txt : lonmin_dm.text
    // decimal latlong
    property alias lat_decimal_txt: lat_decimal.text
    property alias lon_decimal_txt: lon_decimal.text
    // Angle
    // Decimal angle
    property alias decimalang_txt : decimal_ang.text
    // DM angle
    property alias degdm_ang_txt : deg_dm_ang.text
    property alias mindm_ang_txt : min_dm_ang.text
    // DMS angle
    property alias degdms_ang_txt : deg_dms_ang.text
    property alias mindms_ang_txt : min_dms_ang.text
    property alias secdms_ang_txt : sec_dms_ang.text

    // text of lat lon angle
    property string text_lat: "Latitude "
    property string text_lon: "Longitude "
    property string txt_ang: "Angle "

    // LATITUDE AND LONGITUDE

    // Decimal latlong
    Rectangle{
        id:rect_decimal
        height: 100
        width: parent.width
        color: "transparent"
        visible:{
            if(input){
                if (dec2degree.checked === true && latlon.checked === true){
                    return true
                }
                else{
                    return false
                }
            }else{
                if (dec2degree.checked === false && latlon.checked === true){
                    return true
                }
                else{
                    return false
                }
            }
        }

        Column{
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle{
                id:rect_dec_lat
                // setting coordinate order

                anchors.horizontalCenter: parent.horizontalCenter
                width: wDec
                height: rect_decimal.height/2 + 5
                color: "transparent"
                SText{
                    id: txt_dec_lat
                    anchors.left: parent.left
                    text: l_root.text_lat
                    verticalAlignment: Text.AlignVCenter
                    height: londeg.height
                }

                Row {
                    anchors.left:txt_dec_lat.right
                    STextField{id:lat_decimal; placeholderText: "°"; readOnly: l_root.readonly}
                }
            }

            Rectangle{
                id:rect_dec_lon
                anchors.horizontalCenter: parent.horizontalCenter

                width: wDec
                height: rect_decimal.height/2 + 5
                color: "transparent"

                SText{
                    id: txt_dec_lon
                    anchors.left: parent.left
                    text: l_root.text_lon
                    verticalAlignment: Text.AlignVCenter
                    height: londeg.height
                }

                Row {
                    anchors.left:txt_dec_lon.right
                    STextField{id:lon_decimal; placeholderText: "°"; readOnly: l_root.readonly}
                }
            }
        }
    }

    // DM latlong
    Rectangle{
        //anchors.verticalCenter: parent.verticalCenter
        id:rect_dm
        height: 100
        width: parent.width

        color: "transparent"
        visible: {
            if(input){
                if (degree2dec.checked === true && dm.checked === true && latlon.checked === true){
                    return true
                }
                else{
                    return false
                }
            }else{
                if (degree2dec.checked === false && dm.checked === true && latlon.checked === true){
                    return true
                }
                else{
                    return false
                }
            }
        }

        Column{
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle{
                id: rect_dm_lat
                width: wDMS
                height: rect_dm.height/2 + 5
                color: "transparent"
                // setting coordinate order
                anchors.horizontalCenter: parent.horizontalCenter
                SText{
                    id: txt_dm_lat
                    anchors.left: parent.left
                    text: l_root.text_lat
                    verticalAlignment: Text.AlignVCenter
                    height: londeg.height
                }

                Row {
                    spacing: 5
                    anchors.left:txt_dm_lat.right
                    STextField{id:latdeg_dm; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; readOnly: l_root.readonly}
                    STextField{id:latmin_dm; implicitWidth: 120; placeholderText: "'";  font.pixelSize: 16; readOnly: l_root.readonly}
                }
            }

            Rectangle{
                id:rect_dm_lon
                width: wDMS
                height: rect_dm.height/2 + 5
                color: "transparent"
                // setting coordinate order
                anchors.horizontalCenter: parent.horizontalCenter
                SText{
                    id: txt_dm_lon
                    anchors.left: parent.left
                    text: l_root.text_lon
                    verticalAlignment: Text.AlignVCenter
                    height: londeg.height
                }

                Row {
                    spacing: 5
                    anchors.left:txt_dm_lon.right
                    STextField{id:londeg_dm; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; readOnly: l_root.readonly}
                    STextField{id:lonmin_dm; implicitWidth: 120; placeholderText: "'";  font.pixelSize: 16; readOnly: l_root.readonly}
                }
            }
        }
    }

    // DMS latlong
    Rectangle{
        //anchors.verticalCenter: parent.verticalCenter
        id:rect_dms
        height: 100
        width: parent.width

        color: "transparent"
        visible: {
            if(input){
                if (degree2dec.checked === true && dm.checked === false && latlon.checked === true){
                    return true
                }
                else{
                    return false
                }
            }else{
                if (degree2dec.checked === false && dm.checked === false && latlon.checked === true){
                    return true
                }
                else{
                    return false
                }
            }
        }

        Column{
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle{
                id: rect_dms_lat
                width: wDMS
                height: rect_dms.height/2 + 5
                color: "transparent"
                // setting coordinate order
                //anchors.horizontalCenter: parent.horizontalCenter
                SText{
                    id: txt_dms_lat
                    anchors.left: parent.left
                    text: l_root.text_lat
                    verticalAlignment: Text.AlignVCenter
                    height: londeg.height
                }

                Row {
                    spacing: 5
                    anchors.left:txt_dms_lat.right
                    STextField{id:latdeg; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; readOnly: l_root.readonly}
                    STextField{id:latmin; implicitWidth: 35; placeholderText: "'";  font.pixelSize: 16; readOnly: l_root.readonly}
                    STextField{id:latsec; implicitWidth: 100; placeholderText: "''";font.pixelSize: 16; readOnly: l_root.readonly}
                }
            }

            Rectangle{
                id:rect_dms_lon
                width: wDMS
                height: rect_dms.height/2 + 5
                color: "transparent"
                // setting coordinate order
                //anchors.horizontalCenter: parent.horizontalCenter
                SText{
                    id: txt_dms_lon
                    anchors.left: parent.left
                    text: l_root.text_lon
                    verticalAlignment: Text.AlignVCenter
                    height: londeg.height
                }

                Row {
                    spacing: 5
                    anchors.left:txt_dms_lon.right
                    STextField{id:londeg; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; readOnly: l_root.readonly}
                    STextField{id:lonmin; implicitWidth: 35; placeholderText: "'";  font.pixelSize: 16; readOnly: l_root.readonly}
                    STextField{id:lonsec; implicitWidth: 100; placeholderText: "''";font.pixelSize: 16; readOnly: l_root.readonly}
                }
            }
        }
    }


    // ANGLE
    // Decimal Angle
    Rectangle{
        id:rect_decimal_ang
        height: 100
        width: parent.width
        color: "transparent"
        visible: {
            if(input){
                if (dec2degree.checked === true && latlon.checked === false){
                    return true
                }
                else{
                    return false
                }
            }else{
                if (dec2degree.checked === false && latlon.checked === false){
                    return true
                }
                else{
                    return false
                }
            }
        }

        Rectangle{
            id:rect_dec_ang
            anchors.horizontalCenter: parent.horizontalCenter

            width: wDec
            height: parent.height/2 + 5
            color: "transparent"

            SText{
                id: txt_dec_ang
                anchors.left: parent.left
                text: l_root.txt_ang
                verticalAlignment: Text.AlignVCenter
                height: londeg.height
            }

            Row {
                anchors.left:txt_dec_ang.right
                STextField{id: decimal_ang; placeholderText: "°"; readOnly: l_root.readonly}
            }
        }
    }

    // DM Angle
    Rectangle{
        //anchors.verticalCenter: parent.verticalCenter
        id:rect_dm_ang
        height: 100
        width: parent.width

        color: "transparent"
        visible: {
            if(input){
                if (degree2dec.checked === true && dm.checked === true && latlon.checked === false){
                    return true
                }
                else{
                    return false
                }
            }else{
                if (degree2dec.checked === false && dm.checked === true && latlon.checked === false){
                    return true
                }
                else{
                    return false
                }
            }
        }
        Rectangle{
            id: rect_dm_angle
            width: wDMS
            height: parent.height/2 + 5
            color: "transparent"
            // setting coordinate order
            anchors.horizontalCenter: parent.horizontalCenter
            SText{
                id: txt_dm_ang
                anchors.left: parent.left
                text: l_root.txt_ang
                verticalAlignment: Text.AlignVCenter
                height: londeg.height
            }

            Row {
                spacing: 5
                anchors.left:txt_dm_ang.right
                STextField{id: deg_dm_ang; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; readOnly: l_root.readonly}
                STextField{id: min_dm_ang; implicitWidth: 120; placeholderText: "'";  font.pixelSize: 16; readOnly: l_root.readonly}
            }
        }
    }

    // DMS Angle
    Rectangle{
        //anchors.verticalCenter: parent.verticalCenter
        id:rect_dms_ang
        height: 100
        width: parent.width

        color: "transparent"
        visible: {
            if(input){
                if (degree2dec.checked === true && dm.checked === false && latlon.checked === false){
                    return true
                }
                else{
                    return false
                }
            }else{
                if (degree2dec.checked === false && dm.checked === false && latlon.checked === false){
                    return true
                }
                else{
                    return false
                }
            }
        }
        Rectangle{
            id: rect_dms_angle
            width: wDMS
            height: parent.height/2 + 5
            color: "transparent"
            // setting coordinate order
            anchors.horizontalCenter: parent.horizontalCenter
            SText{
                id: txt_dms_ang
                anchors.left: parent.left
                text: l_root.txt_ang
                verticalAlignment: Text.AlignVCenter
                height: londeg.height
            }

            Row {
                spacing: 5
                anchors.left:txt_dms_ang.right
                STextField{id:deg_dms_ang; implicitWidth: 40; placeholderText: "°";  font.pixelSize: 16; readOnly: l_root.readonly}
                STextField{id:min_dms_ang; implicitWidth: 35; placeholderText: "'";  font.pixelSize: 16; readOnly: l_root.readonly}
                STextField{id:sec_dms_ang; implicitWidth: 100; placeholderText: "''";font.pixelSize: 16; readOnly: l_root.readonly}
            }
        }
    }

}
