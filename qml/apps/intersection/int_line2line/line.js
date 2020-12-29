function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//---------------------------------------LINE LINE CALC--------------------------------------------
function linecalc(){
    var x1 = myparser(pt_a.north)
    var y1 = myparser(pt_a.east)
    var x2 = myparser(pt_au.north)
    var y2 = myparser(pt_au.east)
    var x3 = myparser(pt_b.north)
    var y3 = myparser(pt_b.east)
    var x4 = myparser(pt_bu.north)
    var y4 = myparser(pt_bu.east)
    var xpp = ( (x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4 - y3*x4) ) / ( (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4) )
    var ypp = ( (x1*y2-y1*x2)*(y3-y4)  - (y1-y2)*(x3*y4 - y3*x4) ) / ( (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4) )
    if(pt_a.north.text ==="" || pt_au.north.text==="" || pt_b.north.text==="" || pt_bu.north.text==="" ||
            pt_a.east.text==="" || pt_au.east.text==="" || pt_b.east.text==="" || pt_bu.east.text==="")
        {
        snack.open(qsTr("Please enter the values."))
        }
    else if(isNaN(xpp) || isNaN(ypp)){
      snack.open(qsTr("The coordinates do not intersect."))
    }
    yp.text = ypp.toFixed(3)
    xp.text=xpp.toFixed(3)
    if(isNaN(xp.text) || isNaN(yp.text))
    {
     xp.text=""
     yp.text=""
    }
}
//----------LINE LINE PAGE------------------------------------------------
//icon
function line_icon(){
    if(line_count%2==1){
        return "toggle/star"
      }
    else if(line_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function line_help(){
    if(line_count2%2==1){
        return "../help/LineHelp.qml"
      }
    else if(line_count2%2==0){
        return "LineLineIntersection.qml"
    }
  }
function line_helpicon(){
    if(line_count2%2==1){
        return "navigation/close"

      }
    else if(line_count2%2==0){
        return "action/help"
    }
  }
//------------------------------------------------------------------------------------------------------
