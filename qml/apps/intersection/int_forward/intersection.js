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

Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//---------------------------------------INTERSECTION CALC-------------------------------------------------------
function intersectioncalc(){
    var a = angle_text_input(a2)
    var b = angle_text_input(b2)
    var x1 = myparser(pt_1.north)
    var y1 = myparser(pt_1.east)
    var x2 = myparser(pt_2.north)
    var y2 = myparser(pt_2.east)
    var dx1=x2-x1
    var dy1=y2-y1
    var dx2=x1-x2
    var dy2=y1-y2
    var s=Math.sqrt(dx1*dx1+dy1*dy1)
    var t12=Calc.angle_pi()*Math.atan(dy1/dx1)
    var t21=Calc.angle_pi()*Math.atan(dy2/dx2)
//Aciklik acisi hesabi
    if( dx1 === 0 && dy1 > 0 ){
        t12=0
    }
    else if( dx1 === 0 && dy1 > 0 ){
        t12=Calc.angle_100()
    }
    else if( dy1 === 0 && dx1 < 0 ){
        t12 = Calc.angle_200()
    }
    else if( dx1 === 0 && dy1 < 0 ){
        t12=Calc.angle_300()
    }
    else if( dx1<0 && dy1 > 0 ){
        t12 = t12+Calc.angle_200();
    }
    else if( dx1 < 0 && dy1 < 0 ){
        t12 = t12 + Calc.angle_200();
    }
    else if( dx1 > 0 && dy1 < 0 ){
        t12 = t12 + Calc.angle_400();
    }


    if( dx2 === 0 && dy2>0 ){
        t21=0
    }
    else if( dx2 === 0 && dy2 > 0 ){
        t21 = Calc.angle_100()
    }
    else if( dy2 === 0 && dx2 < 0 ){
        t21 = Calc.angle_200()
    }
    else if( dx2 === 0 && dy2 < 0 ){
        t21 = Calc.angle_300()
    }
    else if( dx2 < 0 && dy2 > 0 ){
        t21 = t21+Calc.angle_200();
    }
    else if( dx2 < 0 && dy2 < 0 ){
        t21 = t21 + Calc.angle_200();
    }
    else if( dx2 > 0 && dy2 < 0 ){
        t21 = t21 + Calc.angle_400();
    }
//-----------
    var t1p=t12-a
    if(t12 < Calc.angle_100() && t12 > 0 || t12 < Calc.angle_400() && t12 > Calc.angle_300()){
        t1p = t12 + a
    }
    var t2p = t21 + b
    if( t21 > Calc.angle_100() && t21 < Calc.angle_300() ){
        t2p = t21 - b
    }
    var s1 = Math.abs( ( s * Math.sin( Calc.angle_unit( b ) ) ) / ( Math.sin( Calc.angle_unit( a + b ) ) ) )
    var s2 = Math.abs((s*Math.sin(Calc.angle_unit(a)))/(Math.sin(Calc.angle_unit(a+b))))
    var xpp = ( x1*(1/Math.tan(Calc.angle_unit(b))) + x2*(1/Math.tan(Calc.angle_unit(a))) + y2-y1 )/( (1/Math.tan(Calc.angle_unit(b))) + (1/Math.tan(Calc.angle_unit(a))) )
    var ypp = ( y1*(1/Math.tan(Calc.angle_unit(b))) + y2*(1/Math.tan(Calc.angle_unit(a))) + x1-x2 )/( (1/Math.tan(Calc.angle_unit(b))) + (1/Math.tan(Calc.angle_unit(a))) )

    if(a2.text === "" || b2.text === "" || pt_1.north.text === "" || pt_1.east.text === "" || pt_2.north.text === "" || pt_2.east.text === "")
        {
        snack.open(qsTr("Please enter the values."))
        }
    else if( a + b > Calc.angle_200() || a < 0 || b < 0 ){
        snack.open(qsTr("Please check the angles."))
    }
    else{
        yp_2.text=ypp.toFixed(3)
        xp_2.text=xpp.toFixed(3)
    }
    //s_1.text = s1.toFixed(3) + " m"
    lengthUnits( s_1, s1 )

    //s_2.text = s2.toFixed(3) + " m"
    lengthUnits( s_2, s2 )

}
