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

Qt.include( "../../../components/common/script.js" )
Qt.include( "../../other_tools/libs/geographiclib.js" )
function distancecalc() {
    //---------LAT LON -----------------------------------------------------------------------------------------------
    // Degree minute second (DMS)
    var lat_deg = parseFloat( rect_input.lat_deg.text )
    var lat_min = parseFloat( rect_input.lat_min.text )
    var lat_sec = parseFloat( rect_input.lat_sec.text )
    var lon_deg = parseFloat( rect_input.lon_deg.text )
    var lon_min = parseFloat( rect_input.lon_min.text )
    var lon_sec = parseFloat( rect_input.lon_sec.text )
    var lat_dec = parseFloat( rect_input.lat_decimal.text )
    var long_dec = parseFloat( rect_input.lon_decimal.text )
    // angle fonksiyonu kullanilir
    var bearing_
    // for grad unit mysetting2.anglechooser === 1
    if( __appSettings.angleUnit === 2 ) {
        bearing_ = angle_text_input( bearing ) * ( 180 / 200 )
    } else {
        bearing_ = angle_text_input( bearing )
    }
    var dist_ = parseFloat( units2meter( dist.text ) )
    console.log("dist of latlong: ", dist_ )

    // DMS
    var en1 = Math.abs( lat_deg ) + Math.abs( lat_min / 60 ) + Math.abs( lat_sec / 3600 )
    if ( lat_deg < 0 ) {
        en1 = -en1
    }
    var boy1 = Math.abs( lon_deg ) + Math.abs( lon_min / 60 ) + Math.abs( lon_sec / 3600 )
    if ( lon_deg < 0 ) {
        boy1 = -boy1
    }

    // Decimal calculus----------------------------------------------------
    var Geodesic = GeographicLib.Geodesic,
    DMS = GeographicLib.DMS,
    geod = Geodesic.WGS84;
    var r1 = geod.Direct( lat_dec, long_dec, bearing_, dist_ );
    var lat_res1 = r1.lat2.toFixed( 8 )
    var lon_res1 = r1.lon2.toFixed( 8 )

    //Degree minute second (DMS) calculus---------------------------------------------------
    var r3 = geod.Direct( en1, boy1, bearing_, dist_ );
    var lat_res3 = r3.lat2.toFixed( 8 )
    var lon_res3 = r3.lon2.toFixed( 8 )
    //----------------------------------------------------------------------
    function distance() {
        // Decimal
        if( hesap_btn.decimalActive ) {
            if( rect_input.lat_decimal.text === "" || rect_input.lon_decimal.text === "" )
            {
                snack.open( qsTr("Please enter the values.") )
            }
            else{
                rect_res.lat_decimal.text = lat_res1
                rect_res.lon_decimal.text = lon_res1
            }
        }
        // DMS
        else if( !hesap_btn.decimalActive ) {
            if( rect_input.lat_deg.text === "" || rect_input.lat_min.text === "" || rect_input.lat_sec.text === ""
                    || rect_input.lon_deg.text === "" || rect_input.lon_min.text === "" || rect_input.lon_sec.text === "" )
            {
                snack.open( qsTr("Please enter the values.") )
            }
            else{
                // Conversion of DMS to decimal:
                var latintdeg_dms = parseInt( lat_res3 )
                var latintmin_dms = parseInt( ( lat_res3-latintdeg_dms ) * 60 )
                var latsec_dms = ( lat_res3 - latintdeg_dms - latintmin_dms / 60 ) * 3600
                rect_res.lat_deg.text = latintdeg_dms
                rect_res.lat_min.text = Math.abs( latintmin_dms )
                rect_res.lat_sec.text=( Math.abs( latsec_dms ) ).toFixed( 4 )

                var lonintdeg_dms = parseInt( lon_res3 )
                var lonintmin_dms = parseInt( ( lon_res3 - lonintdeg_dms ) * 60 )
                var londecsn_dms = ( lon_res3 - lonintdeg_dms - lonintmin_dms / 60 ) * 3600
                rect_res.lon_deg.text = lonintdeg_dms
                rect_res.lon_min.text = Math.abs( lonintmin_dms )
                rect_res.lon_sec.text = ( Math.abs( londecsn_dms ) ).toFixed( 4 )
            }
        }
    }

    String( distance() )
}
