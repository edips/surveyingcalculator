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

import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../components/common"
import "../../components/common/script.js" as Util
FluidControls.Page {
    id: frame11
    title:qsTr("Intersection Methods")
    z: 2
SFlickable {
    id:options
    contentHeight: Math.max(malist2.implicitHeight, height)

    Column{
        id:optionsC
        width: parent.width
        height: parent.height
        anchors.topMargin    : 15
        anchors.bottomMargin : 15
        anchors.leftMargin :15
        anchors.rightMargin  : 15
        Rectangle{
            height: parent.height
            color: "transparent"
            width: parent.width
        ListView {
            id:malist2
            boundsBehavior: Flickable.StopAtBounds
            width: parent.width
            height: parent.height
            focus: true
            interactive: true
            clip: true
            model: ListModel {
                //ListElement { title: qsTr("Resection from 3 Points"); source: "int_back/Backazimuth2.qml"; imgsrc:"qrc:/assets/images/geri.png" }
                ListElement { title: qsTr("Forward Intersection"); source: "int_forward/Intersection2.qml"; imgsrc:"qrc:/assets/images/onden.png" }
                ListElement { title: qsTr("Line - Line Intersection"); source: "int_line2line/LineLineIntersection2.qml"; imgsrc:"qrc:/assets/images/line2line.png" }
                ListElement { title: qsTr("Circle by 3 Points"); source: "int_circle/Circle2.qml"; imgsrc:"qrc:/assets/images/circle.png" }
            }
            delegate: FluidControls.ListItem {
                height:70
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                Rectangle{
                   id:maimg
                   Layout.alignment: Qt.AlignHCenter
                   height:60
                   width:60
                   //color: "#a0c5a6"
                   color:"transparent"

                     Image {
                           id: img
                           source:model.imgsrc
                           anchors.fill: parent
                        }
                     }
                SText {
                    text: model.title
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                    font.bold: false
                }

                }
                onClicked: pageStack.push(model.source, {}, StackView.Immediate)
            }
            ScrollIndicator.vertical: ScrollIndicator {}
        }

    }
    }

}
}

