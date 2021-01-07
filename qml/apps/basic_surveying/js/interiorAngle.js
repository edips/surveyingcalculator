Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//--------------------------------------FOUR CALC----------------------------------------------------------------
function fourcalc(){
    var xa = myparser(pt_a.north)
    var ya = myparser(pt_a.east)
    var xb = myparser(pt_b.north)
    var yb = myparser(pt_b.east)
    var xc = myparser(pt_c.north)
    var yc = myparser(pt_c.east)
    var dy1=yc-yb
    var dx1=xc-xb
    var dy2=ya-yb
    var dx2=xa-xb
    var semtbc=Calc.angle_pi()*Math.atan(dy1/dx1)
    var semtba=Calc.angle_pi()*Math.atan(dy2/dx2)
    ////----semtbc---------------------------------------------------------
    if(dy1===0 && dx1>0){
        semtbc=0
    }
    else if(dx1===0 && dy1>0){
        semtbc=Calc.angle_100()
    }
    else if(dy1===0 && dx1<0){
        semtbc=Calc.angle_200()
    }
    else if(dx1===0 && dy1<0){
        semtbc=Calc.angle_300()
    }
    else if(dx1<0 && dy1>0){
        semtbc = semtbc+Calc.angle_200();
    }
    else if(dx1<0 && dy1<0){
        semtbc = semtbc+Calc.angle_200();
    }
    else if(dx1>0 && dy1<0){
        semtbc = semtbc+Calc.angle_400();
    }
//--------------------------------------------------
    if(dy2===0 && dx2>0){
        semtba=0
    }
    else if(dx2===0 && dy2>0){
        semtba=Calc.angle_100()
    }
    else if(dy2===0 && dx2<0){
        semtba=Calc.angle_200()
    }
    else if(dx2===0 && dy2<0){
        semtba=Calc.angle_300()
    }
    else if(dx2<0 && dy2>0){
        semtba = semtba+Calc.angle_200();
    }
    else if(dx2<0 && dy2<0){
        semtba = semtba+Calc.angle_200();
    }
    else if(dx2>0 && dy2<0){
        semtba = semtba+Calc.angle_400();
    }
//----------------------------------------------------------------

    if(semtba.toFixed(1)===Calc.angle_400()){
        semtba=0
    }
    if(semtbc.toFixed(1)===Calc.angle_400()){
       semtbc=0
    }
//------------------------------------------------------------
    var abc=0
    if(semtba>semtbc){
        abc=(semtbc+Calc.angle_400())-semtba
    }
    else {
        abc=semtbc-semtba
    }
    if(abc>Calc.angle_200()){
        abc=Calc.angle_400()-abc
    }

    if(dx1===0 && dy1===0 || dy2===0 && dx2===0)
    {
    snack.open(qsTr("Please check the coordinates."))
    }

    if(pt_a.east.text === "" || pt_a.north.text === "" || pt_b.east.text===""
            || pt_b.north.text==="" || pt_c.east.text==="" || pt_c.north.text==="" )
        {
        snack.open(qsTr("Please enter the values."))
        }
    else{
        angle_text_output(abc.toFixed(4), abc_to4)
    }

}
//----FOUR PAGE-------------------------------------------------------------------------
//icon
function four_icon(){
    if(four_count%2==1){
        return "toggle/star"
      }
    else if(four_count%2==0){
        return "toggle/star_border"
    }
  }
// help
function four_help(){
    if(four_count2%2==1){
        return "../help/FourHelp.qml"
      }
    else if(four_count2%2==0){
        return "Four.qml"
    }
  }
function four_helpicon(){
    if(four_count2%2==1){
        return "navigation/close"

      }
    else if(four_count2%2==0){
        return "action/help"
    }
  }
//---------------------------------------------------------------------------------------
