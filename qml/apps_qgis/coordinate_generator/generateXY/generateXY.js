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

// icon
function generate_xy_icon(){
    if(generate_xy_count%2==1){
        return "toggle/star"
      }
    else if(generate_xy_count%2==0){
        return "toggle/star_border"
    }
  }
// help
function generate_xy_help(){
    if(generate_xy_count2%2==1){
        return "../help/GenerateXYHelp.qml"
      }
    else if(generate_xy_count2%2==0){
        return "GenerateXY.qml"
    }
  }
function generate_xy_helpicon(){
    if(generate_xy_count2%2==1){
        return "navigation/close"

      }
    else if(generate_xy_count2%2==0){
        return "action/help"
    }
  }
//----------------------------------------------------------------------------
