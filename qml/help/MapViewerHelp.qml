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
    title: "Map View Help"

    SFlickable {
        id:optionsPage

        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    STextHelp{
            stext:qsTr("Map View displays QGIS projects. QGIS is a free desktop geographic information system (GIS) application
 that supports viewing, editing, and analysis of geospatial data. It runs on Windows, Linux, and Mac OSX. You can download QGIS from www.qgis.org.
You can easily import CAD or GIS data to QGIS. After you prepared QGIS project, you can transfer your qgs project with its dependencies to your
 phone's storage with USB cable.
You should copy your QGIS project folder to Surveying_Calculator/projects folder.
 <br>
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

    STextHelp{
                stext:qsTr("
    You can see your position in the project with 'My Location'. 'My Location' is working properly for projects using WGS84 coordinate system.
<br>QGIS projects can include vector, raster and geodatabase data.<br><b>Supported CAD-GIS formats:</b><br>
    • shp (ESRI shapefiles)<br>
    • mif, tab (MapInfo File)<br>
    • dgn (MicroStation v7)<br>
    • dxf (AutoCAD)<br>
    • PostGIS<br>
    • SpatiaLite<br>
    • e00 (ArcInfo ASCII Coverage)<br>
    • mdb (ESRI Personal GeoDatabase)<br>
    • gpkg (Geopackage)<br>
    • gpx<br>
    • GeoJSON<br>
    • TopoJSON<br>
    • GML<br>
    • Geospatial PDF<br>
    • svg<br>
    • kml, kmz<br>
    • osm (OpenStreet Map)<br>
    and many more. <br>
    <br>
    <b>Supported Raster formats:</b><br>
    • xyz (ASCII Gridded XYZ)<br>
    • asc (ArcInfo ASCII Grid)<br>
    • e00 (ArcInfo export E00 grid)<br>
    • img (ERDAS Imagine img)<br>
    • GeoTIFF<br>
    • grd (Golden Software 7 Binary Grid)<br>
    • JPEG, PNG, BMP<br>
    • DEM(USGS ASCII DEM)<br>
    and many more.<br>
    ")
        }


}
    }


}
