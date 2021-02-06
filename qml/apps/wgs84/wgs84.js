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

Qt.include("../../apps/other_tools/libs/proj4.js")
Qt.include("../../components/common/script.js")
// Enable or disable GPS accourding to mycount
function startgps(mycount){
    if(mycount%2==1){
        return true
    }
    else if(mycount%2==0){
        return false
    }
}
// Start GPS in PositionSource
function gps_active() {
    // current position coordinates
    var currentPosition = src.position.coordinate
    // When LatLong to UTM is active
    if(geoutm.checked){
        if(Calc.coord_display_latlong()){
            rect_input.lon_decimal.text=parseFloat((currentPosition.longitude).toFixed(7))
            rect_input.lat_decimal.text=parseFloat((currentPosition.latitude).toFixed(7))
        }
        else{
            // convert decimal latitude and longitude to DMS
            // Latitude to DMS
            var latdec2 = currentPosition.latitude
            var latdegg=parseInt(latdec2)
            var latminn=parseInt((latdec2-latdegg)*60)
            var latsecc=(latdec2-latdegg-latminn/60)*3600
            rect_input.lat_deg.text=latdegg
            rect_input.lat_min.text=latminn
            rect_input.lat_sec.text=parseFloat((latsecc).toFixed(5))
            // Longitude to DMS
            var londec2 = currentPosition.longitude
            var londegg=parseInt(londec2)
            var lonminn=parseInt((londec2-londegg)*60)
            var lonsecc=(londec2-londegg-lonminn/60)*3600
            rect_input.lon_deg.text=londegg
            rect_input.lon_min.text=lonminn
            rect_input.lon_sec.text=parseFloat((lonsecc).toFixed(5))
        }
    }
    // When UTM to LatLong is active
    else if(utmgeo.checked){
        var clong=currentPosition.longitude
        var clat=currentPosition.latitude
        var cmyzone=parseInt((31+(clong/6)))
        // proj4 parameter
        var cepsgutm;
        if (clat < 0 ){
            cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +south +no_defs".arg(cmyzone)
        }
        else{
           cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(cmyzone)
        }
        // ccoord is converted coordinate x,y pair in a list
        var ccoord= Hesap.utm2latlong(cepsgutm,clong,clat)
        // Second parameter of coord is Northing
        utm.northing.text = parseFloat(ccoord[1].toFixed(3))
        // First parameter of coord is Easting
        utm.easting.text= parseFloat(ccoord[0].toFixed(3))
        // Grid utm designator char
        var utm_designator = Hesap.getLetterDesignator(clat);
        // UTM zone
        utm.zones.text=cmyzone + (__appSettings.gridZone ? utm_designator : "")
    }
}
// visible of Latlong forms
function latlong_utm_viz(){
    if (geoutm.checked){
        return true
    }
    else{
        return false
    }
}
// visible of Latlong forms
function utm_latlong_viz(){
    if (geoutm.checked){
        return false
    }
    else{
        return true
    }
}

// Use comma or dot for decimal inputs
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}

// start GPS for activating accuracy
function startgps(mycount){
    if(mycount%2==1){
        return true
    }
    else if(mycount%2==0){
        return false
    }
}

/**
 * Calculates the MGRS letter designator for the given latitude.
 *
 * @private
 * @param {number} lat The latitude in WGS84 to get the letter designator
 *     for.
 * @return {char} The letter designator.
 */
