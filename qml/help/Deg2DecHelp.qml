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
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Degree - Decimal Conversion"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    anchors.horizontalCenter: parent.horizontalCenter
    id:optionsColumn
    STextHelp{
            stext:qsTr("Convert Degrees,Minutes,Seconds to Decimal Degrees")
    }
    STextHelp{
            stext:qsTr("One degree is equal to 60 minutes and equal to 3600 seconds:

 <br><br><b>1° = 60' = 3600</b><br><br>

One minute is equal to 1/60 degrees:

<br><br><b>1' = (1/60)° = 0.01666667°</b><br><br>

One second is equal to 1/3600 degrees:

<br><br><b>1\" = (1/3600)° = 2.77778e-4° = 0.000277778°</b><br><br>

For angle with <b>d</b> integer degrees <b>m</b> minutes and <b>s</b> seconds:

<br><br><b>d° m' s\"</b><br><br>

The decimal latitude and longitude degrees </b>latdec</b> and </b>londec</b> are equal to:

<br><br><b>latdec = <b>d</b> + m/60 + s/3600</b><br>
<br><b>londec = <b>d</b> + m/60 + s/3600</b><br>
")
    }

    STextHelp{
            stext:qsTr("Convert Decimal Degrees to Degrees,Minutes,Seconds")
    }

    STextHelp{
            stext:qsTr("One degree (°) is equal to 60 minutes (') and equal to 3600 seconds (\"):

            <br><br><b>1° = 60' = 3600\"</b><br><br>

            The integer degrees (d) are equal to the integer part of the decimal degrees (dd):

            <br><br><b>d = integer(dd)</b><br><br>

            The minutes (m):

            <br><br><b>m = integer((dd - d) × 60)</b><br><br>

            The seconds (s):

            <br><br><b>s = (dd - d - m/60) × 3600</b><br><br>

            Example
            Convert 45.659264854° angle to degrees,minutes,seconds:

            <br><br>d = integer(45.659264854°) = 45°<br>

            <br>m = integer((dd - d) × 60) = 39'<br>

            <br>s = (dd - d - m/60) × 3600 = 33.35347\"<br>

            <br>45.659264854° = 45° 39' 33.35347\"<br>")
    }

}
    }
}
