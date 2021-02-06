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
import Fluid.Core 1.0 as FluidCore
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
import "../components/common/script.js" as Util
/** The form toolbar **/
TopSheet{
    id: mapviewer_help
    title: "UTM Map"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id: optionsColumn
    STextHelp{

            stext:qsTr("UTM Map displays latitude - longitude, MGRS and UTM X,Y coordinates on the map. You can see your coordinates
 or you can get coordinates of any place on the map. You can stake out coordinates or places you want on the map. User can see the
 accuracy of the GPS, compass azimuth and compass on the map. It displays UTM zone in 6 degrees.The coordinates are based on WGS84 projection.
 Tens of map types are supported such as terrain, biking, street, satellite and hybrid maps. UTM Location includes Open Street Maps, Here Maps
 and Esri map providers.
 <br> <br>
<b>Menu</b> <br><br>
You can configure coordinate display with menu. You can turn on or turn off these options from the menu:
<br><br><b>Display MGRS Coordinates:</b> Displays Military Grid Reference System Coordinates
 <br><br><b>Display Compass:</b> Displays compass marker on the map, also displays azimuth angle in degree
 <br><br><b>Display Grid Zone Code:</b> Displays grid designator alpha code. This code is displayed with UTM zone number.
 <br><br><b>Display Crosshair:</b> Displays crosshair when GPS button is disabled. It is in the middle of the map. It can be helpful to see exact coordinates on the map.
 <br><br><b>Enable GPS button:</b> When it is active, the map follows position of user on map. Coordinates display user’s position. When GPS button is not active,
it doesn’t follow user’s location. Middle of the map coordinates are displayed.
<br><br><b>Go to Coordinate:</b> Stake out latitude and longitude with this option. It will navigate to the target point from your position. It displays distance in metric unit on the line.
 You can add a few points to go to coordinates. To navigate to another point, click on the target point and click on “Follow” option.
 ")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_gw.height+10
        width:sin_gw.width
        color: "transparent"
        Image {
            id:sin_gw
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/utm_map/menu.jpg"
        }
    }

    STextHelp{

            stext:qsTr("
<br><b>Go to Coordinate:</b> Stake out latitude and longitude with this option. It will navigate to the target point from your position. It displays distance in metric unit on the line.
 You can add a few points to go to coordinates. To navigate to another point, click on the target point and click on “Follow” option.
 ")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_gwaaa.height+10
        width:sin_gwaaa.width
        color: "transparent"
        Image {
            id:sin_gwaaa
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/utm_map/gotopoint.jpg"
        }
    }

    STextHelp{
            stext:qsTr("
<br><b>Map Menu</b><br>
Long press on the map to open map menu.
<br><b>Go to point:</b> You can select this option to navigate or measure from your position to anywhere on the map. It displays distance in metric unit on the line. You can add a few points to go to coordinates. To navigate to another point, click on the target point and click on “Follow” option.
<br><br><b>Get Coordinate:</b> You can get coordinate anywhere on the map with this option. It includes latitude, longitude, X, Y, UTM zone and MGRS coordinates.
 ")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_gwaasa.height+10
        width:sin_gwaasa.width
        color: "transparent"
        Image {
            id:sin_gwaasa
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/utm_map/long_press.jpg"
        }
    }

    STextHelp{
            stext:qsTr("
<br><b>Map Providers</b><br>
You can select many map types with map providers. Select menu on the right side of Map Type. You can select Open Street Maps, Here and Esri maps like the picture below.
 ")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:uuuu.height+10
        width:uuuu.width
        color: "transparent"
        Image {
            id:uuuu
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/utm_map/providers.jpg"
        }
    }

    STextHelp{
            stext:qsTr("
You can press Full Screen button to see the map in full screen mode.
 ")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ttttt.height+10
        width:ttttt.width
        color: "transparent"
        Image {
            id:ttttt
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/utm_map/fullscren.jpg"
        }
    }


}
    }
}
