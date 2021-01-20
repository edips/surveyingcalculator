/***************************************************************************
  Copyright            : (C) 2021 by Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "script.js" as Util

Item{
    id: l_root
    height: 100
    width: 255
    anchors.horizontalCenter: parent.horizontalCenter
    // coordinate select button
    property alias mapBtn: btn
    // width of DMS lat long
    property int wDMS: txt_dms_lat.width + 2*latdeg.width + 100
    property int wDec: lon_decimal.width + txt_dec_lat.width + 10
    // Properties Decimal
    property alias lat_decimal : lat_decimal
    property alias lon_decimal : lon_decimal
    // Properties DMS
    property alias lat_deg : latdeg
    property alias lat_min : latmin
    property alias lat_sec : latsec

    property alias lon_deg : londeg
    property alias lon_min : lonmin
    property alias lon_sec : lonsec
    property bool readonly : false

    // for settings
    property alias latdeg_txt: latdeg.text
    property alias latmin_txt: latmin.text
    property alias latsec_txt: latsec.text
    property alias londeg_txt: londeg.text
    property alias lonmin_txt: lonmin.text
    property alias lonsec_txt: lonsec.text
    property alias lat_decimal_txt: lat_decimal.text
    property alias lon_decimal_txt: lon_decimal.text

    // text of lat lon
    property string text_lat: "Latitude "
    property string text_lon: "Longitude "

    // todo: edit comments
    // Coordinate Selector function opens coordinate selector dialog if the coordinate input is convenient for the coordinate system
    // if the input coordinates are XY and current project is in projected CRS, it opens the coordinate chooser dialog, else it gives error as it isn't projected crs
    // if the input coordinates are latitude and longitude and the current project CRS is in geographic, coordinate chooser dialog opens, else it gives error
    // as it isn't geographic crs
    // requirements: mapDialog: CoordinateSelect Dialog, and errDialog Error dialog ID


    // Decimal
    Rectangle {
        //anchors.verticalCenter: parent.verticalCenter
        id:rect_decimal
        height: 100
        width: parent.width
        color: "transparent"
        visible: Util.coord_display_latlong()

        anchors.horizontalCenter: parent.horizontalCenter

        // Latitude
        Rectangle {
            id:rect_dec_lat
            // setting coordinate order
            anchors.top: {
                if(Util.coord_order_latlon() === "lonlat"){
                    return rect_dec_lon.bottom
                }else{
                    return parent.top
                }
            }

            anchors.left: parent.left
            width: wDec
            height: parent.height/2 + 5
            color: "transparent"
            SText {
                id: txt_dec_lat
                anchors.left: parent.left
                text: l_root.text_lat
                verticalAlignment: Text.AlignVCenter
                height: londeg.height
            }

            Row {
                anchors.left:txt_dec_lat.right
                STextField{ id:lat_decimal; placeholderText: "°"; readOnly: l_root.readonly}
            }
        }
        // Longitude
        Rectangle {
            id:rect_dec_lon
            anchors.top: {
                if(Util.coord_order_latlon() === "lonlat"){
                    return parent.top
                }else{
                    return rect_dec_lat.bottom
                }
            }
            anchors.left: parent.left

            width: wDec
            height: parent.height/2
            color: "transparent"

            SText {
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

        Button {
            id: btn
            visible: !readonly
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: rect_dec_lon.right
            height: lon_decimal.height
            anchors.leftMargin: 15
            icon.source: "qrc:/assets/icons/material/maps/map.svg"
        }

    }


    // DMS
    Rectangle{
        //anchors.verticalCenter: parent.verticalCenter
        id:rect_dms
        height: 100
        width: parent.width

        color: "transparent"
        visible: !Util.coord_display_latlong()
        Rectangle{
            id: rect_dms_lat
            width: wDMS
            height: parent.height/2 + 5
            color: "transparent"
            // setting coordinate order
            anchors.top:{
                if(Util.coord_order_latlon() === "lonlat"){
                    return rect_dms_lon.bottom
                }else{
                    return parent.top
                }
            }
            anchors.horizontalCenter: parent.horizontalCenter
            SText {
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

        Rectangle {
            id:rect_dms_lon
            width: wDMS
            height: parent.height/2 + 5
            color: "transparent"
            // setting coordinate order
            anchors.top:{
                if(Util.coord_order_latlon() === "lonlat"){
                    return parent.top
                }else{
                    return rect_dms_lat.bottom
                }
            }
            anchors.horizontalCenter: parent.horizontalCenter
            SText {
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
