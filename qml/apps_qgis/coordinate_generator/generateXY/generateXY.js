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
