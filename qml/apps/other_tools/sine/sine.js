Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//----------------------------------------SINUS CALC--------------------------------------------------------
function sinuscalc(){
    //console.log("maybe it works :) " + Calc.angle_unit(30))
    if(sine_combo.currentIndex===0){
    var a_s = myparser(a_side)
    var b_s = myparser(b_side)
    var bet = angle_text_input(beta)

    var alph = Calc.angle_pi()*Math.asin((a_s*Math.sin(Calc.angle_unit(bet))/b_s))


    if( a_side.text==="" || b_side.text==="" || beta.text==="" )
        {
        snack.open(qsTr("Please enter the values."))
        }
    else if( a_side.text<=0 || b_side.text<=0 || beta.text<=0 )
        {
        snack.open(qsTr("Please check the parameters."))
        }
    else{
        angle_text_output(alph.toFixed(4), alpharesult)
    }
    }
    else if(sine_combo.currentIndex===1){
        var alp2= angle_text_input(alpha2);
        var bet2= angle_text_input(beta2);
        var b_s2= parseFloat(bside2.text);
        var a_sidee=b_s2*Math.sin(Calc.angle_unit(alp2))/Math.sin(Calc.angle_unit(bet2))
        if( alpha2.text==="" || beta2.text==="" || bside2.text==="" )
            {
            snack.open(qsTr("Please enter the values."))
            }
        else if( alpha2.text<=0 || beta2.text<=0 || bside2.text<=0 )
            {
            snack.open(qsTr("Please check the parameters."))
            }
        else{
            aresult.text=a_sidee.toFixed(4)
        }

    }
    /*
    else if((Math.abs(a-b)).toFixed(1)<c && c<(a+b).toFixed(1) || (Math.abs(a-c)).toFixed(1)<b && b<(a+c).toFixed(1) || (Math.abs(b-c)).toFixed(1)<a && a<(b+c).toFixed(1))
    {
        alfa.text=alf
        beta.text=bta
        gama.text=gma
    }

    else{
        snack.open(qsTr("It doesn't obey triangle rule. Please try again."))
    }*/

        if( isNaN(alpharesult.text) || isNaN(aresult.text))
        {
            console.log("There is a problem..")
            alpharesult.text=""
            aresult.text=""
        }
}
//-----------------SINUS PAGE----------------------------------------------------------------------------
//icon
function sine_icon(){
    if(sine_count%2==1){
        return "toggle/star"
      }
    else if(sine_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function sine_help(){
    if(sine_count2%2==1){
        return "../help/SineHelp.qml"
      }
    else if(sine_count2%2==0){
        return "Sine.qml"
    }
  }
function sine_helpicon(){
    if(sine_count2%2==1){
        return "navigation/close"

      }
    else if(sine_count2%2==0){
        return "action/help"
    }
  }
//-----------------------------------------------------------------------------------------------
