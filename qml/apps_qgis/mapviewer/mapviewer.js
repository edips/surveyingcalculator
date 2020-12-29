function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//-------------------------------- Map Viewer CALC------------------------------------------------------------


//---Map Viewer PAGE--------------------------------------------------------------------------------------------------------

// icon
function mapview_icon(){
    if(map_count%2==1){
        return "toggle/star"
      }
    else if(map_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function mapview_help(){
    if(map_count2%2==1){
        return true
      }
    else if(map_count2%2==0){
        return false
    }
  }
function mapview_helpicon(){
    if(maphelp.visible===true){
        return "navigation/close"
      }
    else{
        return "action/help"
    }
  }
//---------------------------------------------------------------------------------------------------
