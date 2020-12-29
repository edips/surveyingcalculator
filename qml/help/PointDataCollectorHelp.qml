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
    title: "Point Data Collector"
    //topPadding: banner2.visible ? banner2.height : 0

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id: optionsColumn
    STextHelp{
            stext:qsTr("Point Data Collector collects points and displays QGIS projects. You can collect points in
ShapeFile or GeoPackage formats with name and description attributes.
You can also display vector, raster, geodatabase and online maps formats with this app using QGIS software. QGIS is a free geographic information system (GIS) application
 that supports viewing, editing, and analysis of geospatial data. It runs on Windows, Linux, and Mac OSX. You can download QGIS from www.qgis.org.
 <br> <br>
<b>Features:</b> <br><br>
    • <b>Add Project:</b> New projects can be created with Add Project button in shapefile or geopackage formats. Coordinate system is set by EPSG codes. ,
More than 5000 coordinate systems are supported with EPSG code in meter or feet units.<br>
    • <b>Settings:</b> Lets you to customize the app. <br>
      &#8203;&#32;&#8203;&#32;&#8203;&#32;- <b>Order of Northing and Easting:</b> Display coordinates as Northing before Easting or Easting before Northing. (e.g. X, Y or Y,X.)<br>
      &#8203;&#32;&#8203;&#32;&#8203;&#32;- <b>Order of Latitude and Longitude:</b> Display coordinates as Latitude before Longitude or Longitude before Latitude.<br>
      &#8203;&#32;&#8203;&#32;&#8203;&#32;- <b>Display of X,Y coordinates:</b> Display Northing and Easting as N,E or X,Y or Y,X according to your routine.<br>
     &#8203;&#32;&#8203;&#32;&#8203;&#32; - <b>Dislay of Latitude and Longitude coordinates:</b> Display Latitude and Longitude as decimal format or Degree Minute Second (DMS) format.<br>
      &#8203;&#32;&#8203;&#32;&#8203;&#32;- <b>Latitude and Longitude format:</b> Choose 'Include direction(N,E,S,W)' to tisplay coordinates with directions (e.g. 38.70 N, 35.45 E).
        Choose 'Without suffix' to not include directions.<br>
    • <b>Record:</b> Store points with name and description attributes<br>
    • <b>GPS:</b> Turn on GPS mode to collect current location. Turn off GPS mode to collect any point on the map.<br>
    • <b>Zoom to Project:</b> Use this button to zoom to the extents of the project.<br>
    • <b>Project Details:</b> Displays details about project, unit and coordinate system<br>
    • <b>Add Point:</b> Adds point with point name, description X,Y or latitude, longitude format depending on the coordinate system.<br><br>
    • <b>Active Layer Panel:</b> Lets you to add point layers in ShapeFile or GeoPackage formats. Click on Active Layer button to open the panel.
You can see raster, point, line and polygon layers. It is only allowed to select point layers. Do not use spaces for layer name.<br>

You can easily import CAD or GIS data to QGIS. After you prepared QGIS project, you can transfer your qgs project with its dependencies to your
 phone's storage with USB cable. You should copy your QGIS project folder to Surveying_Calculator/projects folder.

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
        id:helplabel2
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
