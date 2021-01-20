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
import "script.js" as Calc
Row {
    property int rowspace: 120
    property bool has_z: false
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: rowspace
    layoutDirection: Calc.coord_display()
    STextTop { text: Calc.textE(); }
    STextTop { text: Calc.textN(); }
    STextTop { visible: has_z; text: "Z"; }
}
