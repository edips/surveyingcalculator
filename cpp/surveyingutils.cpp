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

#include "surveyingutils.h"
#include "qgsquickutils.h"

// for new project
#include "qgis.h"
#include "qgspointxy.h"
#include <qgsvectorlayer.h>
//#include <qgsvectorfilewriter.h>
#include <qgspallabeling.h>
#include <qgsvectorlayerlabeling.h>
#include <qgscategorizedsymbolrenderer.h>
#include <qgsmarkersymbollayer.h>
#include <qgssinglesymbolrenderer.h>
#include "layersmodel.h"
#include "inpututils.h"


SurveyingUtils::SurveyingUtils( QObject *parent )
    : QObject( parent )
    , mMapSettings( nullptr )
{

}

static QString getDataDir()
{
    QString dataPathRaw("Surveying_Calculator");

#ifdef ANDROID
    QFileInfo extDir( "/sdcard/" );
    if ( extDir.isDir() && extDir.isWritable() )
    {
        // seems that this directory transposes to the latter one in case there is no sdcard attached
        dataPathRaw = extDir.path() + "/" + dataPathRaw;
    }
    else
    {
        qDebug() << "extDir: " << extDir.path() << " not writable";

        QStringList split = QDir::homePath().split( "/" ); // something like /data/user/0/org.project.geoclass/files
        // TODO support active user from QDir::homePath()
        QFileInfo usrDir( "/storage/emulated/" + split[2] + "/" );
        dataPathRaw = usrDir.path() + "/" + dataPathRaw;
        if ( !( usrDir.isDir() && usrDir.isWritable() ) )
        {
            qDebug() << "usrDir: " << usrDir.path() << " not writable";
        }
    }
#endif
    qputenv( "QGIS_QUICK_DATA_PATH", dataPathRaw.toUtf8().constData() );
    QString dataDir = QString::fromLocal8Bit( qgetenv( "QGIS_QUICK_DATA_PATH" ) ) ;
    qDebug() << "QGIS_QUICK_DATA_PATH: " << dataDir;
    return dataDir;
}

void SurveyingUtils::copy_survey_project()
{
    QString dataDir = getDataDir();
    QString projectDir = dataDir + "/projects/" + "survey";
#if defined (ANDROID) || defined (Q_OS_IOS)
    InputUtils::cpDir( "assets:/projects/survey", projectDir );
#elif defined (Q_OS_WIN32)
    InputUtils::cpDir( QCoreApplication::applicationDirPath() + "/demo-projects", projectDir );
#else
    Q_UNUSED( projectDir );
#endif
}

long SurveyingUtils::epsg_code()
{
    /*
        // srsid givers wrong epsg id for many coordinate systems. Class reference also mentions to use PostgissrsID :createFromId	(long id, CrsType type = PostgisCrsId )
        qDebug() << "mProject->crs().srsid::::::::::::" << mProject->crs().srsid();
        // this works for wgs84 utm whick srsid didn't work
        qDebug() << "mProject->crs().postgisSrid::::::::::::" << mProject->crs().postgisSrid();
        //------------------------------------------------------------------------------------
        // mapUnits output is: QgsUnitTypes::DistanceMeters
        qDebug() << "mProject->crs().mapUnits::::::::::::" << mProject->crs().mapUnits();
        // name of EPSG coordinate system
        qDebug() << "mProject->crs().srsid::::::::::::" << mProject->crs().description();
    */
    return mProject->crs().postgisSrid();
}

QString SurveyingUtils::epsg_name()
{
    if(mProject->crs().isValid()){
        qDebug() << "EPSG Name in cpp: " << mProject->crs().description();
        return mProject->crs().description();
    }else{
        qDebug() << "CRS is not recognized!";
        return "WGS84";
    }
}

bool SurveyingUtils::isGeographic()
{
    if ( mProject->crs().isGeographic() ){
        return true;
    }
    else {
        return false;
    }
}

bool SurveyingUtils::crsValid()
{
    if(mProject->crs().postgisSrid()){
        return true;
    }
    else{
        return false;
    }
}

