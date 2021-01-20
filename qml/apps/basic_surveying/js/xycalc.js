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

function firstcalc() {
    // replace with component
    var ya = parseFloat(pt_a.east.text)
    var xa = parseFloat(pt_a.north.text)

    var ab = parseFloat(units2meter( ab_to1.text ) )
    console.log( "AB length is ", ab )
    // get angle values from input text, import script.js before using it
    var abg = angle_text_input( abg_to1 )
    var xb1 = xa + ab * Math.cos( angle_unit( abg ) )
    var yb1 = ya + ab * Math.sin( angle_unit( abg ) )

    // replace with component
    if( pt_a.east.text === "" || pt_a.north.text === "" || ab_to1.text==="" || abg_to1.text==="" ) {
        snack.open( "Please enter the values." )
    }
    else if(abg<0 || abg>angle_400()){
        snack.open( qsTr( "The angle is wrong" ) )
    }
    else if( ab <= 0 ) {
        snack.open(qsTr("Distance cannot be less than 0."))
    }
    else{
        pt_b.east.text = yb1.toFixed( 3 )
        pt_b.north.text = xb1.toFixed( 3 )
    }
}
