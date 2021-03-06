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

// 1
// Displaying coordinates for Data Collector
//* TODO: isValid must be added to QML in order to check projected or geographic coordinates, we should set default to geographic if it isn't valid, means WGS84
function datacollector_coord() {
    if( __activeLayer.layerName != "" ) {
        if( __loader.isLayerGeographic() ) {
            if(__appSettings.latlongDisplay === "display_dms") {
                return coord_DMS()
            }
            else if( __appSettings.latlongDisplay === "display_dec" ) {
                return coord_decimal()
            }
        }
        else{
            return coord_XY()
        }
    }
    else {
        return ""
    }
}

// 2
// coordinate order for Decimal Lat Lon
function coord_decimal(){
    if(__appSettings.autoCenterMapChecked) {
        return gps_decimal()
    } else {
        return cursorTextDeg()
    }
}

// 3
// coordinate order for DMS Lat Lon
function coord_DMS(){
    if(__appSettings.autoCenterMapChecked) {
        return gps_DMS()
    } else {
        return cursorTextDMS()
    }
}

// Functions to display GPS or cursor coordinates
// 4
function coord_XY(){
    if(__appSettings.autoCenterMapChecked) {
        return gps_XY()
    } else {
        return cursorTextProjected()
    }
}

// 4.2
// Projected coordinate
function cursorTextProjected() {
    var coords = __loader.coordTransformer( projectCoord(),
                                           mapView.canvasMapSettings.transformContext(), epsgID, layerEPSG )
    if( coords.length === 2 ) {
        if( __appSettings.xyOrder === "ne" ) {
            return "<b>" + textN() + ":</b> " + ( coords[1] ).toFixed(2) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + textE() + ":</b> " + ( coords[0] ).toFixed(2)
        }
        else if( __appSettings.xyOrder === "en" ) {
            return "<b>" + textE() + ":</b> " + ( coords[0] ).toFixed(2) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + textN() + ":</b> " + ( coords[1] ).toFixed(2)
        }
    }
}

// 3.2
// Geographic coordinate (DMS)
// Coordinate order of Cursor for DMS
function cursorTextDMS() {
    var coords = __loader.coordTransformer( projectCoord(),
                                           mapView.canvasMapSettings.transformContext(), epsgID, layerEPSG )
    var coords2;
    if( coords.length === 2 ) {
        if(__appSettings.latlongFormat === "format_included") {
            coords2 = (__surveyingUtils.formatPoint_dms( coords[0], coords[1], "included"  )).split(",")
        } else {
            coords2 = (__surveyingUtils.formatPoint_dms( coords[0], coords[1], "not_included"  )).split(",")
        }
        if(__appSettings.latlongOrder === "order_latlong") {
            return "<b>" + "Lat" + ":</b> " + coords2[1] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Long" + ":</b> " + coords2[0]
        }
        else if(__appSettings.latlongOrder === "order_longlat") {
            return "<b>" + "Long" + ":</b> " + coords2[0] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Lat" + ":</b> " + coords2[1]
        }
    }
}
// Geographic coordinate (Decimal)
// Coordinate order of Cursor for Decimal Lat/Long
function cursorTextDeg() {
    var coords = __loader.coordTransformer( projectCoord(),
                                           mapView.canvasMapSettings.transformContext(), epsgID, layerEPSG )
    var coords2;
    if( coords.length === 2 ) {
        if (__appSettings.latlongFormat === "format_included") {
            coords2 = (__surveyingUtils.formatPoint_decimal( coords[0], coords[1], "included"  )).split(",")
        } else {
            coords2 = (__surveyingUtils.formatPoint_decimal( coords[0], coords[1], "not_included"  )).split(",")
        }
        if ( __appSettings.latlongOrder === "order_latlong" ) {
            return "<b>" + "Lat" + ":</b> " + coords2[1] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Long" + ":</b> " + coords2[0]
        }
        else if( __appSettings.latlongOrder === "order_longlat" ) {
            return "<b>" + "Long" + ":</b> " + coords2[0] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Lat" + ":</b> " + coords2[1]
        }
    }
}



