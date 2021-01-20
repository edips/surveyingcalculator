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

import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1
import "../../components/common"
import "../../components/gis"
import "../../components/common/script.js" as Utils
import "js/latlongcalc.js" as Hesap

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
                if ( selected && coordName === "rect_input" ) {
                    rect_input.lat_decimal.text = yCoord
                    rect_input.lon_decimal.text = xCoord
                    selected = false
                }
            }
        }
    }

    Column {
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
        spacing: 15
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        // input latitude longitude
        LatLong {
            id: rect_input
            mapBtn.onClicked: {
                // send property to mapView component to detect which button is clicked
                loadComponent.active = true
                loadComponent.item.coordName = "rect_input"
                loadComponent.item.open()
            }
        }
        // distance bearing
        Column{
            id:col_dist
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter
            Row{
                SText {text: "Distance: "}
                STextField{id:dist; implicitWidth: 150; placeholderText: Utils.length_txt(); }
            }
            Row{
                SText {text: "Azimuth: "}
                SAngle{id:bearing}
            }
        }
        //-----------Hesap-------------------------------------
        Hesapla {
            id: hesap_btn
            decimalCheck: true
            anchors.horizontalCenter: parent.horizontalCenter
            hesap.onClicked: Hesap.distancecalc()

            clear_list: [rect_input.lat_deg, rect_input.lat_min, rect_input.lat_sec,rect_input.lon_deg, rect_input.lon_min,
                rect_input.lon_sec, dist, rect_res.lat_deg, rect_res.lat_min, rect_res.lat_sec, rect_res.lon_deg, rect_res.lon_min,
                rect_res.lon_sec, rect_res.lat_decimal, rect_res.lon_decimal, rect_input.lat_decimal, rect_input.lon_decimal]
            clear.onClicked:{
                clearAll()
                Utils.angle_clear( [ bearing ] )
            }
        }


        // lat long result
        LatLong {
            id: rect_res
            readonly: true
        }
    }
}
