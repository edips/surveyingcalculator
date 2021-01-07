Qt.include("script.js")

function calc3d() {
    if(dist3d_1.easting.text==="" || dist3d_2.easting.text==="" || dist3d_1.northing.text==="" || dist3d_2.northing.text==="" || dist3d_1.elev.text==="" || dist3d_2.elev.text==="")
    {
        snack.open(qsTr("Please enter the values."))
        dist3dd.text =  ""
        zdif.text = ""
    }
    else{
        // 3d
        var y1_d = parseFloat(dist3d_1.easting.text)
        var y2_d = parseFloat(dist3d_2.easting.text)
        var x1_d = parseFloat(dist3d_1.northing.text)
        var x2_d = parseFloat(dist3d_2.northing.text)
        var z1_d = parseFloat(dist3d_1.elev.text)
        var z2_d = parseFloat(dist3d_2.elev.text)

        // 3d
        var dist3d = ( Math.sqrt( ( y1_d - y2_d ) * ( y1_d - y2_d ) + ( x1_d - x2_d ) * ( x1_d - x2_d ) + ( z1_d - z2_d ) * ( z1_d - z2_d ) ) ).toFixed(3)
        var hdistt = ( Math.sqrt( ( y1_d - y2_d ) * ( y1_d - y2_d ) + ( x1_d - x2_d ) * ( x1_d - x2_d ) ) ).toFixed( 3 )
        var zdiff = ( z1_d - z2_d ).toFixed( 3 )
        // bearing calc
        var dy_z = y2_d - y1_d
        var dx_z = x2_d - x1_d
        var abg_z = angle_pi()*Math.atan(dy_z/dx_z)

        if(dy_z===0 && dx_z>0){
            abg_z=0
        }
        else if(dx_z===0 && dy_z>0){
            abg_z=angle_100()
        }
        else if(dy_z===0 && dx_z<0){
            abg_z=angle_200()
        }
        else if(dx_z===0 && dy_z<0){
            abg_z=angle_300()
        }
        else if(dx_z<0 && dy_z>0){
            abg_z = abg_z+angle_200();
        }
        else if(dx_z<0 && dy_z<0){
            abg_z = abg_z+angle_200();
        }
        else if(dx_z>0 && dy_z<0){
            abg_z = abg_z+angle_400();
        }

        lengthUnits( dist3dd, dist3d )
        lengthUnits( hdist, hdistt )
        lengthUnits( zdif, zdiff )
        angle_text_output(abg_z.toFixed(4), abg_to2_z)
    }
}
