import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../../components/common/script.js" as Calc
import "mapscale.js" as MyCalc
import "../../../components/common"

SFlickable {
    function myheight(){
        if(scale_combo.currentIndex===0){
            return comborect.height + hesaplak.height + rect3.height + sunitresult.height + 50
        }
        else if(scale_combo.currentIndex===1){
            return comborect.height + hesaplak.height + rect1.height + sunitresult.height + 50
        }
        else if(scale_combo.currentIndex===2){
            return comborect.height + hesaplak.height + myrect2.height + sunitresult.height + 50
        }
    }
    contentHeight: Math.max(myheight(), height)
    anchors.topMargin: 15
    id:scalePage
    // Main menu, CustomComboBox
    Rectangle{
      id:comborect
      width: parent.width
      height:scale_combo.height
      color:"transparent"
       anchors.horizontalCenter: parent.horizontalCenter
    Column{
        id:scolumn
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:25
        // Settings
        Settings{
            id:mycombo
            property alias currentIndex3: scale_combo.currentIndex
            property alias scale_1: unit_s1.currentIndex
            property alias scale_2: unit_s2.currentIndex
            property alias ground_1: unitg2.currentIndex
            property alias ground_2: gunitresult.currentIndex
            property alias mapp_1: unitm2.currentIndex
            property alias mapp_2: sunitresult.currentIndex

            property alias mapscale1:sMap.text
            property alias mapscale2:sGround.text
            property alias mapscale3:gscale.text
            property alias mapscale4:gMap.text
            property alias mapscale5:mscale.text
            property alias mapscale6:mGround.text
            property alias mapscale7:sresult.text
            property alias mapscale8:gresult.text
            property alias mapscale9:mresult.text
        }
        CustomComboBox {
            id: scale_combo
            width: comborect.width - 20
            height: 38
            //popup.dim: true
            currentIndex: 0
            model: ListModel {
                id: model
                ListElement { text: qsTr("Map Scale Calculation") }
                ListElement { text: qsTr("Graund Distance") }
                ListElement { text: qsTr("Map Distance") }
            }
        }
    }
}

//--------Scale calculation ------------------------------------------------
            Rectangle{
              id:rect3
              width: mygrid3.width
              height:mygrid3.height
              color:"transparent"
              function vizz(){
                    if (scale_combo.currentIndex==0 ){
                       return true
                     }
                    else{
                        return false
                    }
                 }
               visible: vizz()
               anchors.top: comborect.bottom
               anchors.topMargin: 20
               anchors.horizontalCenter: parent.horizontalCenter
            ColumnLayout {
                id:mygrid3
                spacing: 3
                RowLayout{
                    SText{font.pixelSize: 13; text: qsTr("Map Dist.: ");}
                    STextField {id:sMap; implicitWidth: 120}
                    CustomComboBox {
                        id: unit_s1
                        implicitWidth: 80
                        height: 38
                        currentIndex: 0
                        model: ListModel {
                            id: model_s1
                            ListElement { text: "mm" }
                            ListElement { text: "cm" }
                            ListElement { text: "inch" }
                        }
                    }
                }
                RowLayout{
                SText{font.pixelSize: 13; text: qsTr("Ground Dist:");}
                STextField {id:sGround; implicitWidth: 110;}
                CustomComboBox {
                    id: unit_s2
                    implicitWidth: 90
                    height: 38
                    currentIndex: 0
                    model: ListModel {
                        id: model_s2
                        ListElement { text: "km" }
                        ListElement { text: "m" }
                        ListElement { text: "feet" }
                        ListElement { text: "s.miles" }
                        ListElement { text: "n.miles" }
                    }
                    onAccepted: {
                        id:maccepted
                        if (find(editText) === -1)
                            model_s2.append({text: editText})
                    }
                }
                }

            }
            }
//--------Ground distance calculation-------------------------------------
Rectangle{
        id:rect1
        width: mygrid.width
        height:mygrid.height
        color:"transparent"
        function visibility(){
        if (scale_combo.currentIndex==1){
            return true
        }
        else{
            return false
         }
        }
        visible: visibility()
        anchors.top: comborect.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
GridLayout {
id:mygrid
Layout.fillWidth:true
rowSpacing: 5
columnSpacing: 5
rows:1
columns: 1
RowLayout{
    Layout.alignment: Qt.AlignHCenter
    SText{text: qsTr("Map Scale: "); font.pixelSize: 13;}
    STextField {id:gscale;}
}
RowLayout{
SText{font.pixelSize: 13; text: qsTr("Map Dist.: ");}
STextField {id:gMap; implicitWidth: 120}
CustomComboBox {
    id: unitg2
    implicitWidth: 80
    height: 38
    currentIndex: 0
    model: ListModel {
        id: model_g2
        ListElement { text: "mm" }
        ListElement { text: "cm" }
        ListElement { text: "inch" }
    }
    onAccepted: {
        id:maccepted
        if (find(editText) === -1)
            model_s2.append({text: editText})
    }
}
}
}
}
//--------Map Distance-------------------------------------
Rectangle {
id:myrect2
width: mygrid_m.width
height:mygrid_m.height
color:"transparent"
function visibility2(){
if (scale_combo.currentIndex==2){
    return true
}
else{
    return false
 }
}
visible: visibility2()
anchors.top: comborect.bottom
anchors.topMargin: 20
anchors.horizontalCenter: parent.horizontalCenter
GridLayout {
    //anchors.horizontalCenter: parent.horizontalCenter
    id:mygrid_m
    Layout.fillWidth:true
    rowSpacing: 5
    columnSpacing: 5
    rows:1
    columns: 1
    RowLayout{
        //anchors.fill: parent
        Layout.alignment: Qt.AlignHCenter
        SText{text: qsTr("Map Scale: "); font.pixelSize: 13}
        STextField {id:mscale; }
    }
  RowLayout{
    SText{font.pixelSize: 13; text: qsTr("Ground Dist.:");}
    STextField {id:mGround; implicitWidth: 110}
    CustomComboBox {
        id: unitm2
        implicitWidth: 90
        height: 38
        currentIndex: 0
        model: ListModel {
            id: model_m2
            ListElement { text: "km" }
            ListElement { text: "m" }
            ListElement { text: "feet" }
            ListElement { text: "s.miles" }
            ListElement { text: "n.miles" }
        }
        onAccepted: {
            id:maccepted
            if (find(editText) === -1)
                model_s2.append({text: editText})
        }
    }
}
}
}
//-----------Hesap-------------------------------------
Rectangle{
id:recthesap
color: "transparent"
width: mygrid22.width
height:mygrid22.height
function anchorsbottom(){
if (scale_combo.currentIndex==1){
    return myrect2.bottom
}
else if (scale_combo.currentIndex==0){
    return rect1.bottom
}
else if (scale_combo.currentIndex==2){
    return rect3.bottom
}
}
anchors.top: anchorsbottom()
anchors.topMargin: 15
anchors.horizontalCenter: parent.horizontalCenter
GridLayout {
    Layout.fillWidth:true
    id:mygrid22
    rowSpacing: 40
    columnSpacing: 40
    rows:2
Button {
    id:hesaplak
    implicitWidth: 50
    Image {
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        width: 40
        source: "qrc:/assets/images/equal.png"
    }
    highlighted: true
// Onclicked eventtttttttttttttt-------------------------------------------------------
    onClicked: {
        MyCalc.mapscale()
    }
//--------------------------------------------------------------------
}
Button {
    id:c
    implicitWidth: 40
    icon.source: "qrc:/assets/icons/material/content/clear.svg"
    onClicked: {
        mGround.text= mscale.text= gscale.text= gMap.text= sMap.text= sGround.text=mresult.text=gresult.text=sresult.text=""
    }
}
}
}
//      Map Scale result       ----------------------------------------------
Rectangle{
    id:recres1
    function visibility2(){
    if (scale_combo.currentIndex==0){
        return true
    }
    else{
        return false
     }
    }
    visible: visibility2()
    color: "transparent"
    anchors.top: recthesap.bottom
    anchors.topMargin: 15
    anchors.horizontalCenter: parent.horizontalCenter
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        SText{text: qsTr("Map Scale: "); font.pixelSize: 13}
        STextField {id:sresult; readOnly:true}
    }
}
//      Ground Distance result       ----------------------------------------------
Rectangle{
    function visibility2(){
    if (scale_combo.currentIndex==1){
        return true
    }
    else{
        return false
     }
    }
    id:recres2
    visible: visibility2()
    color: "transparent"
    anchors.top: recthesap.bottom
    anchors.topMargin: 15
    anchors.horizontalCenter: parent.horizontalCenter
    RowLayout{
      anchors.horizontalCenter: parent.horizontalCenter
      SText{font.pixelSize: 13; text: qsTr("Ground Dist.:")}
      STextField {id:gresult; implicitWidth: 110; readOnly:true; }
      CustomComboBox {
          id: gunitresult
          implicitWidth: 90
          height: 38
          currentIndex: 0
          model: ListModel {
              id: model_gg
              ListElement { text: "km" }
              ListElement { text: "m" }
              ListElement { text: "feet" }
              ListElement { text: "s.miles" }
              ListElement { text: "n.miles" }
          }
          onAccepted: {
              if (find(editText) === -1)
                  model_s2.append({text: editText})
          }
      }
  }
}
//      Map Distance result       ----------------------------------------------
Rectangle{
    function visibility2(){
    if (scale_combo.currentIndex==2){
        return true
    }
    else{
        return false
     }
    }
    id:recres3
    visible: visibility2()
    color: "transparent"
    anchors.top: recthesap.bottom
    anchors.topMargin: 15
    anchors.horizontalCenter: parent.horizontalCenter
  RowLayout{
      anchors.horizontalCenter: parent.horizontalCenter
          SText{font.pixelSize: 13; text: qsTr("Map Dist.: ");}
          STextField {id:mresult; implicitWidth: 120; readOnly:true; }
          CustomComboBox {
              id: sunitresult
              implicitWidth: 80
              height: 38
              currentIndex: 0
              model: ListModel {
                  ListElement { text: "mm" }
                  ListElement { text: "cm" }
                  ListElement { text: "inch" }
              }
              onAccepted: {
                  if (find(editText) === -1)
                      model_s2.append({text: editText})
              }
          }
      }
}
//---------------------------HESAP SON--------------------------------------------
}
