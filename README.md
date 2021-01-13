# Surveying Calculator
A modern engineering app with surveying and GIS aromas

Surveying Calculator is an open source app that includes powerful tools for GIS and surveying. This app can create and open QGIS projects. 

Why Surveying Calculator? 
- A land surveyor can convert a construction CAD project to QGIS project. He transfers the QGIS project to Surveying Calculator. He can extract coordinates of a building with this app to stake out with Total Station. No need to have coordinate list papers with maps.
- A civil engineer can transfer a road construction project to Surveying Calculator. He can use it to store points with taking pictures. It will be helpful for measuring manufacturing and reports.
- A geology engineer can use Surveying Calculator to store drilling points with taking pictures.

Surveying Calculator supports metric and imperial units for distance and area.
Using Surveying Calculator you can do:
- Collect points: Create projects in Project Manager in QGIS format. You can store points with taking photos in latitude and longitude format.
- Display QGIS projects. You can convert your CAD or GIS data to QGIS project and you can display it on Surveying Calculator. You can display AutoCAD DXF, Esri SHP, KML, GPX, GeoJSON, GeoTIFF, DEM... and other popular data formats.
- Get list of coordinates, length, area value of geometric features
- Get list of coordinates of point layer
- Display details of a geometric feature attribute or edit feature attribute
- Add point with coordinates. Remove or modify any features. You can add point in XY or latitude, longitude format depending on the project coordinate system.
 - Control visibility of layers. You can turn on or turn off layers.
- For calculations, you can manually enter values or you can choose point from your project.
- Measure distance, bearing / azimuth from two points.
- Measure angle from 3 points.
- Calculate latitude, longitude or X,Y from coordinate, distance and bearing / azimuth.
- Intersections; forward, line - line and circle by 3 points
- Convert latitude longitude to UTM or vice versa
- Calculate decimal to degree, minute, second
- Get UTM location on online maps with latitude, longitude, MGRS, X,Y coordinates
- Generate coordinates from two points. You can generate using X,Y or latitude, longitude
- Convert local coordinates
- Calculate area from X,Y coordinates
You can follow news about the app on Facebook Page:
<i>fb.me/surveyingcalculator</i>

# Development
Surveying calculator uses open source GIS libraries (QGIS, GDAL, Proj, SpatialIndex, GEOS) libraries. This app uses source codes of Input app(https://github.com/lutraconsulting/input). 

Requirements:

Qt 5.14.2

Fluid QML Library (https://github.com/lirios/fluid)

QGIS libraries from input-sdk/android-13 (armv7 and armv8), also QgsQuick libraries and files