QString SurveyingUtils::homePath()
{
    QgsProject *maProj = mProject->instance();
    qDebug()<< "homeeeeeeeeeee pathhhhhhhh : " << maProj->homePath();
    return maProj->homePath();
}

QString SurveyingUtils::formatPoint_decimal( QString x, QString y, QString format)
{
    QgsPoint point = QgsPoint( x.toDouble(), y.toDouble() );
    if(format == "included"){
        return QgsQuickUtils::formatPoint(point,QgsCoordinateFormatter::FormatDecimalDegrees,7, QgsCoordinateFormatter::FlagDegreesUseStringSuffix);
    }else{
        return QgsQuickUtils::formatPoint(point,QgsCoordinateFormatter::FormatDecimalDegrees,7, QgsCoordinateFormatter::FlagDegreesPadMinutesSeconds);
    }
}

QString SurveyingUtils::formatPoint_dms( QString x, QString y, QString format)
{
    QgsPoint point = QgsPoint( x.toDouble(), y.toDouble() );
    if(format == "included"){
        return QgsQuickUtils::formatPoint(point,QgsCoordinateFormatter::FormatDegreesMinutesSeconds, 5, QgsCoordinateFormatter::FlagDegreesUseStringSuffix);
    }else{
        return QgsQuickUtils::formatPoint(point,QgsCoordinateFormatter::FormatDegreesMinutesSeconds, 5, QgsCoordinateFormatter::FlagDegreesPadMinutesSeconds);
    }
}

QList<QString> SurveyingUtils::project_details()
{
    QgsProject *myProject = mProject->instance();
    // Project Properties
    // Job Path
    QString homePath = myProject->homePath();
    // Job name
    QString name = myProject->baseName();
    // coordinate unit
    QString coordUnit = QgsUnitTypes::toString(myProject->crs().mapUnits());
    // Distance Unit
    QString distUnit = QgsUnitTypes::toString(myProject->distanceUnits());
    // Coordinate System Name
    QString coordName = myProject->crs().description();
    // EPSG Code
    QString EPSG = myProject->crs().authid();
    // Coordinate System Parameters
    QString proj4 = myProject->crs().toProj();
    // Coordinate System type
    QString coordType;
    if(myProject->crs().isGeographic() || !( myProject->crs().postgisSrid() ) ){
        coordType = "Geographic";
    }else{
        coordType = "Projected";
    }

    QList<QString> propDetails = {name,homePath, coordUnit, distUnit, coordName, EPSG, proj4, coordType};
    return propDetails;
}

QString SurveyingUtils::transformer(QString x, QString y, QString src, QString dst)
{
    // Source CRS, type of it is QgsCoordinateReferenceSystem
    QgsCoordinateReferenceSystem source = QgsCoordinateReferenceSystem("EPSG:" + src);
    // Destination CRS, type of it is QgsCoordinateReferenceSystem
    QgsCoordinateReferenceSystem destination = QgsCoordinateReferenceSystem("EPSG:" + dst);

    qDebug() << "src epsg: " << src << " destination epsg: " << dst;
    qDebug() << "source.isValid()? " << source.isValid() << " destination.isValid()? " << destination.isValid();
    //qDebug() << "source.toProj4(): " << source.toProj() << " destination.toProj4(): " << destination.toProj();
    qDebug() << "x: " << x << " y: " << y;
    qDebug() << "x.toDouble(): " << x.toDouble() << " y.toDouble(): " << y.toDouble();

    if(!(source.isValid()) || !(destination.isValid())){
        qDebug() << "source.isValid()? " << source.isValid() << " destination.isValid()? " << destination.isValid();
        return "";
    }
    // srcPoint from double values, type is QgsPointXY
    QgsPoint srcPoint = QgsPoint( x.toDouble(), y.toDouble(), 0);
    qDebug() << "debug transform 1";
    QString coords;

    QgsCoordinateTransformContext context;
    if ( mMapSettings )
        context = mMapSettings->transformContext();
    qDebug() << "debug transform 2";
    QgsCoordinateTransform mTransform(source, destination, context);
    qDebug() << "debug transform 3";
    // Transform coordinate and assign it to pt variable
    mTransform.transform( srcPoint );
    coords = mTransform.transform( srcPoint ).toString(8);
    return coords;
}

