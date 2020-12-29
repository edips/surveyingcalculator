// Generate Latitude Longitude between two Points PAGE
// icon
function latlon_icon(){
    if(latlon_count%2==1){
        return "toggle/star"
      }
    else if(latlon_count%2==0){
        return "toggle/star_border"
    }
  }

// help
function latlon_help(){
    if(latlon_count2%2==1){
        return "../help/GenerateXYHelp.qml"
      }
    else if(latlon_count2%2==0){
        return "GenerateXY.qml"
    }
  }
function latlon_helpicon(){
    if(latlon_count2%2==1){
        return "navigation/close"

      }
    else if(latlon_count2%2==0){
        return "action/help"
    }
  }
//----------------------------------------------------------------------------
