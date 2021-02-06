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

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
TopSheet {
    id: alertt
    title: "Surveying Calculator 3.5.3"
    onClosed: {
        loaderAboutVisible = false
    }
    SFlickable {
        id:settings_flickable
        anchors.margins: 15
        interactive: true
        anchors.top: alertt.toolbar.bottom
        contentHeight: column.implicitHeight
        Column {
            id: column
            anchors.fill: parent
            spacing: 15

            Label {
                onLinkActivated: Qt.openUrlExternally(link)
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Label.RichText
                font.pixelSize:14
                wrapMode: Label.WordWrap
                id:mylabel
                text:qsTr("Copyright © 2021 Edip Ahmet Taşkın, Geomatics Engineer\n<br><br>
Surveying Calculator is designed for field works for land surveyors and engineers. This app is improving with suggestions of users. If you have any suggestion about this app you can mail to <a href='mailto:geosoft66@gmail.com'>geosoft66@gmail.com</a><br>
You can get more information about Surveying Calculator from these links:<br>
• Surveying Calculator videos on  <a href=\"https://www.youtube.com/playlist?list=PLZiS4HY11oVdN7jUd_PmBb4pYud3ieJbw\">YouTube</a><br>
• Join Surveying Calculator group to ask questions on <a href=\"https://www.facebook.com/groups/820226478150041/?ref=bookmarks\">Facebook Group</a><br>
• Follow news about the app on <a href=\"https://fb.me/surveyingcalculator\">Facebook Page</a>
<br><br>
Surveying Calculator is an open source app. You can access the source code here: <a href=\"https://github.com/edips/surveyingcalculator\">github.com/edips/surveyingcalculator</a>
 User interface of Surveying Calculator is based on <a href=\"https://github.com/lirios/fluid\">Fluid QML Library</a>. This app benefits from source codes and libraries of QGIS 3.16 and Input app by Lutra Consulting.
 Many thanks to
<a href=\"https://liri.io/\">LiriOS & Fluid team</a>, all OSGeo contributers,
<a href=\"https://www.lutraconsulting.co.uk/\">Lutra Consulting</a> ,
and <a href=\"https://www.opengis.ch/\">OPENGIS.ch</a> for providing open source projects.
"
                          )
            }
            Button {
                id:delegate
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Rate Surveying Calculator")
                width: parent.width - 30
                icon.source: "qrc:/assets/icons/material/toggle/star_border.svg"
                onClicked: {
                    //Qt.openUrlExternally("https://play.google.com/store/apps/details?id=org.project.surveyingcalculator")
                    Qt.openUrlExternally("https://play.google.com/store/apps/details?id=org.project.geoclass")
                }
            }

            Label {
                onLinkActivated: Qt.openUrlExternally(link)
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Label.RichText
                font.pixelSize:14
                wrapMode: Label.WordWrap
                id:mylabel2
                text:qsTr("
<a href=\"https://edips.github.io/privacypolicy.html\">Privacy policy</a><br><br>
<a href=\"https://edips.github.io\">Developer Website</a><br>
")

            }
        }

    }
}
