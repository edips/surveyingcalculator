function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//----------CIRCLE CALC------------------------------------------------
function circlecalc(){
    var nk = myparser(pt_k.north)
    var ek = myparser(pt_k.east)
    var nl = myparser(pt_l.north)
    var el = myparser(pt_l.east)
    var nm = myparser(pt_m.north)
    var em = myparser(pt_m.east)
    var nc = ( (nk*nk+ek*ek)*(el-em) + (nl*nl+el*el)*(em-ek) + (nm*nm+em*em)*(ek-el) ) / (2*( nk*(el-em) - ek*(nl-nm) + nl*em - nm*el )  )
    var ec = ( (nk*nk+ek*ek)*(nm-nl) + (nl*nl+el*el)*(nk-nm) + (nm*nm+em*em)*(nl-nk) ) / (2*( nk*(el-em) - ek*(nl-nm) + nl*em - nm*el )  )
    var r=Math.sqrt((nc-nk)*(nc-nk) + (ec-ek)*(ec-ek))
    var ar=Math.PI*r*r
    var peri=2*Math.PI*r
    if(pt_k.north.text === "" || pt_k.east.text === "" || pt_l.north.text === "" || pt_l.east.text === ""
            || pt_m.north.text === "" || pt_m.east.text === "")
    {
            snack.open(qsTr("Please enter the values."))
    }
    else{
        pt_c.north.text = nc.toFixed(3)
        pt_c.east.text = ec.toFixed(3)
        rc.text=r.toFixed(3) + " m"
        area.text=ar.toFixed(3) + " m²"
        per.text=peri.toFixed(3) + " m"
    }
}
//----------CIRCLE PAGE------------------------------------------------
//icon
function circle_icon(){
    if(circle_count%2==1){
        return "toggle/star"
      }
    else if(circle_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function circle_help(){
    if(circle_count2%2==1){
        return "../help/CircleHelp.qml"
      }
    else if(circle_count2%2==0){
        return "Circle.qml"
    }
  }
function circle_helpicon(){
    if(circle_count2%2==1){
        return "navigation/close"

      }
    else if(circle_count2%2==0){
        return "action/help"
    }
  }
//-----------------------------------------------------------------------------------
