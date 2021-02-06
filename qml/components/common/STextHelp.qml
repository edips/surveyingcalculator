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

import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.12
Rectangle{
    property string stext;
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    height: helplabel.height
    width: parent.width - 30
    Label{
        id:helplabel
        text: stext
        font.pixelSize:15
        onLinkActivated: Qt.openUrlExternally(link)
        textFormat: Label.RichText
        //anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: Label.WordWrap
        width: parent.width
        topPadding: 10
    }
}