function getLetterDesignator(lat) {
  //This is here as an error flag to show that the Latitude is
  //outside MGRS limits
  var LetterDesignator = 'Z';

  if ((84 >= lat) && (lat >= 72)) {
    LetterDesignator = 'X';
  }
  else if ((72 > lat) && (lat >= 64)) {
    LetterDesignator = 'W';
  }
  else if ((64 > lat) && (lat >= 56)) {
    LetterDesignator = 'V';
  }
  else if ((56 > lat) && (lat >= 48)) {
    LetterDesignator = 'U';
  }
  else if ((48 > lat) && (lat >= 40)) {
    LetterDesignator = 'T';
  }
  else if ((40 > lat) && (lat >= 32)) {
    LetterDesignator = 'S';
  }
  else if ((32 > lat) && (lat >= 24)) {
    LetterDesignator = 'R';
  }
  else if ((24 > lat) && (lat >= 16)) {
    LetterDesignator = 'Q';
  }
  else if ((16 > lat) && (lat >= 8)) {
    LetterDesignator = 'P';
  }
  else if ((8 > lat) && (lat >= 0)) {
    LetterDesignator = 'N';
  }
  else if ((0 > lat) && (lat >= -8)) {
    LetterDesignator = 'M';
  }
  else if ((-8 > lat) && (lat >= -16)) {
    LetterDesignator = 'L';
  }
  else if ((-16 > lat) && (lat >= -24)) {
    LetterDesignator = 'K';
  }
  else if ((-24 > lat) && (lat >= -32)) {
    LetterDesignator = 'J';
  }
  else if ((-32 > lat) && (lat >= -40)) {
    LetterDesignator = 'H';
  }
  else if ((-40 > lat) && (lat >= -48)) {
    LetterDesignator = 'G';
  }
  else if ((-48 > lat) && (lat >= -56)) {
    LetterDesignator = 'F';
  }
  else if ((-56 > lat) && (lat >= -64)) {
    LetterDesignator = 'E';
  }
  else if ((-64 > lat) && (lat >= -72)) {
    LetterDesignator = 'D';
  }
  else if ((-72 > lat) && (lat >= -80)) {
    LetterDesignator = 'C';
  }
  return LetterDesignator;
}

// LatLon coordinates order with layout direction
function latlon_display(){
    if(windoww.order_latlong === 0){
        console.log("it must return Qt.LeftToRight")
         return Qt.LeftToRight
    }
    else if(windoww.order_latlong === 1){
        return Qt.RightToLeft
    }
}
// North East coordinates order with layout direction
function coord_display(){
    if(windoww.order_ne === 0){
        console.log("it must return Qt.LeftToRight")
         return Qt.LeftToRight
    }
    else if(windoww.order_ne === 1){
        console.log("it must return Qt.RightToLeft")
        return Qt.RightToLeft
    }
}