bool SurveyingUtils::projDefValid(QString projDef)
{
    QgsCoordinateReferenceSystem destination = QgsCoordinateReferenceSystem::fromProj(projDef);
    return destination.isValid();
}


/*!
  Under construction
*/
QString SurveyingUtils::addNewProject(QString projectName, QString epsgcode, QString formatIndex)
{

    // QString type,       1: crs_not_found,   2: fileExists,          3: ok

    //    ProjectModel pm( mLocalProjects );
    //    QString new_path = pm.dataDir() + projectName;
    //    long epsg_code = epsgcode.toLong();
    //    QDir dir(new_path);
    //    // changed for Qgis 3.15
    //    QgsCoordinateReferenceSystem my_crs;
    //    // todo: fix double slashes like /sdcard/Surveying_Calculator/projects//Good/Good.qgs
    //    if ( !(my_crs.fromSrsId(epsg_code).isValid()) ){
    //        return "crs_not_found";
    //    }
    //    else if ( !(dir.exists()) ){
    //        dir.mkpath(".");
    //        QString temp_projectName = projectName;
    //        QString layerName = new_path + "/" + temp_projectName;
    //        qDebug() << "layer  nameeeeeeeeeee path: " << layerName;

    //        projectName = new_path + "/" + projectName + ".qgs";
    //        //layerName = new_path + "/" + projectName;
    //        qDebug() << "project path is: " << projectName;
    //        mProject = QgsProject::instance();
    //        mProject->clear();
    //        mProject->setFileName(projectName);
    //        mProject->setCrs(QgsCoordinateReferenceSystem::fromEpsgId(epsg_code));

    //        QgsVectorLayer *tempLayer = new QgsVectorLayer( "Point?crs=epsg:" + epsgcode , QStringLiteral( "Surveying_Point" ), "memory" );

    //        QString extention;
    //        QString ogr_driver;

    //        if(formatIndex == "1"){
    //            extention = ".gpkg";
    //            ogr_driver = "GPKG";
    //        }else if(formatIndex == "0"){
    //            extention = ".shp";
    //            ogr_driver = "ESRI Shapefile";
    //        }

    //        //QgsVectorFileWriter::writeAsVectorFormat(tempLayer, layerName + extention, "CP1250", QgsCoordinateReferenceSystem::fromEpsgId(epsg_code), ogr_driver);
    //        QgsVectorLayer *temp2 = new QgsVectorLayer(layerName + extention, "Survey_Point", "ogr");

    //        //QgsVectorFileWriter::writeAsVectorFormat(tempLayer,"Surveying_Point_new", "UTF-8", QgsCoordinateReferenceSystem(3857), "ESRI Shapefile");
    //        // Create fields instance
    //        QgsFields fields;
    //        // Append Name and Description fields to fields
    //        fields.append(QgsField("Name", QVariant::String, "text", 50));
    //        fields.append(QgsField("Desc", QVariant::String, "text", 200));
    //        // Add Attributes of the vector layer
    //        temp2->dataProvider()->addAttributes(fields.toList());

    //        // Labelling the layer
    //        QgsPalLayerSettings layer_settings;
    //        QgsTextFormat text_format;
    //        text_format.setFont(QFont("Ubuntu Mono",9));
    //        text_format.setSize(8.0);

    //        layer_settings.setFormat(text_format);
    //        layer_settings.fieldName = "Name";

    //        //layer_settings.placement = "2";

    //        temp2->setLabelsEnabled(true);
    //        temp2->setLabeling(new QgsVectorLayerSimpleLabeling(layer_settings));

    //        // MARKER SIZE
    //        QgsMarkerSymbol *symbol = new QgsMarkerSymbol();

    //        QgsStringMap properties;

    //        symbol->setSize(0.8);
    //        symbol->setColor("black");

    //        temp2->setRenderer( new QgsSingleSymbolRenderer( symbol ) );
    //        temp2->triggerRepaint();

    //        mProject->addMapLayer(temp2);

    //        // Setting up extent of the point layer:
    //        //temp2->setExtent(QgsRectangle(1000.0, 1000.0, 2000.0, 2000.0));

    //        qDebug() << "temp2->extent().toString(2) :::::::::::::::::::" << temp2->extent().toString(2);
    //        /*
    //        writer = QgsVectorFileWriter("/home/sylvain/test.shp",
    //                                     "CP1250",
    //                                     fields,
    //                                     QgsWkbTypes.Point, #### instead of QGis.WKBPoint
    //                                     QgsCoordinateReferenceSystem(), #### instead of None
    //                                     "ESRI Shapefile")
    //        */

    //        mProject->write();
    //        qDebug() << mProject->fileName();


    //        //Clean the mProjectFiles list and reload all projects in it again, it means refreshing.
    //        beginResetModel();
    //        mProjectFiles.clear();

    //        findProjectFiles();

    //        // find the index of the new project
    //        int i = 0;
    //        int projectExistsAt = -1;


    //        //! Edit it with a few lines of code!!! With a clear code. Not like old code-------------------------------------------
    //        /*
    //        for ( ProjectFile projectFile : mProjectFiles )
    //        {
    //            if ( mDataDir + projectFile.folderName == dir.path() )
    //            {
    //                projectExistsAt = i;
    //            }
    //            i++;
    //        }
    //*/
    //        endResetModel();

    //        return "ok";
    //    }
    //    else{
    //        return "fileExists";
    //    }
    return "";
}

