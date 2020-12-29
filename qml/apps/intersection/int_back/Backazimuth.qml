import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import "../../../components/common/script.js" as Calc
import "backazimuth.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
Item{
SFlickable {

    id:optionsPage
    contentHeight:{
        if(gelismis_1.checked==true){
            return Math.max(optionsColumnn.implicitHeight+optionsColumnn2.implicitHeight+65)
            }
        else{
            return Math.max(optionsColumnn.implicitHeight+65)
            }
        }

    Settings{
        id:mysetting45
        property alias back1: gelismis_1.checked

        property alias back4:x_1.text
        property alias back5:x_2.text
        property alias back6:x_3.text
        property alias back7:y_1.text
        property alias back8:y_2.text
        property alias back9:y_3.text
        property alias back10:xp.text
        property alias back11:yp.text
        property alias back14:s_mesafe.text
        property alias back16:sbb.text
        property alias back17:saa.text
        property alias back18:p3p.text
        property alias back19:p1p.text

        property alias bbbn_dec: bbn.decimal_txt
        property alias bbbn_deg: bbn.degree_txt
        property alias bbbn_min: bbn.minute_txt
        property alias bbbn_sec: bbn.second_txt
        property alias bbbn_gon: bbn.gon_txt

        property alias baan_dec: aan.decimal_txt
        property alias baan_deg: aan.degree_txt
        property alias baan_min: aan.minute_txt
        property alias baan_sec: aan.second_txt
        property alias baan_gon: aan.gon_txt

        property alias bt3mm_dec: t3mm.decimal_txt
        property alias bt3mm_deg: t3mm.degree_txt
        property alias bt3mm_min: t3mm.minute_txt
        property alias bt3mm_sec: t3mm.second_txt
        property alias bt3mm_gon: t3mm.gon_txt

        property alias bt1mm_dec: t1mm.decimal_txt
        property alias bt1mm_deg: t1mm.degree_txt
        property alias bt1mm_min: t1mm.minute_txt
        property alias bt1mm_sec: t1mm.second_txt
        property alias bt1mm_gon: t1mm.gon_txt

        property alias bt311_dec: t311.decimal_txt
        property alias bt311_deg: t311.degree_txt
        property alias bt311_min: t311.minute_txt
        property alias bt311_sec: t311.second_txt
        property alias bt311_gon: t311.gon_txt

        property alias bt133_dec: t133.decimal_txt
        property alias bt133_deg: t133.degree_txt
        property alias bt133_min: t133.minute_txt
        property alias bt133_sec: t133.second_txt
        property alias bt133_gon: t133.gon_txt

        property alias bk_1_dec: k_1.decimal_txt
        property alias bk_1_deg: k_1.degree_txt
        property alias bk_1_min: k_1.minute_txt
        property alias bk_1_sec: k_1.second_txt
        property alias bk_1_gon: k_1.gon_txt

        property alias bgamma_dec: gamma.decimal_txt
        property alias bgamma_deg: gamma.degree_txt
        property alias bgamma_min: gamma.minute_txt
        property alias bgamma_sec: gamma.second_txt
        property alias bgamma_gon: gamma.gon_txt

        property alias bl_1_dec: l_1.decimal_txt
        property alias bl_1_deg: l_1.degree_txt
        property alias bl_1_min: l_1.minute_txt
        property alias bl_1_sec: l_1.second_txt
        property alias bl_1_gon: l_1.gon_txt

        property alias ba_1_dec: a_1.decimal_txt
        property alias ba_1_deg: a_1.degree_txt
        property alias ba_1_min: a_1.minute_txt
        property alias ba_1_sec: a_1.second_txt
        property alias ba_1_gon: a_1.gon_txt

        property alias bb_1_dec: b_1.decimal_txt
        property alias bb_1_deg: b_1.degree_txt
        property alias bb_1_min: b_1.minute_txt
        property alias bb_1_sec: b_1.second_txt
        property alias bb_1_gon: b_1.gon_txt
    }
Column{
    id:optionsColumnn
    width: optionsPage.width
    //height: optionsPage.height
    spacing: 5
    anchors.topMargin    : 15
    anchors.bottomMargin : 15
    anchors.leftMargin :15
    anchors.rightMargin  : 15

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:25
    Row{
        SText {text: "α: "; font.pixelSize: 17}
        SAngle{id:a_1 }
    }
    Row{
        SText {text: "β: "; font.pixelSize: 17}
        SAngle{id:b_1 }
    }
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    layoutDirection: Calc.coord_display()
    spacing:25

    Row{
        SText {text: Calc.textN() + "1: "; font.pixelSize: 14}
        STextField{id:x_1}
    }

    Row{
        SText {text: Calc.textE() + "1: "; font.pixelSize: 14}
        STextField{id:y_1}
    }
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    layoutDirection: Calc.coord_display()
    spacing:25

    Row{
        SText {text: Calc.textN() + "2: "; font.pixelSize: 14}
        STextField{id:x_2}
    }

    Row{
        SText {text: Calc.textE() + "2: "; font.pixelSize: 14}
        STextField{id:y_2}
    }
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    layoutDirection: Calc.coord_display()
    spacing:25

    Row{
        SText {text: Calc.textN() + "3: "; font.pixelSize: 14}
        STextField{id:x_3}
    }

    Row{
        SText {text: Calc.textE() + "3: "; font.pixelSize: 14}
        STextField{id:y_3}
    }
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:10
    Button {
        id:hesapla
        width: 50
        Image {
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            width: 40
            source: "qrc:/assets/images/equal.png"
        }
        highlighted: true
// onclicked----------------------------------------------------------------------------------------------------------------------
        onClicked: {
           Hesap.backazimuth() 
        }
    }
    //------------------------------------------------------------------------------------------------------------------
        CheckBox{
            id:gelismis_1
            height: c.height
            text:qsTr("Report")
            checked: false
            }
    //---------------------------------------
        Button {
            id:c
            width: 40
           icon.source: "qrc:/assets/icons/material/content/clear.svg"
            onClicked: {
                x_1.text=y_1.text=x_2.text=y_2.text=x_3.text=y_3.text=xp.text=yp.text=p1p.text=p3p.text=""
                saa.text=sbb.text=s_mesafe.text = ""

                Calc.angle_clear([bbn, aan, t3mm, t1mm, t311, t133, k_1, gamma, l_1, a_1, b_1])
            }
        }
}
//-----------------------------------------------------------------
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    layoutDirection: Calc.coord_display()
    spacing:25

    Row{
        SText {text: Calc.textN() + "P: "; font.pixelSize: 14}
        STextField{id:xp; readOnly:true}
    }

    Row{
        SText {text: Calc.textE() + "P: "; font.pixelSize: 14}
        STextField{id:yp; readOnly:true}
    }
}
//----------------------------------------------------------
Rectangle{
    id:advanced_geri
    visible: gelismis_1.checked
    anchors.horizontalCenter: parent.horizontalCenter
    height:geri_advanced.height
    width:geri_advanced.width
    color: "transparent"
    Image {
        id:geri_advanced
        width: 300
        height: 400
        fillMode: Image.PreserveAspectFit
        source:"qrc:/assets/images/geriden_kestirme_advanced.png"
}
}
//------------------------------------------------------------
Rectangle{
    id:backazimuth_image
    function visibility(){
    if (gelismis_1.checked==true){
        return false
        }
    else{
        return true
        }
    }
    visible: visibility()
    anchors.horizontalCenter: parent.horizontalCenter
    height:geri.height
    width:geri.width
    color: "transparent"
    Image {
        id:geri
        width: 300
        height: 300
        fillMode: Image.PreserveAspectFit
        source:"qrc:/assets/images/geri.png"
        }
    }
}
//--------------------------------------------------------------
Rectangle {
    id:myrect
    visible: gelismis_1.checked
    color: "transparent"
    anchors {
        left: parent.left
        right:parent.right
        top: optionsColumnn.bottom
        bottom: parent.bottom
        //margins: 5
    }


    Column{
        id:optionsColumnn2
        width: optionsPage.width
        spacing: 5
        anchors.topMargin    : 50
        anchors.bottomMargin : 15
        anchors.leftMargin :5
        anchors.rightMargin  : 5

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:1

            SText {text: "(13): "; font.pixelSize: 14}
            SAngle{read_only: true; id:t133 }

            SText {text: "(31): "; font.pixelSize: 14}
            SAngle{read_only: true; id:t311 }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:1

            SText {text: "(12): "; font.pixelSize: 14}
            SAngle{read_only: true; id:t1mm }

            SText {text: "(32): "; font.pixelSize: 14}
            SAngle{read_only: true; id:t3mm }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:1

            SText {text: "(21): "; font.pixelSize: 14}
            SAngle{read_only: true; id:aan }

            SText {text: "(23): "; font.pixelSize: 14}
            SAngle{read_only: true; id:bbn }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:1

            SText {text: "|P1-P|:"; font.pixelSize: 12}
            STextField{id:p1p; readOnly:true}

            SText {text: "|P3-P|:"; font.pixelSize: 12}
            STextField{id:p3p; readOnly:true}
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:1

            SText {text: "s1: "; font.pixelSize: 14}
            STextField{id:saa; readOnly:true}

            SText {text: "s2: "; font.pixelSize: 14}
            STextField{id:sbb; readOnly:true}
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:1

            SText {text: "k: "; font.pixelSize: 14}
            SAngle{read_only: true; id:k_1 }

            SText {text: "l: "; font.pixelSize: 14}
            SAngle{read_only: true; id:l_1 }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:15

            SText {text: "s: "; font.pixelSize: 14}
            STextField{id:s_mesafe; readOnly:true}

            SText {text: "γ: "; wrapMode: SText.WordWrap; font.pixelSize: 14}
            SAngle{read_only: true; id:gamma }
        }
}
}
}
}
