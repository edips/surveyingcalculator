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

function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//--------------------------------MAP SCALE CALC-----------------------------------------------------------
function mapscale(){
    var mdist   = myparser(sMap)
    var gdist   = myparser(sGround)
    var gmap    = myparser(gMap)
    var gscl    = myparser(gscale)
    var mpscale = myparser(mscale)
    var mpground= myparser(mGround)
//Map Scale Calculation
  if(scale_combo.currentIndex===0){
        if( sMap.text==="" || sGround.text==="")
            {
            snack.open(qsTr("Please enter the values."))
            }
        else if( sMap.text<=0 || sGround.text<=0)
            {
            snack.open(qsTr("Parameters cannot be negative or 0."))
            }
        //map unit is mm
        else if(unit_s1.currentIndex===0){
           if(unit_s2.currentIndex===1){
                sresult.text="1:"+((gdist*1000)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===0){
                sresult.text="1:"+((gdist*1000000)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===2){
                sresult.text="1:"+((gdist*304.8)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===3){
                sresult.text="1:"+((gdist*1609344)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===4){
                sresult.text="1:"+((gdist*1852000)/mdist).toFixed(0)
            }
        }
    //map unit is cm
    else if(unit_s1.currentIndex===1){
       if(unit_s2.currentIndex===1){
            sresult.text="1:"+((gdist*100)/mdist).toFixed(0)
        }
        else if(unit_s2.currentIndex===0){
            sresult.text="1:"+((gdist*100000)/mdist).toFixed(0)
        }
        else if(unit_s2.currentIndex===2){
            sresult.text="1:"+((gdist*30.48)/mdist).toFixed(0)
        }
        else if(unit_s2.currentIndex===3){
            sresult.text="1:"+((gdist*160934.4)/mdist).toFixed(0)
        }
        else if(unit_s2.currentIndex===4){
            sresult.text="1:"+((gdist*185200)/mdist).toFixed(0)
        }
    }
        //map unit is inch
        else if(unit_s1.currentIndex===2){
           if(unit_s2.currentIndex===1){
                sresult.text="1:"+((gdist*39.3701)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===0){
                sresult.text="1:"+((gdist*39370.1)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===2){
                sresult.text="1:"+((gdist*12)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===3){
                sresult.text="1:"+((gdist*63360)/mdist).toFixed(0)
            }
            else if(unit_s2.currentIndex===4){
                sresult.text="1:"+((gdist*72913.4)/mdist).toFixed(0)
            }
        }
    }

// ground distance calculation
    else if(scale_combo.currentIndex===1){
        if(gscale.text==="" || gMap.text==="")
            {
            snack.open(qsTr("Please enter the values."))
            }
        else if( gscale.text<=0 || gMap.text<=0)
            {
            snack.open(qsTr("Parameters cannot be negative or 0."))
            }
        //mm to others
        else if(unitg2.currentIndex===0){
            if(gunitresult.currentIndex===0){
                gresult.text=((gmap*gscl)/1000000).toFixed(2)
            }
            else if(gunitresult.currentIndex===1){
                gresult.text=((gmap*gscl)/1000).toFixed(2)
            }
            else if(gunitresult.currentIndex===2){
                gresult.text=((gmap*gscl)/304.8).toFixed(2)
            }
            else if(gunitresult.currentIndex===3){
                gresult.text=((gmap*gscl)/1609344).toFixed(2)
            }
            else if(gunitresult.currentIndex===4){
                gresult.text=((gmap*gscl)/1852000).toFixed(2)
            }
        }
        // cm to others
        else if(unitg2.currentIndex===1){
            if(gunitresult.currentIndex===0){
                gresult.text=((gmap*gscl)/100000).toFixed(2)
            }
            else if(gunitresult.currentIndex===1){
                gresult.text=((gmap*gscl)/100).toFixed(2)
            }
            else if(gunitresult.currentIndex===2){
                gresult.text=((gmap*gscl)/30.48).toFixed(2)
            }
            else if(gunitresult.currentIndex===3){
                gresult.text=((gmap*gscl)/160934.4).toFixed(2)
            }
            else if(gunitresult.currentIndex===4){
                gresult.text=((gmap*gscl)/185200).toFixed(2)
            }
        }
        // inch to others
        else if(unitg2.currentIndex===2){
            if(gunitresult.currentIndex===0){
                gresult.text=((gmap*gscl)/39370.1).toFixed(2)
            }
            else if(gunitresult.currentIndex===1){
                gresult.text=((gmap*gscl)/39.3701).toFixed(2)
            }
            else if(gunitresult.currentIndex===2){
                gresult.text=((gmap*gscl)/12).toFixed(2)
            }
            else if(gunitresult.currentIndex===3){
                gresult.text=((gmap*gscl)/63360).toFixed(2)
            }
            else if(gunitresult.currentIndex===4){
                gresult.text=((gmap*gscl)/72913.4).toFixed(2)
            }
        }
    }
// map distance

    else if(scale_combo.currentIndex===2){
        if( mGround.text==="" || mscale.text==="")
            {
            snack.open(qsTr("Please enter the values."))
            }
        else if( mGround.text<=0 || mscale.text<=0)
            {
            snack.open(qsTr("Parameters cannot be negative or 0."))
            }
        //mm to others
        else if(sunitresult.currentIndex===0){
            if(unitm2.currentIndex===0){
                mresult.text=((mpground*1000000)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===1){
                mresult.text=((mpground*1000)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===2){
                mresult.text=((mpground*304.8)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===3){
                mresult.text=((mpground*1609344)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===4){
                mresult.text=((mpground*1852000)/mpscale).toFixed(2)
            }
        }
        //cm
        else if(sunitresult.currentIndex===1){
            if(unitm2.currentIndex===0){
                mresult.text=((mpground*100000)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===1){
                mresult.text=((mpground*100)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===2){
                mresult.text=((mpground*30.48)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===3){
                mresult.text=((mpground*160934.4)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===4){
                mresult.text=((mpground*185200)/mpscale).toFixed(2)
            }
        }
        //inch
        else if(sunitresult.currentIndex===2){
            if(unitm2.currentIndex===0){
                mresult.text=((mpground*39370.1)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===1){
                mresult.text=((mpground*39.3701)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===2){
                mresult.text=((mpground*12)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===3){
                mresult.text=((mpground*63360)/mpscale).toFixed(2)
            }
            else if(unitm2.currentIndex===4){
                mresult.text=((mpground*72913.4)/mpscale).toFixed(2)
            }
        }
    }

}
//---------------MAP SCALE PAGE--------------------------------------
//icon
function scale_icon(){
    if(scale_count%2==1){
        return "toggle/star"
      }
    else if(scale_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function scale_help(){
    if(scale_count2%2==1){
        return "../help/MapScaleHelp.qml"
      }
    else if(scale_count2%2==0){
        return "MapScale.qml"
    }
  }
function scale_helpicon(){
    if(scale_count2%2==1){
        return "navigation/close"

      }
    else if(scale_count2%2==0){
        return "action/help"
    }
  }
//----------------------------------------------------------------------------------------------------------