bool SurveyingUtils::addPointLayer(QString name, QString format_index)
{
    //QList<QString> myLayersList;

    QgsProject *mProject2 = mProject->instance();

    for (auto i : mProject2->mapLayers() )
    {
        if( i->name() == name ){
            qDebug() << "There is a duplicated layer!!!!!! try a different name.";
            return false;
        }
    }

    long epsg_code = mProject2->crs().postgisSrid();
    QString layerName = mProject2->homePath() + "/" + name;



    mProject2->crs().postgisSrid();

    QString epsg_str = QString::number(epsg_code);
    QgsVectorLayer *tempLayer = new QgsVectorLayer( "Point?crs=epsg:" + epsg_str , name, "memory" );

    QString extention;
    QString ogr_driver;

    if(format_index == "0"){
        extention = ".gpkg";
        ogr_driver = "GPKG";
    }else if(format_index == "1"){
        extention = ".shp";
        ogr_driver = "ESRI Shapefile";
    }

    //QgsVectorFileWriter::writeAsVectorFormat(tempLayer, layerName + extention, "CP1250", QgsCoordinateReferenceSystem::fromEpsgId(epsg_code), ogr_driver);
    QgsVectorLayer *temp2 = new QgsVectorLayer(layerName + extention, name, "ogr");

    // Create fields
    QgsFields fields;
    // Create Name and Description field and append it to fields
    fields.append(QgsField("Name", QVariant::String, "text", 50));
    fields.append(QgsField("Desc", QVariant::String, "text", 200));
    // Add fields using dataProvider
    temp2->dataProvider()->addAttributes(fields.toList());
    // Update fields
    temp2->updateFields();



    // Labelling the layer
    QgsPalLayerSettings layer_settings;
    QgsTextFormat text_format;
    text_format.setFont(QFont("Ubuntu Mono",9));
    text_format.setSize(8.0);

    layer_settings.setFormat(text_format);
    layer_settings.fieldName = "Name";

    //layer_settings.placement = "2";

    temp2->setLabelsEnabled(true);
    temp2->setLabeling(new QgsVectorLayerSimpleLabeling(layer_settings));


    // MARKER SIZE
    QgsMarkerSymbol *symbol = new QgsMarkerSymbol();

    QgsStringMap properties;


    symbol->setSize(0.8);
    symbol->setColor("black");

    temp2->setRenderer( new QgsSingleSymbolRenderer( symbol ) );
    temp2->triggerRepaint();


    qDebug() << "Project name for adding new layer function: " << mProject2->fileName();


    mProject2->addMapLayer(temp2);
    mProject2->write();
    //mProject2->reloadAllLayers();

    qDebug() << "projection crs of the project is:   ********** " << mProject2->crs().postgisSrid();
    qDebug() << "projection crs of the project is:   ********** " << mProject2->crs().authid();

    return true;
}

