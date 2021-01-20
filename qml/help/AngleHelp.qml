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
    title: "Angle Conversion"
    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
        SColumnHelp{
            id:optionsColumn
            STextHelp{
                stext:qsTr("One whole revolution or circle is equal to 360 degrees, 2π radians, 400 grads or 6400 mils.
In order to measure an angle, an arc is drawn with the centre at the vertex and the angle is then equal to,
<br><br><b>angle = length of the arc / radius of the circle</b><br><br>

The following is formulas of angle units for conversion here:
")
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                height:sin_g2.height
                width:sin_g2.width
                color: "transparent"
                Image {
                    id:sin_g2
                    height: 45
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/help/AngleConvert.png"
                }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                height:ang.height
                width:ang.width
                color: "transparent"
                Image {
                    id:ang
                    width: 310
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/help/basicsurvey/second_angle.png"
                }
            }


        }
    }
}
