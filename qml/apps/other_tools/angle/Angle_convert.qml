/***************************************************************************
  Copyright            : (C) 2021 by Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "angle.js" as Calc
import Qt.labs.settings 1.1
import "../../../components/common"
Item{
    SFlickable {
        id:optionsPage


        Settings{
            id:mysetting45
            property alias angleroot: angle_root.currentIndex
            property alias text1:aci.text
            property alias text2:result1.text
            property alias text3:result2.text
            property alias text4:result3.text
            property alias text5:result4.text
        }
        Column{
            spacing: 35
            anchors.horizontalCenter: parent.horizontalCenter
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:10
                CustomComboBox {
                    id: angle_root
                    currentIndex: 0
                    height: aci.height
                    model: ListModel {
                        id: model
                        ListElement { text: qsTr("Degree") }
                        ListElement { text: qsTr("Grad") }
                        ListElement { text: qsTr("Radian") }
                        ListElement { text: qsTr("Mil (NATO)") }
                    }
                }
                STextField{id:aci;}
            }
        //-----------Hesap-------------------------------------
        Row{
            id:myrow
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:50
            Button {
                id:hesaplak
                width: 50
                highlighted: true
                Image {
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    width: 40
                    source: "qrc:/assets/images/equal.png"
                }
                onClicked: {Calc.anglecalculator(); }
            }
            Button {
                id:c
                width: 40
                icon.source: "qrc:/assets/icons/material/content/clear.svg"
                onClicked: {result1.text=result2.text=result3.text=result4.text=aci.text=""; }
            }
        }
        Column {
            function visibility1(){
                if(angle_root.currentIndex==0){
                    return true
                }
                else{
                    return false
                }
            }
            function visibility2(){
                if(angle_root.currentIndex==1){
                    return true
                }
                else{
                    return false
                }
            }
            function visibility3(){
                if(angle_root.currentIndex==2){
                    return true
                }
                else{
                    return false
                }
            }
            function visibility4(){
                if(angle_root.currentIndex==3){
                    return true
                }
                else{
                    return false
                }
            }

           RowLayout{
               visible: parent.visibility1()
               Row{
                   spacing: 10
            CustomComboBox {
                id: angle1
                height: aci.height
                currentIndex: 0
                model: ListModel {
                    id: model2
                    ListElement { text: qsTr("Grad") }
                    ListElement { text: qsTr("Radian") }
                    ListElement { text: qsTr("Mil (NATO)") }
                }
            }
            STextField{id:result1;}
           }
           }

           RowLayout{
               visible: parent.visibility2()
               Row{
                   spacing: 10
            CustomComboBox {
                id: angle2
                currentIndex: 0
                model: ListModel {
                    id: model3
                    ListElement { text: qsTr("Degree")  }
                    ListElement { text: qsTr("Radian") }
                    ListElement { text: qsTr("Mil (NATO)") }
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model2.append({text: editText})
                }
            }

            STextField{id:result2;}
           }
           }

           RowLayout{
               visible: parent.visibility3()
               Row{
                   spacing: 10
            CustomComboBox {
                id: angle3
                currentIndex: 0

                model: ListModel {
                    id: model4
                    ListElement { text: qsTr("Degree")  }
                    ListElement { text: qsTr("Grad") }
                    ListElement { text: qsTr("Mil (NATO)") }
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model2.append({text: editText})
                }
            }

            STextField{id:result3}
           }
           }

           RowLayout{
               visible: parent.visibility4()
               Row{
                   spacing: 10
            CustomComboBox {
                id: angle4
                currentIndex: 0

                model: ListModel {
                    id: model5
                    ListElement { text: qsTr("Degree")  }
                    ListElement { text: qsTr("Grad") }
                    ListElement { text: qsTr("Radian") }
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model2.append({text: editText})
                }
            }

            STextField{id:result4;}

           }
           }
        }
        }
}
}