/*!
    Under Construction
*/
bool SurveyingUtils::no_project()
{
    //qDebug() << "Project file length**************** " << mProjectFiles.length();
    //return mProjectFiles.length() == 0 ? true : false;
    return false;
}

void SurveyingUtils::setActiveLayer2Point()
{
    QgsProject *mProject2 = mProject->instance();

    for (auto i : mProject2->mapLayers() )
    {
        if ( i->isValid() )
        {
            QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( i );
            // Check if there is a point layer
            if(vectorLayer && vectorLayer->geometryType() == QgsWkbTypes::PointGeometry){

                qDebug() << "there is a point layer!";
            }
            qDebug() << "layer name: " << i->name();
        }
    }
}



/*!
    Not necessary, just an example for API usage
*/
// Adding Surveying Layer if it is empty.. works on linux, not android. We will investigate it why it doesn't work.
void SurveyingUtils::addLayerIfNotExists()
{

    //QList<QString> myLayersList;
    bool thereIsPointLayer = false;

    QgsProject *mProject2 = mProject->instance();

    for (auto i : mProject2->mapLayers() )
    {
        if ( i->isValid() )
        {
            QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( i );
            // Check if there is a point layer
            if(vectorLayer && vectorLayer->geometryType() == QgsWkbTypes::PointGeometry){
                thereIsPointLayer = true;
                qDebug() << "there is a point layer!";
            }
            qDebug() << "layer name: " << i->name();
        }
    }

    qDebug() << "home path of the project -**********" << mProject2->homePath();

    if(!thereIsPointLayer){
        long epsg_code = mProject2->crs().postgisSrid();
        QString layerName = mProject2->homePath() + "/Surveying_Point";

        QString epsg_str = QString::number(mProject2->crs().postgisSrid());
        QgsVectorLayer *tempLayer = new QgsVectorLayer( "Point?crs=epsg:" + epsg_str , QStringLiteral( "Surveying_Point" ), "memory" );
        //QgsVectorFileWriter::writeAsVectorFormat(tempLayer, layerName + ".gpkg", "CP1250", QgsCoordinateReferenceSystem::fromEpsgId(epsg_code), "GPKG");
        QgsVectorLayer *temp2 = new QgsVectorLayer(layerName + ".gpkg", "Surveying_Point", "ogr");

        //QgsVectorFileWriter::writeAsVectorFormat(tempLayer,"Surveying_Point_new", "UTF-8", QgsCoordinateReferenceSystem(3857), "ESRI Shapefile");
        // Create fields
        QgsFields fields;
        // Create Name and Description field and append it to fields
        fields.append(QgsField("Name", QVariant::String, "text", 50));
        fields.append(QgsField("Desc", QVariant::String, "text", 200));
        // Add fields using dataProvider
        temp2->dataProvider()->addAttributes(fields.toList());
        // Update fields
        temp2->updateFields();



        // Labelling the layer
        QgsPalLayerSettings layer_settings;
        QgsTextFormat text_format;
        text_format.setFont(QFont("Ubuntu Mono",9));
        text_format.setSize(8.0);

        layer_settings.setFormat(text_format);
        layer_settings.fieldName = "Name";

        //layer_settings.placement = "2";

        temp2->setLabelsEnabled(true);
        temp2->setLabeling(new QgsVectorLayerSimpleLabeling(layer_settings));


        // MARKER SIZE
        QgsMarkerSymbol *symbol = new QgsMarkerSymbol();

        QgsStringMap properties;


        symbol->setSize(0.8);
        symbol->setColor("black");

        temp2->setRenderer( new QgsSingleSymbolRenderer( symbol ) );
        temp2->triggerRepaint();


        qDebug() << "Project name for adding new layer function: " << mProject2->fileName();

        //beginResetModel();
        mProject2->addMapLayer(temp2);
        mProject2->write();
        mProject2->reloadAllLayers();
        //endResetModel();
    }
}

