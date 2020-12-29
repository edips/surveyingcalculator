Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//----------------------------------BACK AZIMUTH CALC----------------------------------------------------------------
function backazimuth(){
    // input parameters
    var a1 = angle_text_input(a_1)
    var b1= angle_text_input(b_1)
    var x1= myparser(x_1)
    var y1= myparser(y_1)
    var xm= myparser(x_2)
    var ym= myparser(y_2)
    var x3= myparser(x_3)
    var y3= myparser(y_3)
    // end
    var dx1 = xm - x1;
    var dy1 = ym - y1;
    var dxm3 = xm - x3;
    var dym3 = ym - y3;
    var dx1t = x1 - xm;
    var dy1t = y1 - ym;
    var dxm3t = x3 - xm;
    var dym3t = y3 - ym;
    var dx13 = x3 - x1;
    var dx31 = x1 - x3;
    var dy13 = y3 - y1;
    var dy31 = y1 - y3;
    var s1 = Math.sqrt(dx1*dx1 + dy1*dy1);
    var s2 = Math.sqrt(dxm3*dxm3 + dym3*dym3);
    var t13 = Calc.angle_pi()*Math.atan(dy13/dx13);
    var t31 = Calc.angle_pi()*Math.atan(dy31/dx31);
    var t1m = Calc.angle_pi()*Math.atan(dy1/dx1);
    var tm1 = Calc.angle_pi()*Math.atan(dy1t/dx1t);
    var t3m = Calc.angle_pi()*Math.atan(dym3/dxm3);
    var tm3 = Calc.angle_pi()*Math.atan(dym3t/dxm3t);
//Aciklik acisi hesabi------------------------------------------------
    if(dx1===0 && dy1===0)
    {
    snack.open(qsTr("Please check the coordinates."))
    }
//----t13 ve t31---------------------------------------------------------
    if(dy13===0 && dx13>0){
        t13=0
    }
    else if(dx13===0 && dy13>0){
        t13=Calc.angle_100()
    }
    else if(dy13===0 && dx13<0){
        t13=Calc.angle_200()
    }
    else if(dx13===0 && dy13<0){
        t13=Calc.angle_300()
    }
    else if(dx13<0 && dy13>0){
        t13 = t13+Calc.angle_200();
    }
    else if(dx13<0 && dy13<0){
        t13 = t13+Calc.angle_200();
    }
    else if(dx13>0 && dy13<0){
        t13 = t13+Calc.angle_400();
    }
//--------------------------------------------------------------------------------------------------------------
    if(dy31===0 && dx31>0){
        t31=0
    }
    else if(dx31===0 && dy31>0){
        t31=Calc.angle_100()
    }
    else if(dy31===0 && dx31<0){
        t31=Calc.angle_200()
    }
    else if(dx31===0 && dy31<0){
        t31=Calc.angle_300()
    }
    else if(dx31<0 && dy31>0){
        t31 = t31+Calc.angle_200();
    }
    else if(dx31<0 && dy31<0){
        t31 = t31+Calc.angle_200();
    }
    else if(dx31>0 && dy31<0){
        t31 = t31+Calc.angle_400();
    }
//------------------------------------------------------------------------
    if(dy1===0 && dx1>0){
        t1m=0
    }
    else if(dx1===0 && dy1>0){
        t1m=Calc.angle_100()
    }
    else if(dy1===0 && dx1<0){
        t1m=Calc.angle_200()
    }
    else if(dx1===0 && dy1<0){
        t1m=Calc.angle_300()
    }
    else if(dx1<0 && dy1>0){
        t1m = t1m+Calc.angle_200();
    }
    else if(dx1<0 && dy1<0){
        t1m = t1m+Calc.angle_200();
    }
    else if(dx1>0 && dy1<0){
        t1m = t1m+Calc.angle_400();
    }
//-----------------------------------------------------------------------------------------------------
    if(dy1t==0 && dx1t>0){
        tm1=0
    }
    else if(dx1t==0 && dy1t>0){
        tm1=Calc.angle_100()
    }
    else if(dy1t==0 && dx1t<0){
        tm1=Calc.angle_200()
    }
    else if(dx1t==0 && dy1t<0){
        tm1=Calc.angle_300()
    }
    else if(dx1t<0 && dy1t>0){
        tm1 = tm1+Calc.angle_200();
    }
    else if(dx1t<0 && dy1t<0){
        tm1 = tm1+Calc.angle_200();
    }
    else if(dx1t>0 && dy1t<0){
        tm1 = tm1+Calc.angle_400();
    }

//--------------------------------------------------------------------------------------------------------------
    if(dym3t==0 && dxm3t>0){
        tm3=0
    }
    else if(dxm3t==0 && dym3t>0){
        tm3=Calc.angle_100()
    }
    else if(dym3t==0 && dxm3t<0){
        tm3=Calc.angle_200()
    }
    else if(dxm3t==0 && dym3t<0){
        tm3=Calc.angle_300()
    }
    else if(dxm3t<0 && dym3t>0){
        tm3 = tm3+Calc.angle_200();
    }
    else if(dxm3t<0 && dym3t<0){
        tm3 = tm3+Calc.angle_200();
    }
    else if(dxm3t>0 && dym3t<0){
        tm3 = tm3+Calc.angle_400();
    }
//-----------------------------------------------------------------------------------------------
    if(dym3==0 && dxm3>0){
        t3m=0
    }
    else if(dxm3==0 && dym3>0){
        t3m=Calc.angle_100()
    }
    else if(dym3==0 && dxm3<0){
        t3m=Calc.angle_200()
    }
    else if(dxm3==0 && dym3<0){
        t3m=Calc.angle_300()
    }
    if(dxm3<0 && dym3>0){
        t3m = t3m+Calc.angle_200();
    }
    else if(dxm3<0 && dym3<0){
        t3m = t3m+Calc.angle_200();
    }
    else if(dxm3>0 && dym3<0){
        t3m = t3m+Calc.angle_400();
    }
//Aciklik acisi hesabi son------------------------------------------------
    var ee = Math.abs(t13 - t1m)

    if(t13>Calc.angle_300() && Math.abs(t13-t1m)>Calc.angle_300()){
        ee=Calc.angle_400()-t13+t1m
    }
    else if(t1m>=Calc.angle_300() && Math.abs(t13-t1m)>Calc.angle_300()){
        ee=Calc.angle_400()-t1m+t13
    }

    var ff = Math.abs(t31 - t3m)
    if(t31>=Calc.angle_300() && Math.abs(t31-t3m)>Calc.angle_300()){
        ff=Calc.angle_400()-t31+t3m
    }
    else if(t3m>=Calc.angle_300() && Math.abs(t31-t3m)>Calc.angle_300()){
        ff=Calc.angle_400()-t3m+t31
    }
    var g=0
    if(tm1>tm3){
        g=(tm3+Calc.angle_400())-tm1
    }
    else {
        g=tm3-tm1
    }
    if(g>Calc.angle_200()){
        g=Calc.angle_400()-g
    }
    var bb=Calc.angle_400()-a1-b1
    var k1 = 1/((1/Math.tan(Calc.angle_unit(ee)))-(1/Math.tan(Calc.angle_unit(b1))))
    var k2=1/((1/Math.tan(Calc.angle_unit(g)))-(1/Math.tan(Calc.angle_unit(bb))))
    var k3=1/((1/Math.tan(Calc.angle_unit(ff)))-(1/Math.tan(Calc.angle_unit(a1))))
    var xpp=(k1*x1+k2*xm+k3*x3)/(k1+k2+k3)
    var ypp=(k1*y1+k2*ym+k3*y3)/(k1+k2+k3)
    var s = Math.sqrt((ypp-ym)*(ypp-ym) + (xpp-xm)*(xpp-xm))
    var s1p = Math.sqrt((xpp-x1)*(xpp-x1) + (ypp-y1)*(ypp-y1))
    var s3p = Math.sqrt((xpp-x3)*(xpp-x3) + (ypp-y3)*(ypp-y3))
    var fg = Math.abs( Calc.angle_pi()*Math.acos((s*s + s1*s1 - s1p*s1p)/(2*s1*s)) )
    var l = Calc.angle_200() - g+fg-b1
    var k = Calc.angle_200()-fg-a1
//---------a1p ve a3p aciklik acisi--------------------------------------
    var dyp1 = ypp-y1
    var dyp3 = ypp-y3
    var dxp1 = xpp-x1
    var dxp3 = xpp-y3
    var a1p = Calc.angle_pi()*Math.atan((ypp-y1)/(xpp-x1));
    var a3p = Calc.angle_pi()*Math.atan((ypp-y3)/(xpp-y3));
//------------------------------------------------------------------------
    if(dyp1==0 && dxp1>0){
      a1p=0
    }
    else if(dxp1==0 && dyp1>0){
       a1p=Calc.angle_100()
    }
    else if(dyp1==0 && dxp1<0){
       a1p=Calc.angle_200()
    }
    else if(dxp1==0 && dyp1<0){
      a1p=Calc.angle_300()
    }
    else if(dxp1<0 && dyp1>0){
       a1p = a1p+Calc.angle_200();
    }
    else if(dxp1<0 && dyp1<0){
      a1p = a1p+Calc.angle_200();
    }
    else if(dxp1>0 && dyp1<0){
      a1p = a1p+Calc.angle_400();
    }
//--------------------------------------------------------------------------------------------------------------
    if(dyp3==0 && dxp3>0){
       a3p=0
     }
    else if(dxp3==0 && dyp3>0){
      a3p=Calc.angle_100()
    }
    else if(dyp3==0 && dxp3<0){
      a3p=Calc.angle_200()
    }
    else if(dxp3==0 && dyp3<0){
      a3p=Calc.angle_300()
    }
    else if(dxp3<0 && dyp3>0){
      a3p = a3p+Calc.angle_200();
    }
    else if(dxp3<0 && dyp3<0){
      a3p = a3p+Calc.angle_200();
    }
    else if(dxp3>0 && dyp3<0){
      a3p = a3p+Calc.angle_400();
    }
//-------Aciklik acisi son-----------------------------------------------------
    if(a_1.text==="" || b_1.text==="" || x_1.text==="" || y_1.text==="" || x_2.text==="" || y_2.text==="" ||
                x_3.text==="" || y_3.text===""  )
        {
        snack.open(qsTr("Please enter the values."))
        }
    else if(a_1.text==='0' || b_1.text==='0'){
        snack.open(qsTr("α and β cannot be 0."))
    }
    else if((a1+b1+g).toFixed(1)===Calc.angle_200()){
        snack.open(qsTr("Coordinates in a circle cannot be calculated."))
    }
    else if((a1+b1)>Calc.angle_200()){
        snack.open(qsTr("The sum of α and β exceeded the limit."))
    }

    else if(a1>Calc.angle_200() || b1>Calc.angle_200()){
        snack.open(qsTr("Please check α or β."))
    }
    else if(a1<=0 || b1<=0){
        snack.open(qsTr("α or β cannot be less than 0."))
    }
    else{
        yp.text=ypp.toFixed(3)
        xp.text=xpp.toFixed(3)
    }
//---------------------------------------------------------------------------------------------------
    //a1pp.text=a1p.toFixed(3)
    //a3pp.text=a3p.toFixed(3)
    angle_text_output(tm1.toFixed(4), aan)
    angle_text_output(tm3.toFixed(4), bbn)
    saa.text=s1.toFixed(3)
    sbb.text=s2.toFixed(3)
    s_mesafe.text=s.toFixed(3)
    angle_text_output(k.toFixed(4), k_1)
    angle_text_output(l.toFixed(4), l_1)
    p1p.text=s1p.toFixed(3)
    p3p.text=s3p.toFixed(3)
    //aci_kontrol.text=(a1+b1+g+k+l).toFixed(2)
    angle_text_output(g.toFixed(4), gamma)
    angle_text_output(t1m.toFixed(4), t1mm)
    angle_text_output(t3m.toFixed(4), t3mm)
    angle_text_output(t13.toFixed(4), t133)
    angle_text_output(t31.toFixed(4), t311)

//---------------------------------------------------------------------------------------------------------------------
}
//----RESECTION FROM 3 POINTS PAGE-----------------------------------------------
// fav icon
function back_icon(){
    if(count_back%2==1){
        return "toggle/star"
      }
    else if(count_back%2==0){
        return "toggle/star_border"
    }
  }
// help
function back_help(){
    if(count_back2%2==1){
        return "../help/BackazimuthHelp.qml"
      }
    else if(count_back2%2==0){
        return "Backazimuth.qml"
    }
  }
function back_helpicon(){
    if(count_back2%2==1){
        return "navigation/close"
      }
    else if(count_back2%2==0){
        return "action/help"
    }
  }
//------------------------------------------------------------------------------------------------------
