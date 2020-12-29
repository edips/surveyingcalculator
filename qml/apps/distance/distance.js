Qt.include("../../apps/other_tools/libs/geographiclib.js")
Qt.include("../../components/common/script.js")
//--------------------------------------DISTANCA CALC---------------------------------------------------

// Lat Long distance function
function distance_latlong(d, d2) {
    console.log("debug 1 distance decimal: ", d2)
    console.log("debug 1 distance DMS: ", d)
    //if(ucd.currentIndex === 2 & windoww.display_dec===false){

    if(ucd.currentIndex === 2 & __appSettings.latlongDisplay === "display_dms")
    {
        if(dist_latlon1.lat_deg.text==="" || dist_latlon1.lat_min.text==="" ||
                dist_latlon1.lat_sec.text==="" || dist_latlon2.lat_deg.text==="" ||
                dist_latlon2.lat_min.text==="" || dist_latlon2.lat_sec.text==="" ||
                dist_latlon1.lon_deg.text==="" || dist_latlon1.lon_min.text==="" ||
                dist_latlon1.lon_sec.text==="" || dist_latlon2.lon_deg.text==="" ||
                dist_latlon2.lon_min.text==="" || dist_latlon2.lon_sec.text===""
                )
        {
            snack.open(qsTr("Please enter the values."))
            return ""
        }
        else {
            console.log("debug 2 distance decimal: ", d2)
            console.log("debug 2 distance DMS: ", d)
            return d + " m"
        }
    }
    else if(ucd.currentIndex === 2 & __appSettings.latlongDisplay === "display_dec")
    {
        if(dist_latlon1.lat_decimal.text==="" || dist_latlon1.lon_decimal.text==="" || dist_latlon2.lat_decimal.text==="" || dist_latlon2.lon_decimal.text==="")
        {
            snack.open(qsTr("Please enter the values."))
            return ""
        }
        else{
            console.log("debug 3 distance decimal: ", d2)
            console.log("debug 3 distance DMS: ", d)
            return d2 + " m"
        }
    }
}