// GPSSS
// 1- GPS cartesien crs
function gps_XY() {
    var coords = transformed_pt
    if( coords.length === 2 ) {
        if(__appSettings.xyOrder === "ne") {
            return "<b>" + textN() + ":</b> " + coords[1].toFixed(2) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + textE() + ":</b> " + coords[0].toFixed(2)
        }
        else if(__appSettings.xyOrder === "en") {
            return "<b>" + textE() + ":</b> " + coords[0].toFixed(2) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + textN() + ":</b> " + coords[1].toFixed(2)
        }
    }
}
// 2- GPS Degree decimal
function gps_decimal(){
    var coords = transformed_pt
    if( coords.length === 2 ) {
        if(__appSettings.latlongFormat === "format_included"){
            coords = (__surveyingUtils.formatPoint_decimal( coords[0], coords[1], "included"  )).split(",")
        }else{
            coords = (__surveyingUtils.formatPoint_decimal( coords[0], coords[1], "not_included"  )).split(",")
        }
        if(__appSettings.latlongOrder === "order_latlong"){
            return "<b>" + "Lat" + ":</b> " + coords[1] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Long" + ":</b> " + coords[0]
        }
        else if(__appSettings.latlongOrder === "order_longlat"){
            return "<b>" + "Long" + ":</b> " + coords[0] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Lat" + ":</b> " + coords[1]
        }
    }
}

// 3- GPS DMS
function gps_DMS() {
    var coords = transformed_pt
    if( coords.length === 2 ) {
        if( __appSettings.latlongFormat === "format_included" ) {
            coords = ( __surveyingUtils.formatPoint_dms( coords[0], coords[1], "included"  )).split(",")
        } else {
            coords = ( __surveyingUtils.formatPoint_dms( coords[0], coords[1], "not_included"  )).split(",")
        }
        if( __appSettings.latlongOrder === "order_latlong" ) {
            return "<b>" + "Lat" + ":</b> " + coords[1] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Long" + ":</b> " + coords[0]
        }
        else if( __appSettings.latlongOrder === "order_longlat" ) {
            return "<b>" + "Long" + ":</b> " + coords[0] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Lat" + ":</b> " + coords[1]
        }
    }
}



// area unit conversion from meter to other units
function areaUnits( area, area_metric ) {
    if ( __appSettings.lenUnit === 0 ){
        area.text = ( area_metric ).toFixed( 2 ) + " m²"
    }
    // km2
    else if(  __appSettings.lenUnit === 1 ){
        area.text = ( area_metric * 0.000001 ).toFixed( 2 ) + " km²"
    }
    // mile
    else if( __appSettings.lenUnit === 2 ){
        area.text = ( area_metric * 0.000000386102158542446 ).toFixed( 2 ) + " mi²"
    }
    // mile
    else if( __appSettings.lenUnit === 3 ){
        area.text = ( area_metric * 0.000000386102158542446 ).toFixed( 2 ) + " mi²"
    }
    // yard
    else if( __appSettings.lenUnit === 4 ){
        area.text = ( area_metric * 1.19599004630108).toFixed( 2 ) + " yd²"
    }
    // feet
    else if( __appSettings.lenUnit === 5 ){
        area.text = ( ( area_metric * 10.7639104167097 ) ).toFixed( 2 ) + " ft²"
    }
}

