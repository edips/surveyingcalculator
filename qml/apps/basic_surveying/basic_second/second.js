Qt.include("../../../components/common/script.js")
//----------------------------------------SECOND CALC-------------------------------------------------------
function secondcalc(){
    var xa = parseFloat(pt_a.north.text)
    var ya = parseFloat(pt_a.east.text)
    var xb = parseFloat(pt_b.north.text)
    var yb = parseFloat(pt_b.east.text)
    var dy = yb - ya
    var dx = xb - xa
    var ab = Math.sqrt(dy*dy + dx*dx)
    var abg = Calc.angle_pi()*Math.atan(dy/dx)
    // Aciklik Acisi
    // TODO: bunların hepsi script.js'de bir fonksyona dönüştürülecek, amele işi yapılmayacak. Calc.azimuth(abg, dx, dy) şeklinde
    if(dy===0 && dx>0){
        abg=0
    }
    else if(dx===0 && dy>0){
        abg=Calc.angle_100()
    }
    else if(dy===0 && dx<0){
        abg=Calc.angle_200()
    }
    else if(dx===0 && dy<0){
        abg=Calc.angle_300()
    }
    else if(dx<0 && dy>0){
        abg = abg+Calc.angle_200();
    }
    else if(dx<0 && dy<0){
        abg = abg+Calc.angle_200();
    }
    else if(dx>0 && dy<0){
        abg = abg+Calc.angle_400();
    }
    if( pt_a.north.text === "" || pt_a.east.text === "" || pt_b.north.text==="" || pt_b.east.text==="")
        {
        snack.open(qsTr("Please enter the values."))
        }
    else{
        ab_to2.text = ab.toFixed(3) + " m"
        angle_text_output(abg.toFixed(4), abg_to2)
        // abg_to2.text=abg.toFixed(4)
    }
}
//-----------------SECOND PAGE-------------------------------------------------------------------
//icon
function sec_icon(){
    if(sec_count%2==1){
        return "toggle/star"
      }
    else if(sec_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function sec_help(){
    if(sec_count2%2==1){
        return "../help/SecondHelp.qml"
      }
    else if(sec_count2%2==0){
        return "Second.qml"
    }
  }
function sec_helpicon(){
    if(sec_count2%2==1){
        return "navigation/close"
      }
    else if(sec_count2%2==0){
        return "action/help"
    }
  }
//----------------------------------------------------------------------------------------------------------