function distancecalc(){
    //------2D/3D------------------------------------------------------
    var y1 = parseFloat(dist2d_1.east.text)
    var y2 = parseFloat(dist2d_2.east.text)
    var x1 = parseFloat(dist2d_1.north.text)
    var x2 = parseFloat(dist2d_2.north.text)

    var y1_d = parseFloat(dist3d_1.easting.text)
    var y2_d = parseFloat(dist3d_2.easting.text)
    var x1_d = parseFloat(dist3d_1.northing.text)
    var x2_d = parseFloat(dist3d_2.northing.text)
    var z1_d = parseFloat(dist3d_1.elev.text)
    var z2_d = parseFloat(dist3d_2.elev.text)

    var dist2d = (Math.sqrt((y1-y2)*(y1-y2) + (x1-x2)*(x1-x2))).toFixed(3)
    var dist3d=(Math.sqrt((y1_d-y2_d)*(y1_d-y2_d) + (x1_d-x2_d)*(x1_d-x2_d) + (z1_d-z2_d)*(z1_d-z2_d))).toFixed(3)
    var hdistt=(Math.sqrt((y1_d-y2_d)*(y1_d-y2_d) + (x1_d-x2_d)*(x1_d-x2_d))).toFixed(3)
    var zdiff=(z1_d-z2_d).toFixed(3)

    //---------LAT LON -----------------------------------------------------------------------------------------------
    var deg1 = parseFloat(dist_latlon1.lat_deg.text)
    var dak1 = parseFloat(dist_latlon1.lat_min.text)
    var san1 = parseFloat(dist_latlon1.lat_sec.text)
    var bdeg1 = parseFloat(dist_latlon1.lon_deg.text)
    var bdak1 = parseFloat(dist_latlon1.lon_min.text)
    var bsan1 = parseFloat(dist_latlon1.lon_sec.text)

    var deg2 = parseFloat(dist_latlon2.lat_deg.text)
    var dak2 = parseFloat(dist_latlon2.lat_min.text)
    var san2 = parseFloat(dist_latlon2.lat_sec.text)
    var bdeg2 = parseFloat(dist_latlon2.lon_deg.text)
    var bdak2 = parseFloat(dist_latlon2.lon_min.text)
    var bsan2 = parseFloat(dist_latlon2.lon_sec.text)
    var den1 = parseFloat(dist_latlon1.lat_decimal.text)
    var den2 = parseFloat(dist_latlon2.lat_decimal.text)
    var dboy1 = parseFloat(dist_latlon1.lon_decimal.text)
    var dboy2 = parseFloat(dist_latlon2.lon_decimal.text)
    var en1 = Math.abs(deg1) + Math.abs(dak1/60) + Math.abs(san1/3600)
    if (deg1<0){
        en1=-en1
    }
    var boy1= Math.abs(bdeg1) + Math.abs(bdak1/60) + Math.abs(bsan1/3600)
    if (bdeg1<0){
        boy1=-boy1
    }
    var en2 = Math.abs(deg2) + Math.abs(dak2/60) + Math.abs(san2/3600)
    if (deg2<0){
        en2=-en2
    }
    var boy2 = Math.abs(bdeg2) + Math.abs(bdak2/60) + Math.abs(bsan2/3600)
    if (bdeg2<0){
        boy2=-boy2
    }

    // açıklık açısı:
    var dy = y2 - y1
    var dx = x2 - x1

    var dy_z = y2_d - y1_d
    var dx_z = x2_d - x1_d

    var abg = Calc.angle_pi()*Math.atan(dy/dx)
    var abg_z = Calc.angle_pi()*Math.atan(dy_z/dx_z)
    // Aciklik Acisi
    // TODO: bunların hepsi script.js'de bir fonksyona dönüştürülecek, amele işi yapılmayacak. Calc.azimuth(abg, dx, dy) şeklinde
    if(dy===0 && dx>0){
        abg=0
    }
    else if(dx===0 && dy>0){
        abg=Calc.angle_100()
    }
    else if(dy===0 && dx<0){
        abg=Calc.angle_200()
    }
    else if(dx===0 && dy<0){
        abg=Calc.angle_300()
    }
    else if(dx<0 && dy>0){
        abg = abg+Calc.angle_200();
    }
    else if(dx<0 && dy<0){
        abg = abg+Calc.angle_200();
    }
    else if(dx>0 && dy<0){
        abg = abg+Calc.angle_400();
    }


    if(dy_z===0 && dx_z>0){
        abg_z=0
    }
    else if(dx_z===0 && dy_z>0){
        abg_z=Calc.angle_100()
    }
    else if(dy_z===0 && dx_z<0){
        abg_z=Calc.angle_200()
    }
    else if(dx_z===0 && dy_z<0){
        abg_z=Calc.angle_300()
    }
    else if(dx_z<0 && dy_z>0){
        abg_z = abg_z+Calc.angle_200();
    }
    else if(dx_z<0 && dy_z<0){
        abg_z = abg_z+Calc.angle_200();
    }
    else if(dx_z>0 && dy_z<0){
        abg_z = abg_z+Calc.angle_400();
    }

    //Degree calculus---------------------------------------------------

    var Geodesic = GeographicLib.Geodesic,
    DMS = GeographicLib.DMS,
    geod = Geodesic.WGS84;
    var r = geod.Inverse(en1, boy1, en2, boy2);
    console.log("distance is: ", r.s12.toFixed(3) + " m.")
    var d=r.s12.toFixed(3)
    // Decimal calculus----------------------------------------------------
    var r2 = geod.Inverse(den1, dboy1, den2, dboy2);
    var d2=r2.s12.toFixed(3)
    console.log("distance decimal: ", d2)
    console.log("distance DMS: ", d)
    //----------------------------------------------------------------------

    if(ucd.currentIndex === 2){
        dist.text = String(distance_latlong(d, d2))
    }
    else if(ucd.currentIndex === 0){
        if(dist2d_1.east.text==="" || dist2d_2.east.text==="" || dist2d_1.north.text==="" || dist2d_2.north.text==="")
        {
            snack.open(qsTr("Please enter the values."))
            dist_2d.text = ""
        }
        else{
            dist_2d.text = dist2d + " m"
            angle_text_output(abg.toFixed(4), abg_to2)
        }
    }

    else if(ucd.currentIndex === 1){
        if(dist3d_1.easting.text==="" || dist3d_2.easting.text==="" || dist3d_1.northing.text==="" || dist3d_2.northing.text==="" || dist3d_1.elev.text==="" || dist3d_2.elev.text==="")
        {
            snack.open(qsTr("Please enter the values."))
            dist3dd.text =  ""
            zdif.text = ""
        }
        else{
            dist3dd.text = dist3d + " m"
            hdist.text = hdistt + " m"
            zdif.text = zdiff + " m"
            angle_text_output(abg_z.toFixed(4), abg_to2_z)
        }
    }
}
//-----DISTANCE PAGE----------------------------------------------------------------------
// help
function dist_help(){
    if(dist_count2%2==1){
        return "qrc:/help/DistanceHelp.qml"
    }
    else if(dist_count2%2==0){
        return "Distance.qml"
    }
}
function dist_helpicon(){
    if(dist_count2%2==1){
        return "close"

    }
    else if(dist_count2%2==0){
        return "help"
    }
}
//----------------------------------------------------------------------------