// length unit conversion from meters to other units
function lengthUnits( length, length_metric ) {
    // meter
    if ( __appSettings.lenUnit === 0 ){
        length.text = ( parseFloat( length_metric ) ).toFixed( 2 ) + " m"
    }
    // kilometer
    else if( __appSettings.lenUnit === 1 ){
        length.text = ( parseFloat( length_metric ) * 0.001 ).toFixed( 2 ) + " km"
    }
    // miles
    else if( __appSettings.lenUnit === 2 ){
        length.text = ( parseFloat( length_metric ) * 0.0006213712 ).toFixed( 2 ) + " mi"
    }
    // n. miles
    else if( __appSettings.lenUnit === 3 ){
        length.text = ( parseFloat( length_metric ) * 0.0005399568 ).toFixed( 2 ) + " nmi"
    }
    // yard 1.09361
    else if( __appSettings.lenUnit === 4 ){
        length.text = ( parseFloat( length_metric ) * 1.0936132983 ).toFixed( 2 ) + " yds"
    }
    // feet
    else if( __appSettings.lenUnit === 5 ){
        length.text = ( parseFloat( length_metric ) * 3.280839895 ).toFixed( 2 ) + " ft"
    }
}

// length unit conversion from other units to meter
function units2meter( unitVal ) {
    // meter
    if ( __appSettings.lenUnit === 0 ){
        return parseFloat( unitVal )
    }
    // kilometer
    else if( __appSettings.lenUnit === 1 ){
        return parseFloat( unitVal ) / 0.001
    }
    // miles
    else if( __appSettings.lenUnit === 2 ){
        return parseFloat( unitVal ) / 0.0006213712
    }
    // n. miles
    else if( __appSettings.lenUnit === 3 ){
        return parseFloat( unitVal ) / 0.0005399568
    }
    // yard 1.09361
    else if( __appSettings.lenUnit === 4 ){
        return parseFloat( unitVal ) / 1.0936132983
    }
    // feet
    else if( __appSettings.lenUnit === 5 ){
        return parseFloat( unitVal ) / 3.280839895
    }
}

// for placeholder text or as unit string
function length_txt( ) {
    if ( __appSettings.lenUnit === 0 ){
        return "m"
    }
    // kilometer
    else if( __appSettings.lenUnit === 1 ){
        return "km"
    }
    // miles
    else if( __appSettings.lenUnit === 2 ){
        return "mi"
    }
    // n. miles
    else if( __appSettings.lenUnit === 3 ){
        return "nmi"
    }
    // yard 1.09361
    else if( __appSettings.lenUnit === 4 ){
        return "yds"
    }
    // feet
    else if( __appSettings.lenUnit === 5 ){
        return "ft"
    }
}


// message for android
function showMessage(message) {
    if (__androidUtils.isAndroid) {
        __androidUtils.showToast(message)
    }
}

