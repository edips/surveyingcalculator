function areaFunc(coords){
       var t = 0;
       for(var i = 0; i < (coords.length-1); i++){
           var y = coords[i+1][1] + coords[i][1]
           var x = coords[i+1][0] - coords[i][0]
           var z = y * x
           t=t+z
           }

       return Math.abs(t/2.0)
   }

   var myarr = []

   var myarea = "";

   function printit(){
       var coord_pairs= (editor.text).match(/[^\r\n]+/g);
       if(coord_pairs.length < 3){
           snack.open(qsTr("Enter minimum 3 coordinates for area calculation."))
       }
       else{
         myarr = coord_pairs.map(function(e) {
             // trims spaces out of the coordinate pairs
             e=e.trim();
           return e.split(/(?:,| )+/).map(Number);
         })
         myarr.push(myarr[0])

           for (var t=0; t < myarr.length; t++){
               if (myarr[t].length !== 2){
                   snack.open(qsTr("Please check the coordinates. See help page for more information."))
                   break;
               }
           }

          area.text = (areaFunc(myarr)).toFixed(2)

           if (areacombo.currentIndex === 0){
               area.text = (areaFunc(myarr)).toFixed(2)
           }
           // km2
           else if(areacombo.currentIndex === 1){
               area.text = (areaFunc(myarr)*0.000001).toFixed(6)
           }
           // ha
           else if(areacombo.currentIndex === 2){
               area.text = (areaFunc(myarr)*0.0001).toFixed(4)
           }
           // acre
           else if(areacombo.currentIndex === 3){
               area.text = (areaFunc(myarr)*0.000247105381467165).toFixed(6)
           }
           // mile
           else if(areacombo.currentIndex === 4){
               area.text = (areaFunc(myarr)*0.000000386102158542446).toFixed(6)
           }
           // yard
           else if(areacombo.currentIndex === 5){
               area.text = (areaFunc(myarr)*1.19599004630108).toFixed(2)
           }
           // feet
           else if(areacombo.currentIndex === 6){
               area.text = ((areaFunc(myarr)*10.7639104167097)).toFixed(0)
           }

           myarea = (areaFunc(myarr)).toFixed(2);
       }
 }



function unitcalc(){
    // m2
if (areacombo.currentIndex == 0){
    console.log("area in meter2: ", myarea)
     area.text = myarea
}
// km2
else if(areacombo.currentIndex === 1){
    area.text = (myarea*0.000001).toFixed(6)
}
// ha
else if(areacombo.currentIndex === 2){
    area.text = (myarea*0.0001).toFixed(4)
}
// acre
else if(areacombo.currentIndex === 3){
    area.text = (myarea*0.000247105381467165 ).toFixed(6)
}
// mile
else if(areacombo.currentIndex === 4){
    area.text = (myarea*0.000000386102158542446).toFixed(6)
}
// yard
else if(areacombo.currentIndex === 5){
    area.text = (myarea*1.19599004630108).toFixed(2)
}
// feet
else if(areacombo.currentIndex === 6){
    area.text = (myarea*10.7639104167097).toFixed(0)
}
}

function calc(){
    if(editor.text==="")
        {
        snack.open(qsTr("Please enter the coordinates."))
    }
    else{
         printit();
    }
}

// icon
function areacalc_icon(){
    if(areacalc_count%2==1){
        return "toggle/star"
      }
    else if(areacalc_count%2==0){
        return "toggle/star_border"
    }
  }
// help
function areacalc_help(){
    if(areacalc_count2%2==1){
        return "../help/AreaXYHelp.qml"
      }
    else if(areacalc_count2%2==0){
        return "areaCalc.qml"
    }
  }
function areacalc_helpicon(){
    if(areacalc_count2%2==1){
        return "navigation/close"

      }
    else if(areacalc_count2%2==0){
        return "action/help"
    }
  }
//----------------------------------------------------------------------------
