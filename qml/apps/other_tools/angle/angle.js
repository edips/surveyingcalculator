function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//-------------------------------- ANGLE CALC------------------------------------------------------------
function anglecalculator(){
    var angle=myparser(aci)

    if(angle_root.currentIndex===0){
        if(aci.text==="")
            {
            snack.open(qsTr("Please enter the angle."))
        }
        else{
        if(angle1.currentIndex===0){
            result1.text=((200*angle)/180).toFixed(4)
        }
        else if(angle1.currentIndex===1){
            result1.text=((Math.PI*angle)/180).toFixed(8)
        }
        else if(angle1.currentIndex===2){
                result1.text=((6400*angle)/360).toFixed(2)
        }
        }
    }
    else if(angle_root.currentIndex===1){
        if(aci.text==="")
            {
            snack.open(qsTr("Please enter the angle."))
        }
        else{
        if(angle2.currentIndex===0){
            result2.text=((180*angle)/200).toFixed(4)
        }
        else if(angle2.currentIndex===1){
            result2.text=((Math.PI*angle)/200).toFixed(8)
        }
        else if(angle2.currentIndex===2){
            result2.text=((6400*angle)/400).toFixed(2)
        }
        }
    }
    else if(angle_root.currentIndex===2){
        if(aci.text==="")
            {
            snack.open(qsTr("Please enter the angle."))
        }
        else{
        if(angle3.currentIndex===0){
            result3.text=((180*angle)/Math.PI).toFixed(4)
        }
        else if(angle3.currentIndex===1){
            result3.text=((200*angle)/Math.PI).toFixed(4)
        }
        else if(angle3.currentIndex===2){
            result3.text=((3200*angle)/Math.PI).toFixed(2)
        }
        }
    }
    else if(angle_root.currentIndex===3){
        if(aci.text==="")
            {
            snack.open(qsTr("Please enter the angle."))
        }
        else{
        if(angle4.currentIndex===0){
            result4.text=((180*angle)/3200).toFixed(4)
        }
        else if(angle4.currentIndex===1){
            result4.text=((200*angle)/3200).toFixed(4)
        }
        else if(angle4.currentIndex===2){
            result4.text=((Math.PI*angle)/3200).toFixed(8)
        }
        }
    }
    if(isNaN(result1.text) || isNaN(result2.text) || isNaN(result3.text) || isNaN(result4.text))
    {
     result1.text=result2.text=result3.text=result4.text=""
    }
}
//---ANGLE PAGE--------------------------------------------------------------------------------------------------------
// icon
function angle_icon(){
    if(countt2%2==1){
        return "toggle/star"
      }
    else if(countt2%2==0){
        return "toggle/star_border"
    }
  }
//help
function angle_help(){
    if(countt22%2==1){
        return "../help/AngleHelp.qml"
      }
    else if(countt22%2==0){
        return "Angle_convert.qml"
    }
  }
function angle_helpicon(){
    if(countt22%2==1){
        return "navigation/close"

      }
    else if(countt22%2==0){
        return "action/help"
    }
  }
//---------------------------------------------------------------------------------------------------
