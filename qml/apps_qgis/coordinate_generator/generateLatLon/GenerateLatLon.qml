import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../../components/common/script.js" as Calc
//import "generateLatLong.js" as Hesap
import "../../../apps/other_tools/libs/geographiclib.js" as GeoLib
import "../../../components/common"
import "../../../components/gis"
import "generateLatLong.js" as Hesap
Item{
    property var arr22 : []
    property int cogo_count: 0

    Settings{
        id:gnlatlon_settings
        property alias gn_interval: interval.text

        property alias gn_latlon2: latlon1.latdeg_txt
        property alias gn_latlon3: latlon1.latmin_txt
        property alias gn_latlon4: latlon1.latsec_txt

        property alias stg_latlon5: latlon1.londeg_txt
        property alias stg_latlon6: latlon1.lonmin_txt
        property alias stg_latlon7: latlon1.lonsec_txt

        property alias gn_latlon8: latlon2.latdeg_txt
        property alias gn_latlon9: latlon2.latmin_txt
        property alias gn_latlon10:latlon2.latsec_txt

        property alias gn_latlon11: latlon2.londeg_txt
        property alias gn_latlon12: latlon2.lonmin_txt
        property alias gn_latlon13: latlon2.lonsec_txt

        property alias gn_latlon22: latlon1.lat_decimal_txt
        property alias gn_latlon23: latlon1.lon_decimal_txt

        property alias gn_latlona24: latlon2.lat_decimal_txt
        property alias gn_latlon2s5: latlon2.lon_decimal_txt
    }

    // Generate coordinates from active layer dialog
    CoordinateList {
        id: coordList
        isGeographic: true
    }


    // Coordinate select from map dialog for LATITUDE LONGITUDE
    Loader {
        id: loadComponent
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
                if( selected && coordName === "latlon1" ) {
                    latlon1.lat_decimal.text = yCoord
                    latlon1.lon_decimal.text = xCoord
                    selected = false
                }
                else if( selected && coordName === "latlon2" ) {
                    latlon2.lat_decimal.text = yCoord
                    latlon2.lon_decimal.text = xCoord
                    selected = false
                }
            }
        }
    }

    SFlickable {

        id:optionsPage
        contentHeight: Math.max(macolumn.implicitHeight+65, height)
        anchors.topMargin: 15

        Column{
            id:macolumn
            width: parent.width
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter

            // Latitude Longitude Decimal
            Column {
                spacing: 10
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                LatLong{
                    id: latlon1
                    text_lat: "Latitude1 "
                    text_lon: "Longitude1 "
                    mapBtn.onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "latlon1"
                        loadComponent.item.open()
                    }
                }
                LatLong{
                    id: latlon2
                    text_lat: "Latitude2 "
                    text_lon: "Longitude2 "
                    mapBtn.onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "latlon2"
                        loadComponent.item.open()
                    }
                }
            }

            Column{
                id:col_dist
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Row{
                    SText {text: "Number of Intervals: "; font.bold: false;}
                    STextField{id:interval; implicitWidth: 45;font.pixelSize: 16}
                }
            }

            //-----------Hesap-------------------------------------
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                Hesapla {
                    id: hesap_btn
                    decimalCheck: true
                    // Calculate the result
                    hesap.onClicked: {
                        // variables;
                        var interv = interval.text
                        // Decimal
                        // Latitude 1
                        var lat_dc1 = parseFloat(latlon1.lat_decimal.text)
                        // Longitude 1
                        var lon_dc1 = parseFloat(latlon1.lon_decimal.text)
                        // Latitude 2
                        var lat_dc2 = parseFloat(latlon2.lat_decimal.text)
                        // Longitude 2
                        var lon_dc2 = parseFloat(latlon2.lon_decimal.text)

                        // DMS
                        // Latitude 1
                        var lat_degDMS1 = parseFloat( latlon1.lat_deg.text )
                        var lat_minDMS1 = parseFloat( latlon1.lat_min.text )
                        var lat_secDMS1 = parseFloat( latlon1.lat_sec.text )
                        // Longitıde 1
                        var lon_degDMS1 = parseFloat( latlon1.lon_deg.text )
                        var lon_minDMS1 = parseFloat( latlon1.lon_min.text )
                        var lon_secDMS1 = parseFloat( latlon1.lon_sec.text )
                        // Latitude 2
                        var lat_degDMS2 = parseFloat( latlon2.lat_deg.text )
                        var lat_minDMS2 = parseFloat( latlon2.lat_min.text )
                        var lat_secDMS2 = parseFloat( latlon2.lat_sec.text )
                        // Longitude 2
                        var lon_degDMS2 = parseFloat( latlon2.lon_deg.text )
                        var lon_minDMS2 = parseFloat( latlon2.lon_min.text )
                        var lon_secDMS2 = parseFloat( latlon2.lon_sec.text )

                        "use strict";

                        arr22 = [];

                        var geod = GeographicLib.Geodesic.WGS84,
                        dms = GeographicLib.DMS;

                        // library--------------------------------------------------------------------------------------------
                        (function(g) {
                            "use strict";
                            g.Geodesic.prototype.InversePath =
                                    function(lat1, lon1, lat2, lon2, maxk) {
                                        var line = this.InverseLine(lat1, lon1, lat2, lon2, g.STANDARD),
                                        k, points, da12, vals, i;
                                        // intervalin degeri yoksa default değer olarak 20 ata
                                        if (!maxk) maxk = 5;
                                        k = maxk
                                        points = new Array(k + 1);
                                        da12 = line.a13 / k;
                                        for (i = 0; i <= k; ++i) {
                                            vals = line.ArcPosition(i * da12);
                                            points[i] = {lat: vals.lat2, lon: vals.lon2, azi: vals.azi2};
                                        }
                                        return points;
                                    };

                        })(GeographicLib.Geodesic);

                        // format point
                        function formatpoint(lat, lon, array, prec) {
                            var trail;
                            return array.push([lat.toFixed(prec), lon.toFixed(prec)])
                        };

                        ///-LatLong Generator from intervals and distance

                        function geodesicInversePath(lat1, lon1, lat2, lon2, interval, array, prec) {
                            var result = {},
                            t, p1, p2, maxnum, i;
                            try {

                                t = geod.InversePath(String(lat1), String(lon1), String(lat2), String(lon2), String(interval));
                                for (i = 0; i < t.length; ++i)
                                    result.points +=
                                            formatpoint(t[i].lat, t[i].lon, array, prec);
                            }
                            catch (e) {
                                console.log("errorrrrr")
                            }
                            return result;
                        };
                        // End of the library


                        // decimal
                        if( hesap_btn.decimalActive ){
                            console.log("decimal is active")
                            if(latlon1.lat_decimal.text === "" || latlon2.lat_decimal.text === "" || latlon1.lon_decimal.text === "" || latlon2.lon_decimal.text === "" || interval.text === ""){
                                snack.open("Please enter the parameters.")
                            }
                            else if(interv <= 0){
                                snack.open("Intervals should be positive numbers.")
                            }
                            else if(interv >=1000){
                                snack.open("Intervals should be less than 1000.")
                            }
                            else{
                                arr22 = []
                                var t = geodesicInversePath(lat_dc1, lon_dc1, lat_dc2, lon_dc2, interv, arr22, 8);
                                var coords = arr22
                                if( coords.length > 0 ) {
                                    var coord_txt = ""
                                    // Be careful to do this for extracting list of coordinates!
                                    if( __appSettings.latlongOrder === "order_latlong" ) {
                                        for( var i = 0; i < coords.length; i++ ) {
                                            // x: coords[ i ][0]
                                            coord_txt += coords[ i ][0] + "  " + coords[ i ][1] + "\n"
                                        }
                                    } else {
                                        for( var k = 0; k < coords.length; k++ ) {
                                            // x: coords[ i ][0]
                                            coord_txt += coords[ k ][1] + "  " + coords[ k ][0] + "\n"
                                        }
                                    }

                                    coordList.editor.text = coord_txt
                                    coordList.open()
                                }
                            }
                        }
                        // DMS precision 3
                        else if ( !hesap_btn.decimalActive ){
                            console.log("DMS is active")
                            if(latlon1.lon_deg.text === "" || latlon2.lon_deg.text === "" || latlon1.lon_min.text === "" ||latlon2.lon_min.text === ""
                                    || latlon1.lat_deg.text === "" || latlon2.lat_deg.text === "" ||
                                    latlon1.lat_min.text === "" || latlon2.lat_min.text === "" || interval.text === "" ||
                                    latlon1.lat_sec.text === "" || latlon2.lat_sec.text === "" || latlon1.lon_sec.text === "" || latlon2.lon_sec.text === ""){
                                snack.open("Please enter the parameters.")
                            }
                            else if(interv <= 0){
                                snack.open("Intervals should be positive numbers.")
                            }
                            else if(interv >=1000){
                                snack.open("Intervals should be less than 1000.")
                            }
                            else{
                                var en1_dms = Math.abs(lat_degDMS1) + Math.abs(lat_minDMS1/60) + Math.abs(lat_secDMS1/3600)
                                if (lat_degDMS1<0){
                                    en1_dms=-en1_dms
                                }
                                var boy1_dms = Math.abs(lon_degDMS1) + Math.abs(lon_minDMS1/60) + Math.abs(lon_secDMS1/3600)
                                if (lon_degDMS1<0){
                                    boy1_dms=-boy1_dms
                                }
                                var en2_dms = Math.abs(lat_degDMS2) + Math.abs(lat_minDMS2/60) + Math.abs(lat_secDMS2/3600)
                                if (lat_degDMS2<0){
                                    en2_dms=-en2_dms
                                }
                                var boy2_dms = Math.abs(lon_degDMS2) + Math.abs(lon_minDMS2/60) + Math.abs(lon_secDMS2/3600)
                                if (lon_degDMS2<0){
                                    boy2_dms=-boy2_dms
                                }

                                arr22 = []
                                var t3 = geodesicInversePath(en1_dms, boy1_dms, en2_dms, boy2_dms, interv, arr22, 7);
                                var coords_dms = arr22
                                console.log("coord length: ", coords_dms.length)
                                if( coords_dms.length > 0 ) {
                                    var coord_txt_dms = ""
                                    // Be careful to do this for extracting list of coordinates!
                                    if( __appSettings.latlongOrder === "order_latlong" ) {
                                        for(var ii = 0; ii < coords_dms.length; ii++ ) {
                                            // x: coords_dms[ ii ][0]
                                            coord_txt_dms += coords_dms[ ii ][0] + "  " + coords_dms[ ii ][1] + "\n"
                                        }
                                    } else {
                                        for(var kk = 0; kk < coords_dms.length; kk++ ) {
                                            // x: coords_dms[ kk ][0]
                                            coord_txt_dms += coords_dms[ kk ][1] + "  " + coords_dms[ kk ][0] + "\n"
                                        }
                                    }

                                    coordList.editor.text = coord_txt_dms
                                    coordList.open()
                                }
                            }
                        }
                        // arrays should be eaqualized for unknown reason, if we do not do this, model doesn't set its index.

                    }

                    clear_list: [
                        interval, latlon1.lat_decimal, latlon1.lon_decimal, latlon2.lat_decimal, latlon2.lon_decimal,
                        latlon1.lat_deg, latlon1.lat_min, latlon1.lat_sec,
                        latlon1.lon_deg, latlon1.lon_min, latlon1.lon_sec,
                        latlon2.lat_deg, latlon2.lat_min, latlon2.lat_sec,
                        latlon2.lon_deg, latlon2.lon_min, latlon2.lon_sec,
                    ]
                    clear.onClicked:{
                        clearAll();
                    }
                }
            }
        }
    }
}
