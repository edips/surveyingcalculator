import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import "../../../components/common/script.js" as Calc
import "cosinus.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
Item{
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)

        Settings{
            id:wgs84settings
            //property alias coord_combo1:cogo_combo.currentIndex
            property alias cos1:a_k.text
            property alias cos2:b_k.text
            property alias cos3:c_k.text
            //property alias cos4:alfa.text
            //property alias cos5:beta.text
            //property alias cos6:gama.text

            property alias calfa_dec: alfa.decimal_txt
            property alias calfa_deg: alfa.degree_txt
            property alias calfa_min: alfa.minute_txt
            property alias calfa_sec: alfa.second_txt
            property alias calfa_gon: alfa.gon_txt

            property alias cbeta_dec: beta.decimal_txt
            property alias cbeta_deg: beta.degree_txt
            property alias cbeta_min: beta.minute_txt
            property alias cbeta_sec: beta.second_txt
            property alias cbeta_gon: beta.gon_txt

            property alias cgama_dec: gama.decimal_txt
            property alias cgama_deg: gama.degree_txt
            property alias cgama_min: gama.minute_txt
            property alias cgama_sec: gama.second_txt
            property alias cgama_gon: gama.gon_txt
        }
Column{
    anchors.horizontalCenter: parent.horizontalCenter
    id:optionsColumn
    spacing: 5
    anchors.fill : parent
    anchors.topMargin    : 15
    anchors.bottomMargin : 15
    anchors.leftMargin :15
    anchors.rightMargin  : 15
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:25

    Row{
        SText {text: "a: ";}
        STextField{id:a_k;}
    }
    Row{
        SText { text: "b: ";}
        STextField{id:b_k;}
    }
}
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:25

    Row{
        SText {text: "c: "}
        STextField{id:c_k;}
    }
}
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:50
    Button {
        id:hesaplak
        width: 50
        Image {
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            width: 40
            source: "qrc:/assets/images/equal.png"
        }
        highlighted: true
// onclicked-------------------------------------------------------------------------
        onClicked: {
          Hesap.cosinus()  
    }
    }
    Button {
        id:c
        width: 40
       icon.source: "qrc:/assets/icons/material/content/clear.svg"
        onClicked: {
            a_k.text=b_k.text=c_k.text=""
            Calc.angle_clear([alfa, beta, gama])
    }
}
}

Column{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 5

    Row{
        SText {text: "α: "; }
        SAngle{read_only: true; id:alfa }
    }

    Row{
        SText {text: "β: "; }
        SAngle{read_only: true; id:beta }
    }

    Row{
        SText {text: "γ: "; }
        SAngle{read_only: true; id:gama }
    }
}
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:geri.height
        width:geri.width
        color: "transparent"
        Image {
            id:geri
            width: 200
            //height: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/cosinus.png"
        }
    }

}
    }
}
