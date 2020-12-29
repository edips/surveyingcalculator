function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//---------------------------------------linear linear CALC--------------------------------------------
function linearcalc(){
    //parseFloat(ya1.text)
    var n1 = myparser(north1)
    var n2 = myparser(north2)
    var e1 = myparser(east1)
    var e2 = myparser(east2)
    var inter=parseFloat(interp.text)
    //y = ((x1 – x)*y0 + (x – x0)*y1)/(x1 – x0)
    if(north1.text=="" || north2.text=="" || interp.text=="" || east1.text=="" || east2.text=="")
        {
        snack.open(qsTr("Please enter the values."))
        }
    if(radio_e.checked){
        var eastt = ((n2-inter)*e1 + (inter-n1)*e2)/(n2-n1)

        result.text=(eastt).toFixed(3)
    }
    else if(radio_n.checked){
        var  northh =((e2-inter)*n1 + (inter-e1)*n2)/(e2-e1)
        result.text=(northh).toFixed(3)
    }
    if(isNaN(result.text))
    {
     result.text=""
    }
}
//----------Linear Interpolation PAGE------------------------------------------------
//icon
function linear_icon(){
    if(linear_count%2==1){
        return "toggle/star"
      }
    else if(linear_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function linear_help(){
    if(linear_count2%2==1){
        return "../help/LinearHelp.qml"
      }
    else if(linear_count2%2==0){
        return "Linear.qml"
    }
  }
function linear_helpicon(){
    if(linear_count2%2==1){
        return "navigation/close"

      }
    else if(linear_count2%2==0){
        return "action/help"
    }
  }
//------------------------------------------------------------------------------------------------------