// QgsPoint to coordinate array function. x: Easting, y: Northing
QStringList SurveyingUtils::qgsPoint2String( QgsQuickFeatureLayerPair p )
{
    QStringList coords;
    QgsPointXY point = p.feature().geometry().asPoint();
    if( p.layer()->crs().isGeographic() ) {
        coords << QString::number( point.x(), 'f', 7 );
        coords << QString::number( point.y(), 'f', 7 );
    } else {
        coords << QString::number( point.x(), 'f', 2 );
        coords << QString::number( point.y(), 'f', 2 );
    }
    return coords;
}


/*
qDebug() << "single line type: " << p.feature().geometry().type();
qDebug() << "single line length: " << p.feature().geometry().length();
qDebug() << "single line isGeosValid: " << p.feature().geometry().isGeosValid();
qDebug() << "single line x: " << p.feature().geometry().vertices().next().x();
qDebug() << "p.feature().geometry().wkbType(): " << p.feature().geometry().wkbType();

for polygon:
//asWkt and asJson works
qDebug() << "as asWkt: " << p.feature().geometry().asWkt(2);
qDebug() << "as asJson: " << p.feature().geometry().asJson(2);
qDebug() << "wkb tye: " << QgsWkbTypes::displayString( p.feature().geometry().wkbType() );
*/

// Get Feature coordinates
//! TODO: code clear, create a few functions or create a class
QString SurveyingUtils::qgsFeature2Coord( QgsQuickFeatureLayerPair p, QString latlonOrder, QString xyOrder )
{
    QString coords_str {""};
    QTextStream coords(&coords_str);
    int precision = p.layer()->crs().isGeographic() ? 7 : 2;

    QgsMapLayer *layer = p.layer();

    if( featureIsPoint(p) ) {
        qDebug() << "it is point";
        QgsPointXY point = p.feature().geometry().asPoint();
        QString coord_str;
        if( layer->crs().isGeographic() ) {
            if( latlonOrder == "order_latlong") {
                coords << QString::number( point.y(), 'f', precision ) << "   " <<  QString::number( point.x(), 'f', precision ) << "\n";
            } else {
                coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
            }
        }
        else {
            if( xyOrder == "en" ) {
                coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
            } else {
                coords << QString::number( point.y(), 'f', precision ) << "   " << QString::number( point.x(), 'f', precision ) << "\n";
            }
        }
    }
    else if( featureIsLine( p ) ) {
        qDebug() << "it is line";
        bool geomSingleType = QgsWkbTypes::isSingleType( p.feature().geometry().wkbType() );
        // single line
        if( geomSingleType ) {
            QgsPolylineXY vertices = p.feature().geometry().asPolyline();
            if( layer->crs().isGeographic() ) {
                for( auto point : vertices ) {
                    if( latlonOrder == "order_latlong") {
                        coords << QString::number( point.y(), 'f', precision ) << "   " <<  QString::number( point.x(), 'f', precision ) << "\n";
                    } else {
                        coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
                    }
                }
            }
            else {
                for( auto point : vertices ) {
                    if( xyOrder == "en" ) {
                        coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
                    } else {
                        coords << QString::number( point.y(), 'f', precision ) << "   " << QString::number( point.x(), 'f', precision ) << "\n";
                    }
                }
            }
            qDebug() << "Single Line";
        }
        // multi line
        else {
            QgsMultiPolylineXY vertices = p.feature().geometry().asMultiPolyline();
            for( auto part : vertices ) {

                if( layer->crs().isGeographic() ) {
                    for( auto point : part ) {
                        if( latlonOrder == "order_latlong") {
                            coords << QString::number( point.y(), 'f', precision ) << "   " <<  QString::number( point.x(), 'f', precision ) << "\n";
                        } else {
                            coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
                        }
                    }
                }
                else {
                    for( auto point : part ) {
                        if( xyOrder == "en" ) {
                            coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
                        } else {
                            coords << QString::number( point.y(), 'f', precision ) << "   " << QString::number( point.x(), 'f', precision ) << "\n";
                        }
                    }
                }
                qDebug() << "Multi Line";
            }
        }
    }
    else if ( featureIsPolygon(p) ) {
        const QgsMultiPolygonXY mpoly = p.feature().geometry().asMultiPolygon();
        const QgsPolygonXY poly = mpoly.at( 0 );
        const QgsPolylineXY pline = poly.at( 0 );
        qDebug() << "polygon size: " << poly.size();
        qDebug() << "polyline size: " << pline.size();

        if( layer->crs().isGeographic() ) {
            for( auto point : pline ) {
                if( latlonOrder == "order_latlong") {
                    coords << QString::number( point.y(), 'f', precision ) << "   " <<  QString::number( point.x(), 'f', precision ) << "\n";
                } else {
                    coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
                }
            }
        }
        else {
            for( auto point : pline ) {
                if( xyOrder == "en" ) {
                    coords << QString::number( point.x(), 'f', precision ) << "   " << QString::number( point.y(), 'f', precision ) << "\n";
                } else {
                    coords << QString::number( point.y(), 'f', precision ) << "   " << QString::number( point.x(), 'f', precision ) << "\n";
                }
            }
        }
        qDebug() << "it is polygon";
    }
    coords_str = coords.readAll();
    return coords_str;
}



