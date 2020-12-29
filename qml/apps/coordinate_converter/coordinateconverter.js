/*
//---simple_function-----------------------------------------------------
Steps to add country coordinates:
- create proj document
- create values definition like ["wgs84", "itrf 36"] for coord_combo_changed function
- create country function and insert proj params for input and output functions. Remember indexing and for input "cogo_combo2", for outut "res_combo1"
- Add country name to CoordModel.qml
- Test calculations from epsg.io

TODO:
- Add help page
- Make documents of targeted countries and add them to this app
- Fix anchors errors
- Automatically replace north and east with latitude and longitude(as a component) maybe using states or javascript functions
- when geographic coordinates selected add a button beside equal button that should show dd.dddd or dd mm ss or dd mm . user can be able to change it with pressing the button
- when changing degree units, place holder text should appear as degree, ' or ". and text input must be like ____ or __ __ or __ __ __
- Add a function to calculate DD MM SS or DD.DDD or DD.MM coordinates

Ideas:
- Collect coordinates
- Direct to coordinate
- Get current coordinate to input
- Show accuracy of GPS
*/
// input_currentText ve output_currentText parametreleri input combosunun güncel textini çeker. Bu fonksiyonda proj4'e çevrilir.

//----------Coordinate Converter PAGE------------------------------------------------
//icon
/*
function coord_icon(){
    if(coord_count%2==1){
        return "toggle/star"
      }
    else if(coord_count%2==0){
        return "toggle/star_border"
    }
  }
//favorite
function coord_fav(){
    if(coord_count%2==1){
      Shared.favModel.append({ "title": qsTr("Coordinate Converter"), "source": "qrc:/content/coordinate_converter/CoordinateConverter2.qml", "imgsrc":"../../images/icon/coord_convert.png" })
    }
    else if(coord_count%2==0){
        var indexx = find(Shared.favModel, function(item) { return item.source === "qrc:/content/coordinate_converter/CoordinateConverter2.qml" })
        console.log(indexx)
        Shared.favModel.remove(indexx)
    }
}
*/
//--------------------------------------------------------------------
function coord_icon(){
    if(coord_count%2==1){
        return "toggle/star"
      }
    else if(coord_count%2==0){
        return "toggle/star_border"
    }
  }
// GPS button
function startgps(mycount){
    if(mycount %2 === 1){
        return true
    }
    else if(mycount %2 === 0){
        return false
    }
}
