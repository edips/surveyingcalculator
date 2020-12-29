Qt.include("../../../components/common/script.js")
function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//---------------------------------------TECVIZ CALC------------------------------------------------
function tecvizcalc(){
    var tapu = myparser(talan)
    var hesap = myparser(halan)
    var olck  = parseInt(olcek.currentText)
    var tec=0
    var fark=0
    if (tapu<=0 || hesap<=0){
        snack.open(qsTr("Please check the areas."))
    }

    else if (sayisal.checked===true){
        tec=0.013*Math.sqrt(olck*tapu) + 0.0003*tapu
        fark=tapu-hesap
        tec=tec.toFixed(2)
        fark=fark.toFixed(2)
        //tecvizz.text=tec.toFixed(2)+"m2"
        //afark.text=fark.toFixed(2)+"m2"
        if(tec<Math.abs(fark)){
            afark.color="red"
            halan.color="red"
        }
        else if(tec>Math.abs(fark)){
            afark.color="green"
            halan.color="green"
        }
    }
    else if (planimetrik.checked===true){
        tec=0.0004*olck*Math.sqrt(tapu) + 0.0003*tapu
        fark=tapu-hesap
        tec=tec.toFixed(2)
        fark=fark.toFixed(2)
        //tecvizz.text=tec +"m2"
        //afark.text=fark+"m2"
        if(tec<Math.abs(fark)){
            afark.color="red"
            halan.color="red"
        }
        else if(tec>Math.abs(fark)){
            afark.color="green"
            halan.color="green"
        }
    }
    tecvizz.text=tec + " m²"
    afark.text=fark + " m²"


    if( talan.text==="" || halan.text==="" || olcek.text==="" )
        {
        snack.open(qsTr("Please enter the values."))
        }
}
//-----------TECVIZ PAGE------------------------------------------------------------------------
//icon
function tec_icon(){
    if(tecviz_count%2==1){
        return "toggle/star"
      }
    else if(tecviz_count%2==0){
        return "toggle/star_border"
    }
  }
//help
function tec_help(){
    if(tecviz_count2%2==1){
        return "../help/ParcelHelp.qml"
      }
    else if(tecviz_count2%2==0){
        return "Tecviz2.qml"
    }
  }
function tec_helpicon(){
    if(tecviz_count2%2==1){
        return "navigation/close"

      }
    else if(tecviz_count2%2==0){
        return "action/help"
    }
  }
//-----------------------------------------------------------------------------------------------------
