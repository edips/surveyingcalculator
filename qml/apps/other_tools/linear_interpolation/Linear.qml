import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../../components/common/script.js" as Calc
import "linear.js" as Hesap
import Qt.labs.settings 1.0
import "../../../components/common"
Item{

SFlickable{
    id:optionsPage
    contentHeight: Math.max(optionsColumn.implicitHeight+65, height)

    Settings{
        id:my_first
        property alias liear1:north1.text
        property alias liear2:north2.text
        property alias liear3:east1.text
        property alias liear4:east2.text
        property alias liear5:interp.text
        property alias liear6:result.text
        property alias liear7:radio_e.checked
        property alias liear8:radio_n.checked
    }


    function nore(){
        if(radio_n.checked){
            return Calc.textE()
        }
        else{
            return Calc.textN()
        }
    }
    function nore2(){
        if(radio_n.checked){
            return Calc.textN()

        }
        else{
            return Calc.textE()
        }
    }
Column{
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
        layoutDirection: Calc.coord_display()
        STextField{
            id:north1
            horizontalAlignment: SText.AlignHCenter
            placeholderText: Calc.textN()+"1"
        }
        STextField{
            id:east1
            horizontalAlignment: SText.AlignHCenter
            placeholderText: Calc.textE()+"1"
        }
    }
    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:25
        layoutDirection: Calc.coord_display()
        STextField{
            id:north2
            horizontalAlignment: SText.AlignHCenter
            placeholderText: Calc.textN()+"2"
        }
        STextField{
            id:east2
            horizontalAlignment: SText.AlignHCenter
            placeholderText: Calc.textE()+"2"
        }

    }
    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:25

        STextField{
            id:interp
            horizontalAlignment: SText.AlignHCenter
            placeholderText: optionsPage.nore()
        }
    }
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20
        SText {
            font.pixelSize: 15
            text: qsTr("Calculate: ")
        }
            RowLayout{
                spacing: 50
     Column{
    RadioButton {
        id:radio_n
        //width: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: Calc.textN()
        checked: true
    }
    RadioButton {
        id:radio_e
        //width: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: Calc.textE()
    }
     }
        }

}

    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 50
        Button {
            id:hesapla_to2
            width: 50
            Image {
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                width: 40
                source: "qrc:/assets/images/equal.png"
            }
            highlighted: true
            onClicked: {
                Hesap.linearcalc()
            }
        }
        Button {
            id:c
            width: 40
           icon.source: "qrc:/assets/icons/material/content/clear.svg"
            onClicked: {
                north1.text=north2.text=east1.text=east2.text=result.text=interp.text=""
            }
        }
    }
    Row{
        id:row
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:25

        STextField{
            id:result
            horizontalAlignment: SText.AlignHCenter
            placeholderText: optionsPage.nore2()
            readOnly:true
        }

    }
    Rectangle{
        height:geri.height
        width:geri.width
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            width: 200
            fillMode: Image.PreserveAspectFit
            id:geri
            source:"qrc:/assets/images/help/linear.png"
        }
     }
}
}
    }
