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
//-------------------------------------DEGREE TO DECIMAL CALC-------------------------------------------------------
function degtodec(){
    // Parse text to variables
    // Angle DMS, DM and decimal
    var dms_deg  =  myparser(input_field.degdms_ang)
    var dms_min  =  myparser(input_field.mindms_ang)
    var dms_sn   =  myparser(input_field.secdms_ang)
    var dm_deg   = myparser(input_field.degdm_ang)
    var dm_min   = myparser(input_field.mindm_ang)
    var dec_a    = myparser(input_field.decimalang)

    // Lat Long settings Decimal
    var latdec = myparser(input_field.lat_decimal)
    var londec = myparser(input_field.lon_decimal)

    // Lat Long settings DMS
    var latdeg = myparser(input_field.lat_deg)
    var latmin = myparser(input_field.lat_min)
    var latsn  = myparser(input_field.lat_sec)
    var londeg = myparser(input_field.lon_deg)
    var lonmin = myparser(input_field.lon_min)
    var lonsn  = myparser(input_field.lon_sec)

    // Lat Long settings DM
    var latdeg_dm  = myparser(input_field.lat_deg_dm)
    var latmin_dm  = myparser(input_field.lat_min_dm)
    var londeg_dm  = myparser(input_field.lon_deg_dm)
    var lonmin_dm  = myparser(input_field.lon_min_dm)

    // Lat Long işlemi
   if(degree2dec.checked===true  && latlon.checked===true){
     if(dm.checked===false){
       var lat2dec=Math.abs(latdeg) + Math.abs(latmin/60) + Math.abs(latsn/3600)
       if (latdeg<0){
           lat2dec=-lat2dec
       }
           var lon2dec=Math.abs(londeg) + Math.abs(lonmin/60) + Math.abs(lonsn/3600)
       if(londeg<0){
           lon2dec=-lon2dec
       }
       output_field.lat_decimal.text = (lat2dec).toFixed(8)
       output_field.lon_decimal.text = (lon2dec).toFixed(8)
     }
     else if(dm.checked===true){
       var lat2dec3=Math.abs(latdeg_dm) + Math.abs(latmin_dm/60)
       if (latdeg_dm<0){
           lat2dec3=-lat2dec3
       }
       var lon2dec3=Math.abs(londeg_dm) + Math.abs(lonmin_dm/60)
       if(londeg_dm<0){
           lon2dec3=-lon2dec3
       }
       output_field.lat_decimal.text = parseFloat((lat2dec3).toFixed(8))
       output_field.lon_decimal.text = parseFloat((lon2dec3).toFixed(8))
     }
   }


   else if(dec2degree.checked===true && latlon.checked===true){
       if(dm.checked===false){
           var latintdeg=parseInt(latdec)
           var latintmin=parseInt((latdec-latintdeg)*60)
           var latdecsn=(latdec-latintdeg-latintmin/60)*3600
           output_field.lat_deg.text=latintdeg
           output_field.lat_min.text=Math.abs(latintmin)
           output_field.lat_sec.text=parseFloat((Math.abs(latdecsn)).toFixed(4))

           var lonintdeg=parseInt(londec)
           var lonintmin=parseInt((londec-lonintdeg)*60)
           var londecsn=(londec-lonintdeg-lonintmin/60)*3600

           output_field.lon_deg.text=lonintdeg
           output_field.lon_min.text=Math.abs(lonintmin)
           output_field.lon_sec.text=parseFloat((Math.abs(londecsn)).toFixed(4))
        }

       else if(dm.checked===true){
           var latintdeg_dm=parseInt(latdec)
           var latintmin_dm = (latdec-latintdeg_dm)*60
           output_field.lat_deg_dm.text=latintdeg_dm
           output_field.lat_min_dm.text=parseFloat(Math.abs(latintmin_dm).toFixed(6))

           var lonintdeg_dm=parseInt(londec)
           var lonintmin_dm=(londec-lonintdeg_dm)*60
           output_field.lon_deg_dm.text=lonintdeg_dm
           output_field.lon_min_dm.text=parseFloat(Math.abs(lonintmin_dm).toFixed(6))
        }

   }

    // Angle işlemi
   else if(degree2dec.checked===true && latlon.checked===false){
     if(dm.checked===false){
       var dec_decimal=Math.abs(dms_deg) + Math.abs(dms_min/60) + Math.abs(dms_sn/3600)
       if (dms_deg<0){
           dec_decimal=-dec_decimal
       }
       output_field.decimalang.text=parseFloat((dec_decimal).toFixed(8))
    }
     else if(dm.checked===true){
         var dec_decimal2=Math.abs(dm_deg) + Math.abs(dm_min/60)
         if (dm_deg<0){
             dec_decimal2=-dec_decimal2
         }
         output_field.decimalang.text=parseFloat((dec_decimal2).toFixed(8))

     }

   }


   else if(dec2degree.checked===true && latlon.checked===false){
       if(dm.checked===false){
           var deg_angle=parseInt(dec_a)
           var min_angle=parseInt((dec_a-deg_angle)*60)
           var sn_angle=(dec_a-deg_angle-min_angle/60)*3600
           output_field.degdms_ang.text=deg_angle
           output_field.mindms_ang.text=Math.abs(min_angle)
           output_field.secdms_ang.text=parseFloat((Math.abs(sn_angle)).toFixed(4))
        }
       else if(dm.checked===true){
           var deg_angle2=parseInt(dec_a)
           var min_angle2=(dec_a-deg_angle2)*60
           output_field.degdm_ang.text=deg_angle2
           output_field.mindm_ang.text=parseFloat(Math.abs(min_angle2).toFixed(6))
      }

   }

   if(isNaN(output_field.degdms_ang.text) ||
      isNaN(output_field.mindms_ang.text) ||
      isNaN(output_field.secdms_ang.text) ||
      isNaN(output_field.degdm_ang.text) ||
      isNaN(output_field.mindm_ang.text) ||
      isNaN(output_field.decimalang.text) ||
      isNaN(output_field.lat_decimal.text) ||
      isNaN(output_field.lon_decimal.text) ||
      isNaN(output_field.lat_deg.text) ||
      isNaN(output_field.lat_min.text) ||
      isNaN(output_field.lat_sec.text) ||
      isNaN(output_field.lon_deg.text) ||
      isNaN(output_field.lon_min.text) ||
      isNaN(output_field.lon_sec.text) ||
      isNaN(output_field.lat_deg_dm.text) ||
      isNaN(output_field.lat_min_dm.text) ||
      isNaN(output_field.lon_deg_dm.text) ||
      isNaN(output_field.lon_min_dm.text) )
   {
       output_field.degdms_ang.text =
       output_field.mindms_ang.text =
       output_field.secdms_ang.text =
       output_field.degdm_ang.text =
       output_field.mindm_ang.text =
       output_field.decimalang.text =
       output_field.lat_decimal.text =
       output_field.lon_decimal.text =
       output_field.lat_deg.text =
       output_field.lat_min.text =
       output_field.lat_sec.text =
       output_field.lon_deg.text =
       output_field.lon_min.text =
       output_field.lon_sec.text =
       output_field.lat_deg_dm.text =
       output_field.lat_min_dm.text =
       output_field.lon_deg_dm.text =
       output_field.lon_min_dm.text = ""
   }

   /*if(isNaN(input_field.lat_decimal.text) || isNaN(input_field.lon_decimal.text) || isNaN(input_field.lat_deg_dm.text) ||
           isNaN(input_field.lat_min_dm.text) || isNaN(input_field.lon_deg_dm.text) || isNaN(input_field.lon_min_dm.text) || isNaN(lon_min_son.text) || isNaN(lon_sn_son.text))
   {
       lat_deg_son.text=lat_min_son.text=lat_sn_son.text=lon_deg_son.text=lon_min_son.text=lon_sn_son.text=lon2.text=lat2.text=""

   }*/
}
