Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//----------------------------------------ROAD CALC------------------------------------------------------
function roadcalc(){
    var r = myparser(rt)
    var a = angle_text_input(at)
    if(r<=0 || a>Calc.angle_200() || a<=0){
        snack.open(qsTr("Please check the parameters."))
    }
    else if( rt.text==="" || at.text==="" )
    {
        snack.open(qsTr("Please enter the values."))
    }
    else{
        var tt_val =  r*Math.tan(Calc.angle_unit(a/2))
        lengthUnits( tt, tt_val )
        var lt_val =  2*Math.PI*r*a/Calc.angle_400()
        lengthUnits( lt, lt_val )
        var bst_val = r/(Math.cos(Calc.angle_unit(a/2))) - r
        lengthUnits( bst, bst_val )
    }

}
//-----------ROAD PAGE---------------------------------------------------------------
//icon
function road_icon(){
    if(road_count%2==1){
        return "toggle/star"
    }
    else if(road_count%2==0){
        return "toggle/star_border"
    }
}
//help
function road_help(){
    if(road_count2%2==1){
        return "../help/RoadHelp.qml"
    }
    else if(road_count2%2==0){
        return "RoadCalc.qml"
    }
}
function road_helpicon(){
    if(road_count2%2==1){
        return "navigation/close"
    }
    else if(road_count2%2==0){
        return "action/help"
    }
}
//-----------------------------------------------------------------------------------------------------------------------
