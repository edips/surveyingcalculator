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

.pragma library
.import QtQuick.LocalStorage 2.0 as Sql
.import Proj4 1.0 as Proj

var db
// country list
var country_list = []
// coordinate name list
var coordName_list = []
// projection dictionary
var proj_dict = {}
// unit dictionary
var unit_dict = {}
// U.S. States list
var us_state_list = []

// Open the database and return the database
function dbGetHandle()
{
    try {
        db = Sql.LocalStorage.openDatabaseSync("mydb", "1.0", "Database for Surveying Calculator", 2000000);
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

// database object
db = dbGetHandle();

// modify the database with transaction
db.transaction(function(tx) {
    //tx.executeSql('CREATE TABLE IF NOT EXISTS trip_log (date text,trip_desc text,distance numeric)')
    //.tables
    //var tables = tx.executeSql("SELECT name FROM sqlite_master WHERE type='table';");

    var country_sql = tx.executeSql('select distinct country from coordinate_systems order by country asc');
    // countries
    for(var i = 0; i < country_sql.rows.length; i++) {
        country_list.push(country_sql.rows[i].country)
        //console.log(country_list[i])
    }
    // united states
    var state_sql = tx.executeSql('select distinct state from coordinate_systems where country = "U.S." order by state asc');
    for(var i2 = 0; i2 < state_sql.rows.length; i2++) {
        us_state_list.push(state_sql.rows[i2].state)
        //console.log(us_state_list[i2])
    }
})

// Create degree unit dictionary
function degree_unit(my_currentText){
    if (Object.keys(unit_dict).length >0){
        unit_dict = {}
    }
    db.transaction(function(tx) {
        var proj_sql = tx.executeSql(
                    'select coordName, unit from coordinate_systems where country = ? order by coordName asc',[my_currentText]);
        //console.log("current text in db for COUNTRY coord fucntion: ", my_currentText)
        // coordinate system
        for(var i3 = 0; i3 < proj_sql.rows.length; i3++) {
            unit_dict[ proj_sql.rows[i3].coordName ] = proj_sql.rows[i3].unit
        }
        // test
        //for (var key in unit_dict){
        //  console.log( "here is key and units: ", key, unit_dict[key] );
        //}

    })
}

// create degree unit dictionary for U.S. states
function degree_unit_us(my_currentText){
    if (Object.keys(unit_dict).length >0){
        unit_dict = {}
    }
    db.transaction(function(tx) {
        var proj_sql = tx.executeSql(
                    'select coordName, unit from coordinate_systems where country = "U.S." and state = ? order by coordName asc',[my_currentText]);
        //console.log("current text in db for COUNTRY coord fucntion: ", my_currentText)
        // coordinate system
        for(var i3 = 0; i3 < proj_sql.rows.length; i3++) {
            unit_dict[ proj_sql.rows[i3].coordName ] = proj_sql.rows[i3].unit
        }
        // test
        // for (var key in unit_dict){
        //  console.log( "here is key and units: ", key, unit_dict[key] );
        //}

    })
}


function my_proj(my_currentText){
    if (Object.keys(proj_dict).length >0){
        proj_dict = {}
    }
    db.transaction(function(tx) {
        var proj_sql = tx.executeSql(
                    'select coordName, epsg from coordinate_systems where country = ? order by coordName asc',[my_currentText]);
        //console.log("current text in db for COUNTRY coord fucntion: ", my_currentText)
        // coordinate system
        for(var i3 = 0; i3 < proj_sql.rows.length; i3++) {
            proj_dict[ proj_sql.rows[i3].coordName ] = proj_sql.rows[i3].epsg
        }

        for (var key in proj_dict){
          console.log( key, proj_dict[key] );
        }

    })
}

function my_proj_us(my_currentText){
    if (Object.keys(proj_dict).length >0){
        proj_dict = {}
    }
    db.transaction(function(tx) {
        var proj_sql = tx.executeSql(
                    'select coordName, epsg from coordinate_systems where country = "U.S." and state = ? order by coordName asc',[my_currentText]);
        //console.log("current text in db for COUNTRY coord fucntion: ", my_currentText)
        // coordinate system
        for(var i3 = 0; i3 < proj_sql.rows.length; i3++) {
            console.log("proj_dict[", i3, "]: ",  proj_dict[ proj_sql.rows[i3].coordName ])
            proj_dict[ proj_sql.rows[i3].coordName ] = proj_sql.rows[i3].epsg
        }
        /*
        for (var key in proj_dict){
          console.log( key, proj_dict[key] );
        }*/

    })
}


function my_coords(my_currentText){
    // Make coordinate name list empty
    if (coordName_list.length >0){
        coordName_list = []
    }

    db.transaction(function(tx) {
        var coord_sql = tx.executeSql(
                    'select coordName from coordinate_systems where country = ? order by coordName asc',[my_currentText]);
        // Create coordinate name list from the database
        for(var i2 = 0; i2 < coord_sql.rows.length; i2++) {
            coordName_list.push(coord_sql.rows[i2].coordName)
        }
    })
}

function my_coords_us(currentText_us){
    if (coordName_list.length >0){
        coordName_list = []
    }
    db.transaction(function(tx) {
        var coord_sql_us = tx.executeSql(
                    'select coordName from coordinate_systems where country = "U.S." and state = ? order by coordName asc',[currentText_us]);
        // coordinate system
        //console.log("current text in db for u.s. function:", currentText_us)
        for(var i2 = 0; i2 < coord_sql_us.rows.length; i2++) {
            coordName_list.push(coord_sql_us.rows[i2].coordName)
        }
    })
}

// insert coordinate
function insert_CRS(country_name, coordinate_name, proj_def, mysnack){
    db.transaction(function(tx) {
        var coord_exists = tx.executeSql('SELECT EXISTS(SELECT 1 FROM coordinate_systems WHERE coordName=? and country=?) as coordExits',[coordinate_name, country_name])
        const substring = "+proj=longlat";
        if(coord_exists.rows[0].coordExits !== 1){
            //console.log("coordinate system really exist?: ", coord_exists.rows[0].coordExits)
            var unit = proj_def.includes(substring) ? "degree" : ""
            var coord_sql = tx.executeSql(
                        'insert into coordinate_systems(country, coordName, projdef, unit) values(?, ?, ?, ?);',[country_name,coordinate_name, proj_def, unit]);
            mysnack.open(coordinate_name + " successfully added to the database.")
        }
        else{
            mysnack.open("Cordinate System name already exists in database. Please type a different name.")
        }
    })
}

// insert coordinate for U.S. states
function insert_CRS_us(country_name, state_name, coordinate_name, proj_def, mysnack){
    db.transaction(function(tx) {
        var coord_exists = tx.executeSql('SELECT EXISTS(SELECT 1 FROM coordinate_systems WHERE coordName=? and state=?) as coordExits',[coordinate_name, state_name])
        const substring = "+proj=longlat";
        if(coord_exists.rows[0].coordExits !== 1){
            //console.log("coordinate system really exist?: ", coord_exists.rows[0].coordExits)
            var unit = proj_def.includes(substring) ? "degree" : ""
            var coord_sql = tx.executeSql(
                        'insert into coordinate_systems(country, state, coordName, projdef, unit) values(?, ?, ?, ?, ?);',[country_name, state_name, coordinate_name, proj_def, unit]);
            mysnack.open(coordinate_name + " successfully added to the database.")
        }
        else{
            mysnack.open("Cordinate System name already exists in database. Please type a different name.")
        }
    })
}


// remove coordinate
function remove_CRS(country_name, coordinate_name, snackbar){
    db.transaction(function(tx) {
        var coord_exists = tx.executeSql('DELETE FROM coordinate_systems WHERE coordName = ? and country = ?;',[coordinate_name, country_name])
        snackbar.open(coordinate_name + " removed from the database.")
    })
}

// remove coordinate for U.S. States
function remove_CRS_us(state_name, coordinate_name, snackbar){
    db.transaction(function(tx) {
        var coord_exists = tx.executeSql('DELETE FROM coordinate_systems WHERE coordName = ? and state = ?;',[coordinate_name, state_name])
        snackbar.open(coordinate_name + " removed from the database.")
    })
}


// COORDINATE CALCULATOR -------------------------------------

// unit finder input combobox
function unit_input(icoord){
    // Key value'den koordinat isimlerine gore unit'i çıkarır
    if(unit_dict[icoord] === "degree"){
        return true
    }
    else{
        return false
    }
}

// unit finder output combobox
function unit_output(ocoord){
    // Key value'den koordinat isimlerine gore unit'i çıkarır
    if(unit_dict[ocoord] === "degree"){
        return true
    }
    else{
        return false
    }
}


function utm2latlong(cepsgutm,clong,clat)
{
    return transform(clat, clong, "+proj=longlat +datum=WGS84 +no_defs", cepsgutm) // proj4(proj4("+proj=longlat +datum=WGS84 +no_defs"),proj4(cepsgutm),[clong,clat])
}
function startgps(mycount){
    if(mycount%2==1){
        return true
    }
    else if(mycount%2==0){
        return false
    }
}

/*
function printdict(){
    console.log("clicked!")
    console.log("projdef: ", proj_dict)
for (var key in proj_dict){
  console.log("combo ici: ",  key, proj_dict[key] );
}
}
*/
