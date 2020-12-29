//"../../../components/common/script.js"
Qt.include("../../../components/common/script.js")
//--------------------------------------FIRST CALC----------------------------------------------------------------
function firstcalc(){

    // replace with component
    var ya = parseFloat(pt_a.east.text)
    var xa = parseFloat(pt_a.north.text)


    var ab = parseFloat(ab_to1.text)
    // get angle values from input text, import script.js before using it
    var abg = angle_text_input(abg_to1)
    var xb1 = xa + ab*Math.cos(Calc.angle_unit(abg))
    var yb1 = ya + ab*Math.sin(Calc.angle_unit(abg))

    // replace with component
    if(pt_a.east.text === "" || pt_a.north.text === "" || ab_to1.text==="" || abg_to1.text==="")
        {
        var a ="Please enter the values."
        snack.open(a)
        }
    else if(abg<0 || abg>Calc.angle_400()){
        snack.open(qsTr("The angle is wrong"))
    }
    else if(ab<=0){
        snack.open(qsTr("Distance cannot be less than 0."))
    }
    else{
        pt_b.east.text = yb1.toFixed(3)
        pt_b.north.text = xb1.toFixed(3)
    }
}
//--------------FIRST PAGE-------------------------------------------------------------------------------------
// icon
function first_icon(){
    if(first_count%2==1){
        return "toggle/star"
      }
    else if(first_count%2==0){
        return "toggle/star_border"
    }
  }
// help
function first_help(){
    if(first_count2%2==1){
        return "../help/FirstHelp.qml"
      }
    else if(first_count2%2==0){
        return "First.qml"
    }
  }
function first_helpicon(){
    if(first_count2%2==1){
        return "navigation/close"
      }
    else if(first_count2%2==0){
        return "action/help"
    }
  }
//-----------------------------------------------------------------------------------------------
