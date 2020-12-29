Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//---------------------------------------THIRD CALC--------------------------------------------------
function thirdcalc(){
    var abg  = angle_text_input(abg_to3)

    var beta = angle_text_input(beta_to3)
    var bc = abg + beta
    if(abg_to3.text==="" || beta_to3.text==="")
        {
            snack.open(qsTr("Please enter the values."))
        }
    else if(bc>Calc.angle_800()){
        snack.open(qsTr("Please check the parameters."))
    }
    else if(abg>Calc.angle_400() || abg<0 || beta<0 || beta>Calc.angle_400()){
        snack.open(qsTr("Please check the angles."))
    }
    else{
        if(bc>=0 && bc<=Calc.angle_200()){
            bc =bc+Calc.angle_200()
        }
        else if(bc>=Calc.angle_200() && bc<=Calc.angle_400()){
            bc=bc-Calc.angle_200()
        }
        else if(bc>=Calc.angle_400() && bc<=Calc.angle_600()){
            bc=bc-Calc.angle_200()
        }
        else if(bc>=Calc.angle_600() && bc<=Calc.angle_800()){
            bc=bc-Calc.angle_600()
        }

        angle_text_output(bc.toFixed(4), bcg_to3)
   }
}
//-------------THIRD PAGE-----------------------------------------------------------------
//icon
function third_icon(){
    if(third_count%2==1){
        return "toggle/star"
      }
    else if(third_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function third_help(){
    if(third_count2%2==1){
        return "../help/ThirdHelp.qml"
      }
    else if(third_count2%2==0){
        return "Third.qml"
    }
  }
function third_helpicon(){
    if(third_count2%2==1){
        return "navigation/close"
      }
    else if(third_count2%2==0){
        return "action/help"
    }
  }
//----------------------------------------------------------------------------------
