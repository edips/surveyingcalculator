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

import QtQuick 2.12

SText {
    width: parent.width
    height: parent.height
    text: model.title
    font.bold: false
    verticalAlignment: Text.AlignTop
    wrapMode: SText.WordWrap
    horizontalAlignment: SText.AlignHCenter
    font.family: windoww.font
    z:1
}
