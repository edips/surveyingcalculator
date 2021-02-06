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
    title: "Survey"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id: optionsColumn
    STextHelp{

            stext:qsTr("Survey module collects points and displays QGIS projects. You can collect points in GeoPackage formats with name, description and photo attributes.
Before starting with survey module, create a new project from Project Manager. The new project is stored in Surveying_Calculator/projects path in your storage.
Project format is in QGIS.
 <br> <br>
<b>Features:</b> <br><br>
• <b>GPS:</b> Turn on GPS mode to collect current point for your location. When GPS is active with enough accuracy, it zooms to your position.
 If active point layer is selected, it displays
coordinates of your position. If GPS doesn't work, please active your GPS from Android settings or accept GPS permission when you open the app.

<br><br>• <b>Active Layer Panel:</b> Let's you to choose point layer. It only displays point layers. When active layer is selected, you will be able to see your current location,
you can add points and you can get coordinate list of the point layer.

<br><br>• <b>Layer Panel:</b> You can see vector or raster layers. You can turn on or turn off the layers.
<br><br>• <b>Zoom to Project:</b> Use this button to zoom to the extents of the project.

<br><br>• <b>Record:</b> Store points with name, description and photo attributes. You take a photo with camera or you can choose photo from gallery for the point.

<br><br>• <b>Add Point:</b> Adds point with X,Y or latitude, longitude format depending on the coordinate system of the active layer.

<br><br>• <b>Coordinate List:</b> Extracts all point coordinates from the active point layer.
 Coordinate format can be X, Y or Latitude, Longitude depending on the coordinate system of the active layer.

<br><br>• <b>Full Screen button:</b> You can see the map in full screen mode. It prevents editing the map.

<br><br>Survey module can display vector, raster, geodatabase (postgis) and online maps in QGIS format.
You can install QGIS to your desktop to prepare your projects for Surveying Calculator.
It is very easy to prepare project with QGIS. Just drag and drop your data into QGIS and set up the coordinate system of your project.
 It supports AutoCAD DWG, DXF, Esri SHP, GeoTIFF and many more formats.
After you prepared QGIS project, you can transfer your qgs project with its dependencies to your phone's storage with USB cable.
You should copy your QGIS project folder to Surveying_Calculator/projects folder.
For more details, please watch the video:  <a href=\"https://www.youtube.com/watch?v=JKo1xtH6zfo\">Preparing project on QGIS desktop</a>
 ")

    }


    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g.height
        width:sin_g.width
        color: "transparent"
        Image {
            id:sin_g
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/mapviewer/mv1.png"
        }

    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_gr.height+10
        width:sin_gr.width
        color: "transparent"
        Image {
            id:sin_gr
            width:300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/mapviewer/mv2.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_gq.height+10
        width:sin_gq.width
        color: "transparent"
        Image {
            id:sin_gq
            width: 300
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/mapviewer/mv3.png"
        }
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
            source:"qrc:/assets/images/help/mapviewer/mv4.png"
        }
    }
}
    }
}
