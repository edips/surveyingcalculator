import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
//import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.1
import "tecviz.js" as Hesap
import "../../../components/common"
import "../../../components/common/script.js" as Calc
//sonuclara m2 eklenecek qml string arastirilacak

Item{
    //title: ""
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)

        Settings{
            id:mycombo22
            property alias currentIndex2: olcek.currentIndex
            property alias setsayisal: sayisal.checked
            property alias setplanimetric: planimetrik.checked
            property alias tecviz1:talan.text
            property alias tecviz2:halan.text
            property alias tecviz3:afark.text
            property alias tecviz4:tecvizz.text
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
    spacing:5
    SText {text: qsTr("Area of Title Deed:");}
    STextField{id:talan}
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:5
    SText {text: qsTr("Calculated Area:");}
    STextField{id:halan}
}
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:5
    SText {text: qsTr("Scale:");}
    CustomComboBox {
        id: olcek
        inputMethodHints: Qt.ImhDigitsOnly
        currentIndex: 1
        model: ListModel {
            id: model
            ListElement { text: "500" }
            ListElement { text: "1000" }
            ListElement { text: "2000" }
            ListElement { text: "5000" }
            ListElement { text: "10000" }
            ListElement { text: "25000" }
        }
        onAccepted: {
            id:maccepted
            if (find(editText) === -1)
                model.append({text: editText})
        }
        //anchors.horizontalCenter: parent.horizontalCenter
    }

}
    RadioButton {
        id:sayisal
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr(qsTr("Digitized"))
        checked: true
    }
    RadioButton {
        id:planimetrik
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr(qsTr("Planimetric"))
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


        onClicked: {
            Hesap.tecvizcalc()
         }
    }
    Button {
        id:c
        width: 40
        icon.source: "qrc:/assets/icons/material/content/clear.svg"
        onClicked: {
            tecvizz.text=afark.text=halan.text=talan.text=""
       }
}
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    SText {text: qsTr("Difference of Areas:"); font.pixelSize: 13;}
    STextField{id:afark; readOnly:true;}
}

Row{
    anchors.horizontalCenter: parent.horizontalCenter
    SText {text: qsTr("Error Limit:");}
    STextField{id:tecvizz; readOnly:true;}
}

}

}
}