function wgs84(){
    var n       = myparser(utm.northing)
    var e       = myparser(utm.easting)
    var zn      = myparser(utm.zones)
    var latt    = myparser(rect_input.lat_decimal)
    var lonn    = myparser(rect_input.lon_decimal)
    var ltdeg   = myparser(rect_input.lat_deg)
    var lndeg   = myparser(rect_input.lon_deg)
    var ltmin   = myparser(rect_input.lat_min)
    var lnmin   = myparser(rect_input.lon_min)
    var ltsec   = myparser(rect_input.lat_sec)
    var lnsec   = myparser(rect_input.lon_sec)
    // LAT,LON = PROJ4JS.PROJ4( FROM, TO, INPUT_EAST(X), INPUT_NORTH(Y) )
    // EAST,NORTH = PROJ4JS.PROJ4( FROM, TO, INPUT_LONG, INPUT_LAT )

    // LAT/LON TO UTM
    if(geoutm.checked){
        // convert latitude longitude to UTM northing and easting
        if(coord_display_latlong()){
            if( rect_input.lat_decimal.text==="" || rect_input.lon_decimal.text==="")
                {
                snack.open(qsTr("Please enter the values."))
                }
            var utm_designator = getLetterDesignator(parseFloat(rect_input.lat_decimal.text));
            var myzone=parseInt((31+(lonn/6)))
            var epsgutm=""
            var epsglatlong=""
            if (Number(latt) < 0 ){
                epsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +south +no_defs".arg(myzone)
                epsglatlong="+proj=longlat +datum=WGS84 +south +no_defs"
            }
            else{
               epsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(myzone)
               epsglatlong="+proj=longlat +datum=WGS84 +no_defs"
            }
            var coord= proj4(proj4(epsglatlong),proj4(epsgutm),[parseFloat(rect_input.lon_decimal.text),parseFloat(rect_input.lat_decimal.text)])
            utmres.northing.text = parseFloat(coord[1].toFixed(3))
            utmres.easting.text=parseFloat(coord[0].toFixed(3))
            utmres.zones.text=myzone + (__appSettings.gridZone ? utm_designator : "")
            //JSON.stringify(yourobject)
        }
        // convert UTM northing and easting to Latitufde and Longitude
        else{
            if( rect_input.lat_deg.text==="" || rect_input.lat_min.text==="" || rect_input.lat_sec.text==="" || rect_input.lon_deg.text==="" ||
                    rect_input.lon_min.text==="" || rect_input.lon_sec.text==="" )
                {
                snack.open(qsTr("Please enter the values."))
                }

            var lat2dec=Math.abs(ltdeg) + Math.abs(ltmin/60) + Math.abs(ltsec/3600)
            if (ltdeg<0){
                lat2dec=-lat2dec
            }

            var lon2dec=Math.abs(lndeg) + Math.abs(lnmin/60) + Math.abs(lnsec/3600)
            if(lndeg<0){
                lon2dec=-lon2dec
            }
            var utm_designator2 = getLetterDesignator(lat2dec);
            var dmyzone=parseInt((31+(lon2dec/6)))
            var depsgutm= ""
            var depsglatlong=""
            if (Number(lat2dec) < 0 ){
                depsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +south +no_defs".arg(dmyzone)
                depsglatlong="+proj=longlat +datum=WGS84 +south +no_defs"
            }
            else{
               depsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(dmyzone)
               depsglatlong="+proj=longlat +datum=WGS84 +no_defs"
            }

            var dcoord= proj4(proj4(depsglatlong),proj4(depsgutm),[lon2dec,lat2dec])
            utmres.northing.text = parseFloat(dcoord[1].toFixed(3))
            utmres.easting.text=parseFloat(dcoord[0].toFixed(3))
            utmres.zones.text = dmyzone + (__appSettings.gridZone ? utm_designator2 : "")
        }
    }

    // UTM TO LAT/LON
    else if(utmgeo.checked){
        if( utm.northing.text==="" || utm.easting.text==="" || utm.zones.text==="")
        {
            snack.open(qsTr("Please enter the values."))
        }
        else if(coord_display_latlong()){
            var epsgutm2=Calc.hemi(zn)
            console.log("HEEYYYY now we test hemi", Calc.hemi(zn))
            var coord2= proj4(proj4(epsgutm2),proj4("+proj=longlat +datum=WGS84 +no_defs"),[parseFloat(utm.easting.text),parseFloat(utm.northing.text)])
            rect_res.lat_decimal.text = parseFloat(coord2[1].toFixed(8))
            rect_res.lon_decimal.text= parseFloat(coord2[0].toFixed(8))
        }
        else{
            var cepsgutm2=Calc.hemi(zn)
            var ccoord2= proj4(proj4(cepsgutm2),proj4("+proj=longlat +datum=WGS84 +no_defs"),[parseFloat(utm.easting.text),parseFloat(utm.northing.text)])
            var latdec2 = ccoord2[1]
            var londec2=ccoord2[0]

            var latdegg=parseInt(latdec2)
            var latminn=parseInt((latdec2-latdegg)*60)
            var latsecc=(latdec2-latdegg-latminn/60)*3600
            rect_res.lat_deg.text=latdegg
            rect_res.lat_min.text=Math.abs(latminn)
            rect_res.lat_sec.text=parseFloat((Math.abs(latsecc)).toFixed(6))

            var londegg=parseInt(londec2)
            var lonminn=parseInt((londec2-londegg)*60)
            var lonsecc=(londec2-londegg-lonminn/60)*3600
            rect_res.lon_deg.text=londegg
            rect_res.lon_min.text=Math.abs(lonminn)
            rect_res.lon_sec.text=parseFloat((Math.abs(lonsecc)).toFixed(6))

        }
    }
}

// for UTM to wgs84, use this function for getting real time coordinates:
function utm2latlong(cepsgutm,clong,clat){
    return proj4(proj4("+proj=longlat +datum=WGS84 +no_defs"),proj4(cepsgutm),[clong,clat])
}
