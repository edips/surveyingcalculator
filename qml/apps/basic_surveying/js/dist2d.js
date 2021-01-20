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

function calc2d() {
    if(dist2d_1.east.text === "" || dist2d_2.east.text === "" || dist2d_1.north.text === "" || dist2d_2.north.text === "" )
    {
        snack.open( qsTr( "Please enter the values." ) )
        dist_2d.text = ""
    }
    else {
        //input parameters
        var y1 = parseFloat( dist2d_1.east.text )
        var y2 = parseFloat( dist2d_2.east.text )
        var x1 = parseFloat( dist2d_1.north.text )
        var x2 = parseFloat( dist2d_2.north.text )

        // horizontal distance calculation
        var dist2d = ( Math.sqrt( ( y1 - y2 ) * ( y1 - y2 ) + ( x1 - x2 ) * ( x1 - x2 ) ) ).toFixed( 3 )

        // bearing calculation
        // delta y
        var dy = y2 - y1
        var dx = x2 - x1

        var abg = angle_pi() * Math.atan( dy / dx )
        // Aciklik Acisi
        // TODO: bunların hepsi script.js'de bir fonksyona dönüştürülecek, amele işi yapılmayacak. azimuth(abg, dx, dy) şeklinde
        if(dy === 0 && dx > 0 ) {
            abg = 0
        }
        else if( dx === 0 && dy > 0 ) {
            abg = angle_100()
        }
        else if( dy === 0 && dx < 0 ) {
            abg = angle_200()
        }
        else if( dx === 0 && dy < 0 ) {
            abg = angle_300()
        }
        else if( dx < 0 && dy > 0 ) {
            abg = abg + angle_200();
        }
        else if( dx < 0 && dy < 0 ) {
            abg = abg + angle_200();
        }
        else if( dx > 0 && dy < 0 ){
            abg = abg + angle_400();
        }

        lengthUnits( dist_2d, dist2d )
        angle_text_output( abg, abg_to2 )
    }
}

