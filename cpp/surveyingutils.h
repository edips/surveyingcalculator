#ifndef SURVEYINGUTILS_H
#define SURVEYINGUTILS_H
#include <QString>
#include <QObject>
#include "qgsproject.h"
#include "qgsquickmapsettings.h"
#include "projectsmodel.h"
#include "qgsquickfeaturelayerpair.h"

class SurveyingUtils: public QObject
{
    Q_OBJECT
public:
    SurveyingUtils( QObject *parent = nullptr );

    // By Edip
    Q_INVOKABLE long epsg_code();
    Q_INVOKABLE QString epsg_name();
    Q_INVOKABLE bool isGeographic();
    Q_INVOKABLE bool crsValid();
    Q_INVOKABLE QString homePath();
    Q_INVOKABLE static void copy_survey_project();

    // Decimal Lat Lon
    Q_INVOKABLE static QString formatPoint_decimal(const QgsPoint point, QString format);
    // DMS Lat Lon
    Q_INVOKABLE static QString formatPoint_dms(const QgsPoint point, QString format);
    Q_INVOKABLE QList<QString> project_details();
    // Transfornm CRS, used in CoordinateConvertor app
    Q_INVOKABLE QString transformer(QString x, QString y, QString src, QString dst);
    // projdef is valid?
    Q_INVOKABLE bool projDefValid(QString projDef);
    // deneme to add a new project
    Q_INVOKABLE QString addNewProject( QString projectName, QString epsgcode, QString formatIndex );
    // Add XY or LatLong coordinates to map
    Q_INVOKABLE bool addPointLayer(QString name, QString format_index);
    // If a project exists or not
    Q_INVOKABLE bool no_project();
    Q_INVOKABLE void setActiveLayer2Point();
    Q_INVOKABLE void addLayerIfNotExists();
    Q_INVOKABLE QStringList qgsPoint2String( QgsQuickFeatureLayerPair p, bool isGeographic );
    Q_INVOKABLE QString qgsFeature2Coord( QgsQuickFeatureLayerPair p );
    Q_INVOKABLE bool featureIsPoint( QgsQuickFeatureLayerPair p );
    Q_INVOKABLE bool featureIsLine( QgsQuickFeatureLayerPair p );
    Q_INVOKABLE bool featureIsPolygon( QgsQuickFeatureLayerPair p );
    Q_INVOKABLE QString getArea( QgsQuickFeatureLayerPair p );
    Q_INVOKABLE QString getLength( QgsQuickFeatureLayerPair p);
    

private:
    QgsProject *mProject = nullptr;
    QgsQuickMapSettings *mMapSettings = nullptr;
    //LocalProjectsManager &mLocalProjects;
};

#endif // SURVEYINGUTILS_H
