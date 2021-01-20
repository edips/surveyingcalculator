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
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../components/common"
TopSheet{
    title: "Resection from 3 Points"
    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
Column{
    anchors.horizontalCenter: parent.horizontalCenter
    id:optionsColumn
    spacing: 5
    width: parent.width
    anchors.top:parent.top
    anchors.topMargin    : 15
    anchors.bottomMargin : 5
    anchors.leftMargin :5
    anchors.rightMargin  : 5
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: helpl.height
        width: helpl.width
        Label{
            id:helpl
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("The app calculates the coordinates of an unknown station P from 3 previously coordinated reference points P1, P2 and P3 visible
from station P, only by measuring the angles subtended by lines of sight from station P to the three coordinated points. It is based on Tienstra’s Method.
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang2.height
        width:ang2.width
        color: "transparent"
        Image {
            id:ang2
            width: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/sekil.png"
        }
    }
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: helpl2.height
        width: helpl2.width
        Label{
            id:helpl2
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("Known values: Angles α and β, reference points P1, P2, and P3 coordinates.<br><br>
<b>1.</b> Calculate baselines |P1P2|, |P2P3| and |P3P1| bearing angles.
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g.height
        width:sin_g.width
        color: "transparent"
        Image {
            id:sin_g
            width: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/angles.png"
        }
    }

    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: helpl23.height
        width: helpl23.width
        Label{
            id:helpl23
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("Calculate each angles according to the below table.<br><br> If angle unit is degree:
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g1.height
        width:sin_g1.width
        color: "transparent"
        Image {
            id:sin_g1
            width: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/azimuth_degree.png"
        }
    }
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: help5.height
        width: help5.width
        Label{
            id:help5
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("If angle unit is grad:
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g12.height
        width:sin_g12.width
        color: "transparent"
        Image {
            id:sin_g12
            width: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/azimuth_grad.png"
        }
    }
    //Always add angles A, B and C for checking calculations: For grad unit: A + B + C = 200g or for degree unit: A + B + C = 180g
    //2. Calculating angles e, f and ɤ:
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: help523.height
        width: help523.width
        Label{
            id:help523
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("<b>2.</b> Calculating angles e, f and ɤ :
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: help59.height
        width: help59.width
        Label{
            id:help59
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("If angle unit is degree:
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g122.height
        width:sin_g122.width
        color: "transparent"
        Image {
            id:sin_g122
            height: 80
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/ef_deg.png"
        }
    }
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: help591.height
        width: help591.width
        Label{
            id:help591
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("If angle unit is grad:")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g123.height
        width:sin_g123.width
        color: "transparent"
        Image {
            id:sin_g123
            height: 80
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/ef_gon.png"
        }
    }
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: help52.height
        width: help52.width
        Label{
            id:help52
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("Always add angles e, f and ɤ for checking calculations:<br> For grad unit: e + f + ɤ = 200g or for degree unit: e + f + ɤ = 180°
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: help524.height
        width: help524.width
        Label{
            id:help524
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("<b>3.</b> Calculating coefficients K1, K2 and K3 :
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:esin_g123.height
        width:esin_g123.width
        color: "transparent"
        Image {
            id:esin_g123
            height: 150
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/katsayi.png"
        }
    }
    //5. Calculating station’s P coordinates:
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: h2elp524.height
        width: h2elp524.width
        Label{
            id:h2elp524
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("<b>4.</b> Calculating station’s P coordinates :
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:e2sin_g123.height
        width:e2sin_g123.width
        color: "transparent"
        Image {
            id:e2sin_g123
            height: 50
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/np.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:e22sin_g123.height
        width:e22sin_g123.width
        color: "transparent"
        Image {
            id:e22sin_g123
            height: 50
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/back/ep.png"
        }
    }


}
    }
}