//WGS84 UTM LAT LONG:
function hemi(zn){
    var epsgutm2=""
    if (wgssetting.northcombo === 0){
        return "+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(zn)
    }
    else if (wgssetting.northcombo === 1){
        return "+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs +south".arg(zn)
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

// Add point to data collector
function add_point() {
    var en1;
    var boy1;
    if( __appSettings.latlongDisplay === "display_dms" && __loader.isLayerGeographic() ) {
        if( latdeg.text === "" || latmin.text === "" || latsec.text === "" || londeg.text === "" || lonmin.text === "" || lonsec.text === "" ) {
            snack.open("Cannot add point. Please check the cordinates.")
        }
        else if ( digitizing.hasPointGeometry( activeLayerPanel.activeVectorLayer ) ) {
            if( __loader.layerProjectCrs() ) {
                var lat_deg = parseFloat(latdeg.text)
                var lat_min = parseFloat(latmin.text)
                var lat_sec = parseFloat(latsec.text)
                var lon_deg = parseFloat(londeg.text)
                var lon_min = parseFloat(lonmin.text)
                var lon_sec = parseFloat(lonsec.text)
                // DMS
                en1 = ( Math.abs( lat_deg ) + Math.abs( lat_min/60 ) + Math.abs( lat_sec/3600 ) ).toString()
                if ( lat_deg < 0 ) {
                    en1=-en1.toString()
                }
                boy1= ( Math.abs( lon_deg ) + Math.abs( lon_min/60 ) + Math.abs( lon_sec/3600 ) ).toString()
                if ( lon_deg < 0 ) {
                    boy1=-boy1.toString()
                }

                // addFeatureSurvey: QgsPoint; only requires x and y coordinates
                var coords_degree = __layersModel.addFeatureSurvey( en1, boy1 )

                // transform point from layer CRS to project's CRS in order to catch pixel coordinate from map settings
                var coords = __loader.coordTransformer( coords_degree,
                                                       mapView.canvasMapSettings.transformContext(), layerEPSG, epsgID )

                // create the transformed QgsPoint
                var newpoint = __layersModel.addFeatureSurvey( coords[1], coords[0] )

                // Set the point to mapcanvas's map settings in order to zoom the point, convert it from CRS to screen coordinates
                var newqpoint = mapView.canvasMapSettings.coordinateToScreen( newpoint )

                // Zoom_to_point zooms to point to open feature form to record the point. It requires mapsettings of map canvas and screen point
                __loader.zoom_to_point( mapView.canvasMapSettings, newqpoint )

                // After zooming, screenX and screenY are set half of hight and width, it will be the new recorded coordinate
                var screenX = mapView.mapCanvas.width / 2
                var screenY = mapView.mapCanvas.height / 2

                // Record feature, open feature form panel and record the point
                dataCollector.recordFeature( screenX, screenY )
            }
            else {
                error_dialog.error = "Coordinate system unit of active layer isn't in degree."
                console.log("layer crs is valid? ", __loader.layerProjectCrs() )
                error_dialog.open()
            }
        }
        else{
            snack.open("Cannot add point. Point layer is not selected.")
        }
    }
    else {
        en1 = add_N.text
        boy1 = add_E.text
        // if coordinate inputs are empty, warn user
        if(add_N.text === "" || add_E.text === "") {
            snack.open("Cannot add point. Please check the cordinates.")
        }
        // If active layer is point, convert coordinates to pixel coordinates and open the record panel for this
        else if ( digitizing.hasPointGeometry( activeLayerPanel.activeVectorLayer ) ) {
            if( __loader.layerProjectCrs() ) {

                // addFeatureSurvey: QgsPoint; only requires x and y coordinates
                var coords_degree2 = __layersModel.addFeatureSurvey( en1, boy1 )

                // transform point from layer CRS to project's CRS in order to catch pixel coordinate from map settings
                var coords2 = __loader.coordTransformer( coords_degree2,
                                                        mapView.canvasMapSettings.transformContext(), layerEPSG, epsgID )
                // create the transformed QgsPoint
                var newpoint2
                newpoint2 = __layersModel.addFeatureSurvey( coords2[1], coords2[0] )

                // (QPointF) set the point to mapcanvas's map settings in order to zoom the point, convert it from CRS to screen coordinates
                var newqpoint2 = mapView.canvasMapSettings.coordinateToScreen( newpoint2 )

                // zoom_to_point zooms to point to open feature form to record the point. It requires mapsettings of map canvas and screen point
                __loader.zoom_to_point( mapView.canvasMapSettings, newqpoint2 )

                // After zooming, screenX and screenY are set half of hight and width, it will be the new recorded coordinate
                var screenX_2 = mapView.mapCanvas.width / 2
                var screenY_2 = mapView.mapCanvas.height / 2

                // Record feature, open feature form panel and record the point
                dataCollector.recordFeature( screenX_2, screenY_2 )
            }
            else {
                error_dialog.error = "Coordinate system unit of active layer isn't in metric."
                error_dialog.open()
            }
        }
        else{
            snack.open("Cannot add point. Point layer is not selected.")
        }
    }
}

// Seeting for visibility according to DMS mode for lat long
function visibility_latlong() {
    if( __appSettings.latlongDisplay === "display_dms" && ( __loader.isActiveLayerGeographic() ) ) {
        return true
    }
    else{
        return false
    }
}

//----------------------------------------SETTINGS--------------------------------------
// North East coordinates order with layout direction
function coord_display(){
    if(__appSettings.xyOrder === "en"){
        return Qt.LeftToRight
    }
    else if(__appSettings.xyOrder === "ne"){
        return Qt.RightToLeft
    }
}

function coord_direction_latlong(){
    if(!!(__appSettings.latlongOrder === "order_latlong")){
        return Qt.LeftToRight
    }
    else if(!!(__appSettings.latlongOrder === "order_longlat")){
        return Qt.RightToLeft
    }
}

// Lat long coordinates order with layout direction
function coord_display_latlong(){
    if(__appSettings.latlongDisplay === "display_dec"){
        return true
    }
    else{
        return false
    }
}

/*
// North East coordinates order with layout direction
function coord_display(){
    if(mysettings.koordinat_display_xy === 0){
         return Qt.LeftToRight
    }
    else if(mysettings.koordinat_display_xy === 1){
        return Qt.RightToLeft
    }
}

function coord_order_latlon(){
    if(mysettings.latlong_display === 0){
        return "latlon"
    }// Longitude before latitude
    else if(mysettings.latlong_display === 1){
        return "lonlat"
    }
}
*/

// Order of [North East Lat Long] for QGIS coordinate input
function coord_order() {
    //console.log("__loader.isGeographic() in func: ", __loader.isGeographic(), "__loader.crsValid() ", __loader.crsValid())
    // is geographic or srs is undefined
    if( isLayerGeographic ) {
        // latitude before longitude
        if(__appSettings.latlongOrder === "order_latlong"){
            return "latlon"
        }// Longitude before latitude
        else if(__appSettings.latlongOrder === "order_longlat"){
            return "lonlat"
        }
    }// is projected
    else {
        if(__appSettings.xyOrder === "ne"){
            return "ne"
        }
        else if(__appSettings.xyOrder === "en"){
            return "en"
        }
    }
}

function coord_order_latlon() {
    if(__appSettings.latlongOrder === "order_latlong"){
        return "latlon"
    }// Longitude before latitude
    else if(__appSettings.latlongOrder === "order_longlat"){
        return "lonlat"
    }
}

// another template
/*function coord_display2(){
    // is geographic or srs is undefined
    if(__loader.isGeographic() || !__loader.crsValid()){

        // latitude before longitude
        if(__appSettings.latlongOrder === "order_latlong"){
            if(__appSettings.latlongDisplay === "display_dms"){

            }
            else if(__appSettings.latlongDisplay === "display_dec"){

            }
        }// Longitude before latitude
        else if(__appSettings.latlongOrder === "order_longlat"){
            if(__appSettings.latlongDisplay === "display_dms"){

            }
            else if(__appSettings.latlongDisplay === "display_dec"){
                return coord_decimal()
            }
        }
    }// is projected
    else{

        if(windoww.order_ne){

        }
        else if(windoww.order_en){

        }
    }
}
*/


//                  Coordinate order for Data Collection
// General functions for coordinate display
// Codes for N S W E codes for geographic coordinate systems
// include decimal geographic W E S N codes or not
function includeFormatDecimal(coords) {
    if(__appSettings.latlongFormat === "format_included"){
        coords = (__surveyingUtils.formatPoint_decimal( coords, "included"  )).split(",")
    }else{
        coords = (__surveyingUtils.formatPoint_decimal( coords, "not_included"  )).split(",")
    }
}
// include DMS W E S N codes or not
function includeFormatDMS( coords ) {
    if( __appSettings.latlongFormat === "format_included" ) {
        coords = (__surveyingUtils.formatPoint_dms( coordinateTransformer.projectedPosition, "included"  )).split(",")
    }else{
        coords = ( __surveyingUtils.formatPoint_dms( coordinateTransformer.projectedPosition, "not_included" ) ).split(",")
    }
}
// Coordinate order
// !! UNUSED !!  Lat Long or Long Lat
function latlonOrder( coords ) {
    if( __appSettings.latlongOrder === "order_latlong" ){
        return "<b>" + "Lat" + ":</b> " + coords[1] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Long" + ":</b> " + coords[0]
    }
    else if( __appSettings.latlongOrder === "order_longlat" ) {
        return "<b>" + "Long" + ":</b> " + coords[0] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + "Lat" + ":</b> " + coords[1]
    }
}
// !! UNUSED !! xy or yx
function xyOrder( coords ) {
    if(__appSettings.xyOrder === "ne"){
        return "<b>" + textN() + ":</b> " + coords[1] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + textE() + ":</b> " + coords[0]
    }
    else if(__appSettings.xyOrder === "en"){
        return "<b>" + textE() + ":</b> " + coords[0] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"  + "<b>" + textN() + ":</b> " + coords[1]
    }
}
// Keyboard type keyboard_settings
function keyboard_display(){
    if(__appSettings.keyboard === 0){
        return Qt.ImhFormattedNumbersOnly
    }
    else if(__appSettings.keyboard === 1){
        return Qt.ImhSensitiveData
    }
}

// Font size
function sfontsize(size){
    return size
}

// Parse comma or dot to float
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
// NORTH and EAST X and Y
function textN(){
    if(__appSettings.xyDisplay === 0){
        return "N"
    }
    else if(__appSettings.xyDisplay === 1){
        return "X"
    }
    else if(__appSettings.xyDisplay === 2){
        return "Y"
    }
}
function textE(){
    if(__appSettings.xyDisplay === 0){
        return "E"
    }
    else if(__appSettings.xyDisplay === 1){
        return "Y"
    }
    else if(__appSettings.xyDisplay === 2){
        return "X"
    }
}


function vizN(){
    if(__appSettings.xyDisplay === 0){
        return true
    }
    else{
        return false
    }
}
function vizX(){
    if(__appSettings.xyDisplay === 1){
        return true
    }
    else{
        return false
    }
}
function vizY(){
    if(__appSettings.xyDisplay === 2){
        return true
    }
    else{
        return false
    }
}
// ANGLE UNIT FUNCTION
function degree(angle) {
    return angle*(Math.PI/180)
}
function grad(angle) {
    return angle*(Math.PI/200)
}

//returns angle float value for input
function angle_text_input(my_angle){
    if(__appSettings.angleUnit === 0){
        return myparser(my_angle.decimal)
    }
    else if(__appSettings.angleUnit === 1){
        var deg = parseFloat(my_angle.degree.text)
        var min = parseFloat(my_angle.minute.text)
        var sn = myparser(my_angle.second)
        var angle = Math.abs(deg) + Math.abs(min/60) + Math.abs(sn/3600)
        if (deg<0){
            angle=-angle
        }
        return angle
    }
    else if(__appSettings.angleUnit === 2){
        return myparser(my_angle.gon)
    }
}

//returns angle float value for output
function angle_text_output(output, my_angle){
    if( __appSettings.angleUnit === 0 ) {
        output = parseFloat( output ).toFixed(4)
        my_angle.decimal.text = output  + "°"
    }
    else if( __appSettings.angleUnit === 1 ) {
        var latintdeg = parseInt(output)
        var latintmin = parseInt((output-latintdeg) * 60 )
        var latdecsn=( output - latintdeg - latintmin / 60 ) * 3600
        my_angle.degree.text=latintdeg + "°"
        my_angle.minute.text=Math.abs(latintmin) + "'"
        my_angle.second.text=(Math.abs(latdecsn)).toFixed(4) + "''"
    }
    else if( __appSettings.angleUnit === 2 ) {
        output = parseFloat( output ).toFixed(4)
        my_angle.gon.text = output  + " gon"
    }
}




// angle clear function
function angle_clear(my_angle){
    for (var v in my_angle){
        if(__appSettings.angleUnit === 0){
            my_angle[v].decimal.text = ""
        }
        else if(__appSettings.angleUnit === 1){
            my_angle[v].degree.text = ""
            my_angle[v].minute.text = ""
            my_angle[v].second.text = ""
        }
        else if(__appSettings.angleUnit === 2){
            my_angle[v].gon.text = ""
        }
    }
}

// grad unit
function grad_unit(){
    if(__appSettings.angleUnit === 2){
        return true
    }else{
        return false
    }
}

// angle unit settings
function angle_unit(angle){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return degree(angle)
    }
    else if(__appSettings.angleUnit === 2){
        return grad(angle)
    }
}

//(angle/Math.PI)
function angle_pi(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return (180/Math.PI)
    }
    else if(__appSettings.angleUnit === 2){
        return (200/Math.PI)
    }
}
// angles:
function angle_100(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return 90
    }
    else if(__appSettings.angleUnit === 2){
        return 100
    }
}
function angle_200(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return 180
    }
    else if(__appSettings.angleUnit === 2){
        return 200
    }
}
function angle_300(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return 270
    }
    else if(__appSettings.angleUnit === 2){
        return 300
    }
}
function angle_400(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return 360
    }
    else if(__appSettings.angleUnit === 2){
        return 400
    }
}
function angle_600(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return 540
    }
    else if(__appSettings.angleUnit === 2){
        return 600
    }
}
function angle_800(){
    if(__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1){
        return 720
    }
    else if(__appSettings.angleUnit === 2){
        return 800
    }
}
//---------------------------------------

