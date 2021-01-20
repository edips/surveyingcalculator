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
import QtGraphicalEffects 1.0
import QtQuick.Controls.Universal 2.3



RoundButton {
    property string tooltip: ""
    icon.width: 35
    icon.height: 35
    ToolTip.visible: pressed
    ToolTip.delay: 500
    ToolTip.text: tooltip


    background: rectangel

    Rectangle {
        id: rectangel
        radius: height / 2
        //color: Universal.chromeMediumColor
        color: Universal.accent
    }
}
