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
SFlickable {
    id:options
    contentHeight: Math.max(optionsC.implicitHeight, height)
    z: 2
Column{
    id:optionsC
    width: parent.width
    height: parent.height
    anchors.topMargin    : 15
    anchors.bottomMargin : 15
    anchors.leftMargin :15
    anchors.rightMargin  : 15
    Rectangle{
        height: parent.height-50
        color: "transparent"
        width: parent.width
    ListView {
        id:malist
        width: parent.width
        height: parent.height
        focus: true
        interactive: true
        clip: true
        model: ListModel{

            ListElement { title: qsTr("X(N), Y(E) Calculation"); source: "content/help/FirstHelp.qml"  }
            ListElement { title: qsTr("Azimuth Calculation"); source: "content/help/ThirdHelp.qml"  }
            ListElement { title: qsTr("Distance, Azimuth"); source: "content/help/SecondHelp.qml"  }
            ListElement { title: qsTr("Interior Angle"); source: "content/help/FourHelp.qml"  }

            ListElement { title: qsTr("Resection from 3 Points"); source: "content/help/BackazimuthHelp.qml"  }
            ListElement { title: qsTr("Linear Enterpolation"); source: "content/help/LinearHelp.qml"  }
            ListElement { title: qsTr("Forward Intersection"); source: "content/help/ForwardHelp.qml"  }
            ListElement { title: qsTr("Circle by 3 Points"); source: "content/help/CircleHelp.qml"  }

            ListElement { title: qsTr("Getting Started with PyCalculator"); source: "content/help/PyCalculatorHelp.qml"  }

            ListElement { title: qsTr("Angle Converter"); source: "content/help/AngleHelp.qml"  }
            ListElement { title: qsTr("Degree - Decimal Converter"); source: "content/help/Deg2DecHelp.qml"  }
            ListElement { title: qsTr("Distance Calculator"); source: "content/help/DistanceHelp.qml"  }

            ListElement { title: qsTr("2D Helmert Similarity Transformation"); source: "content/help/HelmertHelp.qml"  }
            ListElement { title: qsTr("Sine Law"); source: "content/help/SineHelp.qml"  }
            ListElement { title: qsTr("Cosine Law"); source: "content/help/CosinusHelp.qml"  }
            ListElement { title: qsTr("Line - Line Intersection"); source: "content/help/LineHelp.qml"  }
            ListElement { title: qsTr("Map Scale Calculator"); source: "content/help/MapScaleHelp.qml"  }
            ListElement { title: qsTr("Error Limit of Parcel"); source: "content/help/ParcelHelp.qml"  }
            ListElement { title: qsTr("Horizontal Curve"); source: "content/help/RoadHelp.qml"  }
        }

        delegate: FluidControls.ListItem {
            height:50

            SText {
                text: model.title
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 15
                font.family: windoww.font
                font.bold: true
            }
            onClicked: pageStack.push(model.source, {}, StackView.Immediate)
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }

}
}




}