bool SurveyingUtils::featureIsPoint(QgsQuickFeatureLayerPair p)
{
    QgsVectorLayer *layer = p.layer();
    return layer && layer->geometryType() == QgsWkbTypes::PointGeometry;
}

bool SurveyingUtils::featureIsLine(QgsQuickFeatureLayerPair p)
{
    QgsVectorLayer *layer = p.layer();
    return layer && layer->geometryType() == QgsWkbTypes::LineGeometry;
}

bool SurveyingUtils::featureIsPolygon(QgsQuickFeatureLayerPair p)
{
    QgsVectorLayer *layer = p.layer();
    return layer && layer->geometryType() == QgsWkbTypes::PolygonGeometry;
}

QString SurveyingUtils::getArea(QgsQuickFeatureLayerPair p)
{
    QString area_str;
    if( featureIsPolygon( p ) ) {
        QgsDistanceArea area;
        // Get area from ellipsoidal earth
        if( p.layer()->crs().isGeographic() ) {
            area.setEllipsoid( p.layer()->crs().ellipsoidAcronym() );
            area_str = QString::number( area.measureArea( p.feature().geometry() ), 'f', 2 );
        }
        // Get area from cartesien flat earth (accurate for big scale maps)
        else {
            area_str = QString::number( area.measureArea( p.feature().geometry() ), 'f', 2 );
        }
    }
    return area_str;
}

QString SurveyingUtils::getLength(QgsQuickFeatureLayerPair p)
{
    QString length_str;
    if( featureIsLine( p ) ) {
        QgsDistanceArea length;
        // Get length from ellipsoidal earth
        if( p.layer()->crs().isGeographic() ) {
            length.setEllipsoid( p.layer()->crs().ellipsoidAcronym() );
            length_str = QString::number( length.measureLength( p.feature().geometry() ), 'f', 2 );
        }
        // Get length from cartesien flat earth (accurate for big scale maps)
        else {
            length_str = QString::number( length.measureLength( p.feature().geometry() ), 'f', 2 );
        }
    }
    return length_str;
}

bool SurveyingUtils::isfeatureGeographic( QgsQuickFeatureLayerPair p )
{
    return p.layer()->crs().isGeographic();
}