//-------------------------Appearance--------------------------
// Font Chooser


// Font Chooser
/*
function fontchooser()
{
    if(__appSettings.myfont === 0){
        return "PT Serif"
    }
    else if(__appSettings.myfont === 1){
        return "Open Sans"
    }
    else if(__appSettings.myfont === 2){
        return "Ubuntu"
    }
    else if(__appSettings.myfont === 3){
        return "Ubuntu Mono"
    }
    else if(__appSettings.myfont === 4){
        return "PT Sans"
    }
    else if(__appSettings.myfont === 5){
        return "Roboto"
    }
}*/

// Menu Font Size
function fontsize_menu()
{
    if(__appSettings.myfont === 0){
        return 16
    }
    else if(__appSettings.myfont === 1){
        return 16
    }
    else if(__appSettings.myfont === 2){
        return 16
    }
    else if(__appSettings.myfont === 3){
        return 17
    }
    else if(__appSettings.myfont === 4){
        return 16
    }
    else if(__appSettings.myfont === 5){
        return 16
    }
}
/*
// Theme chooser
function themechooser()
{
    if(windoww.themeIndex === 0){
        return "#EBEBE3"
    }
    else if(windoww.themeIndex === 1){
        return "#36454f"
    }
    // green
    else if(windoww.themeIndex === 2){
        return "#006400"
    }
}
//calculator: cce0cfff
// Backgraund chooser
function backgraundchooser(){
    if(windoww.themeIndex === 0){
        return "#EBEBE3"
    }
    else if(windoww.themeIndex === 2){
        return "#f0f3f5"
    }
}
// Accent chooser
function accentchooser(){
    if(windoww.themeIndex===0){
        return "#147efb"
    }
    else if(windoww.themeIndex === 1){
        return "#36454f"
    }
    else if(windoww.themeIndex === 2){
        return "#006400"
    }
}*/

// Text color chooser white or black
function isDarkColor(background) {
    var temp = Qt.darker(background, 1) //Force conversion to color QML type object
    var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);
    return temp.a > 0 && a >= 0.3
}

function lightDark(background, darkColor, lightColor) {

    return isDarkColor(background) ? lightColor : darkColor
}

// Scale bar units
function scalebar_settings(){
    if(__appSettings.scaleUnit === 0){
        return QgsQuick.QgsUnitTypes.MetricSystem
    }else{
        return QgsQuick.QgsUnitTypes.ImperialSystem
    }
}
