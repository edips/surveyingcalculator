Qt.include( "../../../components/common/script.js" )
Qt.include( "../../other_tools/libs/geographiclib.js" )
// Lat Long distance function
function distance_latlong( ) {
    // DMS
    if( !hesap_btn.decimalCheck )
    {
        if(dist_latlon1.lat_deg.text === "" || dist_latlon1.lat_min.text === "" ||
                dist_latlon1.lat_sec.text === "" || dist_latlon2.lat_deg.text === "" ||
                dist_latlon2.lat_min.text === "" || dist_latlon2.lat_sec.text === "" ||
                dist_latlon1.lon_deg.text === "" || dist_latlon1.lon_min.text === "" ||
                dist_latlon1.lon_sec.text === "" || dist_latlon2.lon_deg.text === "" ||
                dist_latlon2.lon_min.text === "" || dist_latlon2.lon_sec.text === ""
                )
        {
            snack.open( qsTr( "Please enter the values." ) )
        }
        else {
            // DMS 1
            var deg1 = parseFloat( dist_latlon1.lat_deg.text )
            var dak1 = parseFloat( dist_latlon1.lat_min.text )
            var san1 = parseFloat( dist_latlon1.lat_sec.text )
            var bdeg1 = parseFloat( dist_latlon1.lon_deg.text )
            var bdak1 = parseFloat( dist_latlon1.lon_min.text )
            var bsan1 = parseFloat( dist_latlon1.lon_sec.text )
            // DMS 2
            var deg2 = parseFloat( dist_latlon2.lat_deg.text )
            var dak2 = parseFloat( dist_latlon2.lat_min.text )
            var san2 = parseFloat( dist_latlon2.lat_sec.text )
            var bdeg2 = parseFloat( dist_latlon2.lon_deg.text )
            var bdak2 = parseFloat( dist_latlon2.lon_min.text )
            var bsan2 = parseFloat( dist_latlon2.lon_sec.text )
            // Convert DMS to decimal
            var en1 = Math.abs( deg1 ) + Math.abs( dak1 / 60 ) + Math.abs( san1 / 3600 )
            if ( deg1 < 0 ) {
                en1 = -en1
            }
            var boy1 = Math.abs(bdeg1) + Math.abs( bdak1 / 60 ) + Math.abs( bsan1 / 3600 )
            if (bdeg1<0){
                boy1 = -boy1
            }
            var en2 = Math.abs(deg2) + Math.abs( dak2 / 60 ) + Math.abs( san2 / 3600 )
            if (deg2 < 0) {
                en2 = -en2
            }
            var boy2 = Math.abs( bdeg2 ) + Math.abs( bdak2 / 60 ) + Math.abs( bsan2 / 3600 )
            if (bdeg2 < 0 ) {
                boy2 = -boy2
            }
            //Degree calculus
            var Geodesic = GeographicLib.Geodesic,
            DMS = GeographicLib.DMS,
            geod = Geodesic.WGS84;
            var r = geod.Inverse( en1, boy1, en2, boy2 );
            var d = r.s12.toFixed(3)


            var azimuth = parseFloat( r.azi1.toFixed(6) )
            if( azimuth < 0 ) {
                azimuth += 360;
            }
            console.log("azimuth from 1 to 2: ", azimuth )

            azimuth_txt.text = azimuth
            // calculate distance based on units
            lengthUnits( dist, d )
        }
    }
    // Decimal
    else if ( hesap_btn.decimalCheck )
    {
        if( dist_latlon1.lat_decimal.text === "" || dist_latlon1.lon_decimal.text === "" || dist_latlon2.lat_decimal.text === "" || dist_latlon2.lon_decimal.text === "" )
        {
            snack.open(qsTr("Please enter the values."))
        }
        else{
            // decimal
            var den1 = parseFloat( dist_latlon1.lat_decimal.text )
            var den2 = parseFloat( dist_latlon2.lat_decimal.text )
            var dboy1 = parseFloat( dist_latlon1.lon_decimal.text )
            var dboy2 = parseFloat( dist_latlon2.lon_decimal.text )
            // Decimal calculus
            let Geodesic = GeographicLib.Geodesic,
            DMS = GeographicLib.DMS,
            geod = Geodesic.WGS84;
            var r2 = geod.Inverse( den1, dboy1, den2, dboy2 );

            let azimuth = parseFloat( r2.azi1.toFixed(6) )
            if( azimuth < 0 ) {
                azimuth += 360;
            }
            console.log("azimuth from 1 to 2: ", azimuth )

            azimuth_txt.text = azimuth

            let d2 =r2.s12.toFixed(3)
            // calculate based on units
            lengthUnits( dist, d2 )
        }
    }
}
