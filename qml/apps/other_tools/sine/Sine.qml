import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Window 2.3
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.3
import "../../../components/common/script.js" as Calc
import "../../../components/common"
import "sine.js" as Hesap
Item{
    id:yepage
    SFlickable {
        contentHeight: Math.max(comborect.height + hesaplak.height + rect3.height + geri.height + rectresult2.height + 70, height)

        function myheight(){
            if(scale_combo.currentIndex===0){
                return comborect.height + hesaplak.height + rect3.height + geri.height + rectresult2.height + 50
            }
            else if(scale_combo.currentIndex===1){
                return comborect.height + hesaplak.height + rect.height + geri.height + 50
            }
        }

        Settings{
            id:sine_settings
            property alias sbeta_dec: beta.decimal_txt
            property alias sbeta_deg: beta.degree_txt
            property alias sbeta_min: beta.minute_txt
            property alias sbeta_sec: beta.second_txt
            property alias sbeta_gon: beta.gon_txt

            property alias salpha2_dec: alpha2.decimal_txt
            property alias salpha2_deg: alpha2.degree_txt
            property alias salpha2_min: alpha2.minute_txt
            property alias salpha2_sec: alpha2.second_txt
            property alias salpha2_gon: alpha2.gon_txt

            property alias sbeta2_dec: beta2.decimal_txt
            property alias sbeta2_deg: beta2.degree_txt
            property alias sbeta2_min: beta2.minute_txt
            property alias sbeta2_sec: beta2.second_txt
            property alias sbeta2_gon: beta2.gon_txt

            property alias alpharesult_dec: alpharesult.decimal_txt
            property alias alpharesult_deg: alpharesult.degree_txt
            property alias alpharesult_min: alpharesult.minute_txt
            property alias alpharesult_sec: alpharesult.second_txt
            property alias alpharesult_gon: alpharesult.gon_txt

            property alias currentIndexx: sine_combo.currentIndex
            property alias sine1:a_side.text
            property alias sine2:b_side.text

            property alias sine6:bside2.text
            property alias sine8:aresult.text
        }

// Menu------------------------------------------------------------------
Rectangle{
          id:comborect
          width: parent.width
          height:sine_combo.height
          color:"transparent"
           anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id:scolumn
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:25

            CustomComboBox {
                id: sine_combo
                width: comborect.width
                currentIndex: 0

                model: ListModel {
                    id: model
                    ListElement { text: qsTr("Calculate Angle α") }
                    ListElement { text: qsTr("Calculate side a") }
                }
                onAccepted: {
                    id:maccepted
                    if (find(editText) === -1)
                        model.append({text: editText})
                }
            }
        }
    }
//--------alpha calculation ------------------------------------------------
                Rectangle{
                  id:rect3
                  width: mygrid3.width
                  height:mygrid3.height
                  color:"transparent"
                  function vizz(){
                        if (sine_combo.currentIndex==0 ){
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
                        SText {text: qsTr("a: "); }
                        STextField {id:a_side; implicitWidth: 80;}
                    }
                    RowLayout{
                        SText {text: qsTr("b: ");}
                        STextField {id:b_side; implicitWidth: 80}
                    }
                    RowLayout{
                        SText {text: qsTr("β: ")}
                        SAngle{id:beta}
                    }
                }
                }
//--------a side calculation -------------------------
                Rectangle{
                  id:rect
                  width: mygrid1.width
                  height:mygrid1.height
                  color:"transparent"
                  function vizz(){
                        if (sine_combo.currentIndex==1 ){
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
                    id:mygrid1
                    spacing: 3
                    RowLayout{
                        SText {text: qsTr("α: "); }
                        SAngle{id:alpha2}
                    }
                    RowLayout{
                        SText {text: qsTr("β: ")}
                        SAngle{id:beta2}
                    }
                    RowLayout{
                        SText {text: qsTr("b: ");}
                        STextField {id:bside2; implicitWidth: 80;}
                    }
                }
       }
//---------------------HESAP--------------------------------------------
                Rectangle{
                    id:recthesap
                    color: "transparent"
                    width: mygrid22.width
                    height:mygrid22.height
                    function anchorsbottom(){
                    if (sine_combo.currentIndex==0){
                        return rect3.bottom
                    }
                    else if (sine_combo.currentIndex==1){
                        return rect.bottom
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
                        onClicked: {
                            Hesap.sinuscalc()

                        }
                    }
                    Button {
                        id:c
                        implicitWidth: 40
                       icon.source: "qrc:/assets/icons/material/content/clear.svg"
                        onClicked: {
                            a_side.text=b_side.text=bside2.text=aresult.text=""
                            Calc.angle_clear([alpha2, alpharesult, beta, beta2])
                        }
                    }
                }
                }
//------------RESULT 1------------------------------------------------------
                Rectangle{
                    function visibility2(){
                    if (sine_combo.currentIndex==0){
                        return true
                    }
                    else{
                        return false
                     }
                    }
                    width: row1.width
                    height:row1.height
                    id:rectresult1
                    visible: visibility2()
                    color: "transparent"
                    anchors.top: recthesap.bottom
                    anchors.topMargin: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                  RowLayout{
                      id:row1
                      anchors.horizontalCenter: parent.horizontalCenter
                          SText {text: qsTr("α: "); }
                          SAngle{id:alpharesult}
                      }
            }
//-------------RESULT 2 --------------------------------------------------
                Rectangle{
                    function visibility2(){
                    if (sine_combo.currentIndex==1){
                        return true
                    }
                    else{
                        return false
                     }
                    }
                    width: row2.width
                    height:row2.height
                    id:rectresult2
                    visible: visibility2()
                    color: "transparent"
                    anchors.top: recthesap.bottom
                    anchors.topMargin: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    RowLayout{
                        id:row2
                      anchors.horizontalCenter: parent.horizontalCenter
                      SText {text: qsTr("a: "); }
                      STextField {id:aresult; implicitWidth: 80; readOnly:true; }
                    }
            }
//-----------IMAGES--------------------------------------------------------
                Rectangle{
                    id:rectimage
                    function visib(){
                    if (sine_combo.currentIndex==0){
                        return true
                    }
                    else {
                        return false
                    }
                    }
                    anchors.top: rectresult1.bottom
                    anchors.topMargin: 15
                    visible: visib()
                    anchors.horizontalCenter: parent.horizontalCenter
                    height:geri.height
                    width:geri.width
                    color: "transparent"
                    Image {
                        id:geri
                        width: 200
                        //height: 300
                        fillMode: Image.PreserveAspectFit
                        source:"qrc:/assets/images/sine1.png"
                    }
                }
                Rectangle{
                    function visib(){
                    if (sine_combo.currentIndex==1){
                        return true
                    }
                    else {
                        return false
                    }
                    }
                    anchors.top: rectresult2.bottom
                    anchors.topMargin: 15
                    visible: visib()
                    anchors.horizontalCenter: parent.horizontalCenter
                    height:geri2.height
                    width:geri2.width
                    color: "transparent"
                    Image {
                        id:geri2
                        width: 200
                        //height: 300
                        fillMode: Image.PreserveAspectFit
                        source:"qrc:/assets/images/sine2.png"
                    }
                }

    }
}
