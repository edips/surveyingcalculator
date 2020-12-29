Qt.include("index.js")
//-----------PyCalculator PAGE------------------------------------------------------------------------
//icon
function pycalc_icon(){
    if(pycalc_count%2==1){
        return "toggle/star"
      }
    else if(pycalc_count%2==0){
        return "toggle/star_border"
    }
  }
//favorite
function pycalc_fav(){
    if(pycalc_count%2==1){
      Shared.favModel.append({ "title": qsTr("PyCalculator"), "source": "content/pycalc/SmartCalc2.qml", "imgsrc":"qrc:pyCalculator.png"})
    }
    else if(pycalc_count%2==0){
        var indexx = find(Shared.favModel, function(item) { return item.source === "content/pycalc/SmartCalc2.qml"})
        console.log(indexx)
        Shared.favModel.remove(indexx)
    }
}
//help
function pycalc_help(){
    if(pycalc_count2%2==1){
        return "../help/PyCalculatorHelp.qml"
      }
    else if(pycalc_count2%2==0){
        return "SmartCalc2.qml"
    }
  }
function pycalc_helpicon(){
    if(pycalc_count2%2==1){
        return "navigation/close"

      }
    else if(pycalc_count2%2==0){
        return "action/help"
    }
  }
//-----------------------------------------------------------------------------------------------------
