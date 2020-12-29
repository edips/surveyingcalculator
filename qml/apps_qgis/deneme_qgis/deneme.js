Qt.include("../index.js")
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
//  favorites
function fav_mapview(){
    if(map_count%2==1){
        console.log("it works:)")
        var index = find(Shared.favModel, function(item) { return item.source === "content/mapviewer/MapViewer2.qml" })
        console.log(index)
      Shared.favModel.append({ "title": qsTr("Map View"), "source": "content/mapviewer/MapViewer2.qml", "imgsrc":"qrc:mapviewer.png" })
    }
    else if(map_count%2==0){
        var indexx = find(Shared.favModel, function(item) { return item.source === "content/mapviewer/MapViewer2.qml" })
        console.log(indexx)
        Shared.favModel.remove(indexx)
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
