Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//------------------------------------COSINUS CALC-------------------------------------------------------------------
function cosinus(){
    var a= myparser(a_k)
    var b= myparser(b_k)
    var c= myparser(c_k)
    var alf=(Calc.angle_pi()*Math.acos((b*b+c*c-a*a)/(2*b*c))).toFixed(4)
    var bta=(Calc.angle_pi()*Math.acos((a*a+c*c-b*b)/(2*a*c))).toFixed(4)
    var gma=(Calc.angle_pi()*Math.acos((a*a+b*b-c*c)/(2*a*b))).toFixed(4)

    if( a_k.text==="" || b_k.text==="" || c_k.text==="" )
        {
        snack.open(qsTr("Please enter the values."))
        }
    else if( a_k.text<=0 || b_k.text<=0 || c_k.text<=0 )
        {
        snack.open(qsTr("Please check the parameters."))
        }

    else if((Math.abs(a-b)).toFixed(1)<c && c<(a+b).toFixed(1) || (Math.abs(a-c)).toFixed(1)<b && b<(a+c).toFixed(1) || (Math.abs(b-c)).toFixed(1)<a && a<(b+c).toFixed(1))
    {
        angle_text_output(alf, alfa)
        angle_text_output(bta, beta)
        angle_text_output(gma, gama)
    }

    else{
        snack.open(qsTr("It doesn't obey triangle rule. Please try again."))
    }



        if( isNaN(alfa.text) || isNaN(beta.text) || isNaN(gama.text) )
        {
            alfa.text=""
            beta.text=""
            gama.text=""
        }
}
//----COSINUS PAGE----------------------------------------------------------------------------------------
// icon
function cos_icon(){
    if(cos_count%2==1){
        return "toggle/star"
      }
    else if(cos_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function cos_help(){
    if(cos_count2%2==1){
        return "../help/CosinusHelp.qml"
      }
    else if(cos_count2%2==0){
        return "cosinus.qml"
    }
  }
function cos_helpicon(){
    if(cos_count2%2==1){
        return "navigation/close"
      }
    else if(cos_count2%2==0){
        return "action/help"
    }
  }
//-------------------------------------------------------------------------------------------
