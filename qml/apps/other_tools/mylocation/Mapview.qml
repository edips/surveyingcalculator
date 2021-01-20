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

import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtLocation 5.6
import QtPositioning 5.6
import Qt.labs.settings 1.1
import "../../../components/common"
import "../../../components/common/script.js" as Script
import "components"

MapviewForm{
    id: mapview

    // for UTM to wgs84, use this function for getting real time coordinates:
    function utm2latlong(cepsgutm,clong,clat){
        return proj4(proj4("+proj=longlat +datum=WGS84 +no_defs"),proj4(cepsgutm),[clong,clat])
    }

    // Setting the current indexes of map type according to map providers
    function combo_index(){
        if(osm_btn_checked){
            selectmap.currentIndex = mapview.currentIndex_osm ? mapview.currentIndex_osm : 0
        }else if(here_btn_checked){
            selectmap.currentIndex = mapview.currentIndex_here ? mapview.currentIndex_here : 0
        }else if(esri_btn_checked){
            selectmap.currentIndex = mapview.currentIndex_esri ? mapview.currentIndex_esri : 0
        }else{
            selectmap.currentIndex = 0
        }
    }
    // Map Type model function to set values from supportedMapTypes
    function mapmodel(){
        // Clear the map type model before appending values
        mylist.clear()
        // Appending values to the model from supportedMapTypes
        for(var i = 0; i < map.supportedMapTypes.length; i++){
            mylist.append({ "text":map.supportedMapTypes[i].name })
        }
        // Setting map type CustomComboBox model to mylist model
        selectmap.model = mylist
        // Setting currentindex of map type CustomComboBox
        combo_index()
    }
    // Create map from map providers
    function createMap(pluginName) {
        map = mapComponent.createObject(rectMap);
        /*
        Setting map provider and setting map plugin to the map component.
        Then set the map type model according to the map provider
        */
        if (pluginName === "osm") {
            map.plugin = map.pluginOSM;
            mapmodel()
        } else if (pluginName === "here") {
            map.plugin = map.pluginHERE;
            mapmodel()
        }else if (pluginName === "esri") {
            map.plugin = map.pluginESRI;
            mapmodel()
        }
        map.forceActiveFocus()
    }

    //-------------Coordinate Capture Functions ----------------------------
    function coordinate_message(){
        var latlon_txt = __appSettings.latlongOrder === "order_latlong" ? "<b>Latitude: %1</b><br/><b>Longitude: %2</b><br/><br/><b>"
                                                          : "<b>Longitude: %2</b><br/><b>Latitude: %1</b><br/><br/><b>"
        var ne_txt = __appSettings.xyOrder === "en" ? "Easting: %3</b><br/><b>Northing: %4</b><br/><b>UTM Zone: %5</b>"
                                                        : "Northing: %4</b><br/><b>Easting: %3</b><br/><b>UTM Zone: %5</b>"
        var mgrs_txt = mapssetting.mgrs_enabled ? "<br/><br/><b>MGRS: %6</b>" : ""

        //console.log("mgrs is enabled?", mapssetting.mgrs_enabled)
        //console.log("coordinate message: ", latlon_txt + ne_txt + mgrs_txt)

        return latlon_txt + ne_txt + mgrs_txt
    }

    // from Latlon to MGRS
    function numberWithSpaces(x) {
        return x.toString().replace(/\B(?=(\d{5})+(?!\d))/g, " ");
    }

    function coordCapture(latitude, longitude){
        // DMS parameters
        var latdec2 = latitude
        var latdegg=parseInt(latdec2)
        var latminn=parseInt((latdec2-latdegg)*60)
        var latsecc=((latdec2-latdegg-latminn/60)*3600).toFixed(6)

        var londec2 = longitude
        var londegg=parseInt(londec2)
        var lonminn=parseInt((londec2-londegg)*60)
        var lonsecc=((londec2-londegg-lonminn/60)*3600).toFixed(6)

        var enlem_text = __appSettings.latlongDisplay === "display_dec" ? (latitude).toFixed(6) : latdegg + "° " + latminn + "' " + latsecc + "\""
        var boylam_text = __appSettings.latlongDisplay === "display_dec" ? (longitude).toFixed(6) : londegg + "° " + lonminn + "' " + lonsecc + "\""

        // Northing and Easting
        var clat=latitude
        var clong=longitude
        var cmyzone=parseInt((31+(clong/6)))

        // new added ****************************************************
        var cepsgutm;
        if (latitude < 0 ){
            cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +south +no_defs".arg(cmyzone)
        }
        else{
           cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(cmyzone)
        }
        // new added ****************************************************

        // disabled cepsgutm
        //var cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(cmyzone)

        var ccoord= utm2latlong(cepsgutm,clong,clat)

        // MGRS calculation
        var point = new proj4.Point(clong, clat);

        var utm_designator = Script.getLetterDesignator(clat);

        var mgrsText = numberWithSpaces( point.toMGRS() )

        var coords = coordinate_message().arg(latitude.toFixed(6)).arg(longitude.toFixed(6))
        .arg(ccoord[0].toFixed(2)).arg(ccoord[1].toFixed(2)).arg(parseInt((31+(clong/6))) + (__appSettings.gridZone ? utm_designator : "")).arg("aaaa")

        var coords_with_mgrs = coordinate_message().arg(enlem_text).arg(boylam_text)
        .arg(ccoord[0].toFixed(2)).arg(ccoord[1].toFixed(2)).arg(parseInt((31+(clong/6))) + (__appSettings.gridZone ? utm_designator : "")).arg(mgrsText)

        return mapssetting.mgrs_enabled ? coords_with_mgrs : coords
    }

    function coord_capture2(currentPosition, enlem, boylam, dilimno, mgrs, northing, easting){
        //console.debug("current position:", currentPosition.latitude, currentPosition.longitude);
        // DMS parameters
        var latdec2 = currentPosition.latitude
        var latdegg=parseInt(latdec2)
        var latminn=parseInt((latdec2-latdegg)*60)
        var latsecc=parseFloat(((latdec2-latdegg-latminn/60)*3600).toFixed(6))

        var londec2 = currentPosition.longitude
        var londegg=parseInt(londec2)
        var lonminn=parseInt((londec2-londegg)*60)
        var lonsecc=parseFloat(((londec2-londegg-lonminn/60)*3600).toFixed(6))

        enlem.text= __appSettings.latlongDisplay === "display_dec"  ? parseFloat((currentPosition.latitude).toFixed(10)) : latdegg + "° " + latminn + "' " + latsecc + "\""
        boylam.text= __appSettings.latlongDisplay === "display_dec" ? parseFloat((currentPosition.longitude).toFixed(10)) : londegg + "° " + lonminn + "' " + lonsecc + "\""

        // Northing and Easting
        var clong=currentPosition.longitude
        var clat=currentPosition.latitude
        var cmyzone=parseInt((31+(clong/6)))

        // new added ****************************************************
        var cepsgutm;
        if (currentPosition.latitude < 0 ){
            cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +south +no_defs".arg(cmyzone)
        }
        else{
           cepsgutm="+proj=utm +zone=%1 +datum=WGS84 +units=m +no_defs".arg(cmyzone)
        }
        // new added ****************************************************

        var ccoord= utm2latlong(cepsgutm,clong,clat)
        northing.text = ccoord[1].toFixed(2)
        easting.text=ccoord[0].toFixed(2)

        // MGRS calculation
        var point = new proj4.Point(clong, clat);

        mgrs.text = numberWithSpaces( point.toMGRS() )
        // UTM zone
        var utm_designator = Script.getLetterDesignator(clat);
        dilimno.text = parseInt((31+(clong/6))) + (__appSettings.gridZone ? utm_designator : "")
    }

    //------------------------------------------------------------------------------------
    //------------------Map Popup Menu Function ---------------------------------------------------------
    function show(coordinate, x, y, mapPopupMenu) {
        //coordCaptureDialog.open()
        mapPopupMenu.coordinate = coordinate
        mapPopupMenu.mapItemsCount = map.mapItems.length
        mapPopupMenu.update()
        mapPopupMenu.popup(x,y)
    }



    selectedMapType: provider.mapType
    onRecreateMap: {
        createMap(mapType);
    }

    onSelectedMapTypeChanged: {
            recreateMap(selectedMapType);
            //console.log("selected map type is: ", selectedMapType)
    }

    // Map Type CustomComboBox model
    ListModel {
        id:mapModel
    }


    Component.onCompleted:{
        if(counter_settings === 0){
            osm_btn_checked=true
        }
        counter_settings = 1;

        if(osm_btn_checked){
            provider.mapType = "osm"
         }else if(here_btn_checked){
            provider.mapType = "here"
         }else if(esri_btn_checked){
            provider.mapType = "esri"
         }
        combo_index()
        // Proj4JS version
        // from MGRS to Latlong
        // proj4.Point.fromMGRS('56HLH3477546637') //gets me an x of 151.21288643944013 and a y of -33.90772474089813
        //var mgrs = "33UXP04";
        //var point = proj4.Point.fromMGRS(mgrs);
        //console.log("Proj4 test: x:", point.x.toPrecision(7)) // 16.41450 right
        //console.log("Proj4 test: y:", point.y.toPrecision(7)) // 48.24949
        // from Latlon to MGRS
        //console.log("Proj4 test: toMGRS high accuracy:", point.toMGRS())  // 33UXP0500444998 MGRS reference with highest accuracy
        //console.log("Proj4 test: toMGRS 1 digit accuracy:", point.toMGRS(1)) // MGRS reference with 1-digit accuracy
        //provider.mapType = "osm"
    }
}
