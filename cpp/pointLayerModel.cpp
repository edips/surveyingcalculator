#include "layersmodel.h"

#include <qgslayertreemodel.h>
#include <qgslayertreenode.h>
#include <qgslayertree.h>
#include <qgsvectorlayer.h>
#include <qgslayertreemodellegendnode.h>
#include <qgsproject.h>
#include <qgsmaplayer.h>
#include <qgswkbtypes.h>

#include <QString>

LayersModel::LayersModel( QgsProject *project, QObject *parent )
  : QAbstractListModel( parent )
  , mProject( project )
{
  reloadLayers();
}

LayersModel::~LayersModel()
{
}

// Deneme
void LayersModel::getCoordsTepe()
{
    mProject = QgsProject::instance();
    //mProject->clear();


    QgsLayerTreeGroup *root = mProject->layerTreeRoot();

    // Get list of all visible and valid layers in the project
    QList< QgsMapLayer * > allLayers;

    QList<QString> myLayersList;

    foreach ( QgsLayerTreeLayer *nodeLayer, root->findLayers() )
    {
      if ( nodeLayer->isVisible() )
      {
        QgsMapLayer *layer = nodeLayer->layer();
        if ( layer->isValid() )
        {
          allLayers << layer;
          myLayersList.append(layer->name());
        }
      }
    }
    for(int i=0;i<myLayersList.length(); i++){
        qDebug() << "my layers list: " << myLayersList[i];
    }




    QString myLayer = myLayersList[0];
    QgsMapLayer *firstLayer = mProject->mapLayersByName(myLayer).first();
    qDebug() << "layer name is: " << firstLayer->name();
    qDebug() << "layer is Editable? : " << firstLayer->isEditable();
    qDebug() << "layer ID : " << firstLayer->id();
    qDebug() << "layer CRS proj4 : " << firstLayer->crs().toProj4();
    qDebug() << "layer CRS wkt : " << firstLayer->crs().toWkt();
    qDebug() << "layer CRS EPSG ID : " << firstLayer->crs().EpsgCrsId;
    qDebug() << "layer CRS is geographic? : " << firstLayer->crs().isGeographic();
    qDebug() << "layer CRS description name : " << firstLayer->crs().description();
    qDebug() << "layer CRS unit : " << firstLayer->crs().mapUnits();
    qDebug() << "layer Extent : " << firstLayer->extent().toString(2);
    qDebug() << "layer source : " << firstLayer->source();
    qDebug() << "layer read-only : " << firstLayer->readOnly();
   // qDebug() << "layer metadata type : " << firstLayer->metadata().type();
    //qDebug() << "layer originalXmlProperties : " << allLayers.at(0)->originalXmlProperties();

    /*qDebug() << "----------- sublayers? ------------------------------------";
    foreach(auto &x,firstLayer->subLayers())
        qDebug()<<x;
    qDebug() << "----------------------------------------------";*/

    //qDebug() << "layer htmlMetadata : " << firstLayer->htmlMetadata();
    //QgsGeometry geo = QgsGeometry::asPoint(tepe);

    QgsMapLayer *layer = pointLayers.at(0);
    QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );

    
    foreach(auto &ii,pointLayers)
        qDebug()<< "Layer name: " << ii->name();

    
    // Type of the first layer in the qgs project
    QgsWkbTypes::GeometryType type = vectorLayer->geometryType();
    if(type == QgsWkbTypes::GeometryType::PointGeometry){
        // layer name
        qDebug() << layer->name() << " is a point----------------------***********";
        // 2. index of feature name in attributes
        qDebug() << "vector layer first attribute: " << vectorLayer->attributeDisplayName(1);
        qDebug() << "vector layer first type: " << vectorLayer->getFeature(17).geometry().type();
        // get point geometry information in json, like coordinates and geometry type
        qDebug() << "vector layer first json geometry: " << vectorLayer->getFeature(17).geometry().asJson(2);
        // get x and y coordinates depending on a fid value, the point's fid value is 17
        qDebug() << "vector layer first geometry().asPoint().x() : " << vectorLayer->getFeature(17).geometry().asPoint().x() << " .y(): " << vectorLayer->getFeature(17).geometry().asPoint().y();
        // get azimuth
        qDebug() << "vector layer azimuth between 17 and 18: " << vectorLayer->getFeature(17).geometry().asPoint().azimuth(vectorLayer->getFeature(18).geometry().asPoint());


        int i {0};
        QgsFeatureIterator iter = vectorLayer->getFeatures();
        QgsFeature mFeat;
        // get a point layer's x and y coordinate list.


        QgsFields fields = vectorLayer->fields();
        for(auto i : fields){
            qDebug() << vectorLayer->name() << " fields: " << i.name();
        }


        while(iter.nextFeature(mFeat)){
            i++;
            // get x or y of the point geometry layer
            qDebug() << "mfeat xy is: " << mFeat.geometry().asPoint().x() << mFeat.geometry().asPoint().y();
            qDebug() << "mfeat xy json is: " << mFeat.geometry().asJson(2);
            // fid value
            qDebug() << "mfeat id is: " << mFeat.id();
            // get the index of Kot_degeri
            qDebug() << "mfeat id is: " << mFeat.fieldNameIndex("Kot_degeri");
            // get Kot_degeri field's values
            qDebug() << "mfeat id is: " << mFeat.attribute("Kot_degeri").toString();
        }
        //qDebug() << "vector layer first type: " << vectorLayer->getFeature(17).geometry().asPoint().set()

    }else if(type == QgsWkbTypes::GeometryType::LineGeometry){
        qDebug() << layer->name() << " is a line----------------------***********";
    }
    else if(type == QgsWkbTypes::GeometryType::PolygonGeometry){
            qDebug() << layer->name() << " is a polygon----------------------***********";
        }










    /*
layer = processing.getObject(point)
iter1 = layer.getFeatures()
for feature1 in iter1:
        x = feature1.geometry().asPoint().x()
        y = feature1.geometry().asPoint().y()
        print "X Coord : %d" %x
        print "Y Coord : %d" %y
        print
*/
/*
    iface.setActiveLayer(tepe)
    features = tepe.getFeatures()

    for feature in features:
        # retrieve every feature with its geometry and attributes
        print("Feature ID: ", feature.id())
        # fetch geometry
        # show some information about the feature geometry
        geom = feature.geometry()
        geomSingleType = QgsWkbTypes.isSingleType(geom.wkbType())
        if geom.type() == QgsWkbTypes.PointGeometry:
            # the geometry type can be of single or multi type
            if geomSingleType:
                x = geom.asPoint()
                print("Point: ", x)
            else:
                x = geom.asMultiPoint()
                print("MultiPoint: ", x)
        else:
            print("Unknown or invalid geometry")
        # fetch attributes
        attrs = feature.attributes()
        # attrs is a list. It contains all the attribute values of this feature
        print(attrs)
            */
    //mProject->setCrs(QgsCoordinateReferenceSystem(4326));
    //mProject->write();
    qDebug() << mProject->fileName();
}

void LayersModel::reloadLayers()
{
  QgsLayerTreeGroup *root = mProject->layerTreeRoot();

  // Get list of all visible and valid layers in the project
  QList< QgsMapLayer * > allLayers;

  //QList<QString> myLayersList;

  foreach ( QgsLayerTreeLayer *nodeLayer, root->findLayers() )
  {
    if ( nodeLayer->isVisible() )
    {
      QgsMapLayer *layer = nodeLayer->layer();
      QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );

      if ( layer->isValid() )
      {
          //-------------

          if(vectorLayer && vectorLayer->geometryType() == QgsWkbTypes::PointGeometry){
              pointLayers.append(layer);
              allLayers << layer;
          }
          //-------------


        qDebug() << "Found layer: " << layer->name();
        //myLayersList.append(layer->name());
      }
    }
  }
  /*for(int i=0;i<myLayersList.length(); i++){
      qDebug() << "my layers list: " << myLayersList[i];
  }*/

 /* for(int i=0;i<pointLayers.length(); i++){
        qDebug() << "my point layers name " << pointLayers[i]->name();
    }*/
  if ( pointLayers != allLayers )
  {
    beginResetModel();
    pointLayers = allLayers;
    endResetModel();

    emit layersChanged();
  }
}

QVariant LayersModel::data( const QModelIndex &index, int role ) const
{
  int row = index.row();
  if ( row < 0 || row >= pointLayers.count() )
    return QVariant( "" );

  /*
QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
vectorLayer && vectorLayer->geometryType() == QgsWkbTypes::PointGeometry;
*/
  QgsMapLayer *layer = pointLayers.at( row );


  switch ( role )
  {

  // returns source path of the layer
  case Source:
  {
    return layer->source();
  }
  // return XML layer properties like proj def, extends, styles, path, layer name
  case LayerProperties:
  {
    return layer->originalXmlProperties();
  }
  // returns CRS name
  case CRS_Name:
  {
    return layer->crs().description();
  }
  // returns ellipsoid
  case CRS_Ellipsoid:
  {
    return layer->crs().ellipsoidAcronym();
  }
  // returns EPSG code
  case CRS_EPSG:
  {
    return layer->crs().authid();
  }
  // returns layer's extent coordinates
  case Extent_Coordinates:
  {
    return layer->extent().toString(3);
  }
  // is editable or not?
  case isEditable:
  {
    return layer->isEditable();
  }
    case Name:
    {
      //QString pack=layer->subLayers().join(",");
      return layer->name();
    }
    case isVector:
    {
      return layer->type() == QgsMapLayerType::VectorLayer;
    }
    case hasPointGeometry:
    {
      QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
      return vectorLayer && vectorLayer->geometryType() == QgsWkbTypes::PointGeometry;

    }
    case isReadOnly:
    {
      return layer->readOnly();
    }
    case IconSource:
    {
      QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
      if ( vectorLayer )
      {
        QgsWkbTypes::GeometryType type = vectorLayer->geometryType();
        switch ( type )
        {
          case QgsWkbTypes::GeometryType::PointGeometry: return "qrc:/assets/icons/mIconPointLayer.svg";
          case QgsWkbTypes::GeometryType::LineGeometry: return "qrc:/assets/icons/mIconLineLayer.svg";
          case QgsWkbTypes::GeometryType::PolygonGeometry: return "qrc:/assets/icons/mIconPolygonLayer.svg";
          case QgsWkbTypes::GeometryType::UnknownGeometry: return "";
          case QgsWkbTypes::GeometryType::NullGeometry: return "";
        }
        return QVariant();
      }
      else return "qrc:/assets/icons/mIconRaster.svg";
    }
    case VectorLayer:
    {
      QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
      if ( vectorLayer )
      {
        return QVariant::fromValue<QgsVectorLayer *>( vectorLayer );
      }
      return QVariant();
      }
      case HasGeometry:
      {
        QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
        if ( vectorLayer )
        {
          return vectorLayer->wkbType() != QgsWkbTypes::NoGeometry && vectorLayer->wkbType() != QgsWkbTypes::Unknown;
        }
        return false;
    }
  }

  return QVariant();
}

QHash<int, QByteArray> LayersModel::roleNames() const
{
  QHash<int, QByteArray> roleNames = QAbstractListModel::roleNames();
  roleNames[Name] = "name";
  roleNames[Source] = "source";
  roleNames[LayerProperties] = "layer_properties";
  roleNames[isVector] = "isVector";
  roleNames[CRS_Name] = "crs_name";
  roleNames[CRS_Ellipsoid] = "crs_ellipsoid";
  roleNames[CRS_EPSG] = "crs_epsg";
  roleNames[Extent_Coordinates] = "extent_coordinates";
  roleNames[isEditable] = "isEditable";
  roleNames[hasPointGeometry] = "hasPointGeometry";
  roleNames[isReadOnly] = "isReadOnly";
  roleNames[IconSource] = "iconSource";
  roleNames[VectorLayer] = "vectorLayer";
  roleNames[HasGeometry] = "hasGeometry";
  return roleNames;
}

QModelIndex LayersModel::index( int row, int column, const QModelIndex &parent ) const
{
  Q_UNUSED( column )
  Q_UNUSED( parent )
  return createIndex( row, 0, nullptr );
}

int LayersModel::rowAccordingName( QString name, int defaultIndex ) const
{
  int i = 0;
  for ( QgsMapLayer *layer : pointLayers )
  {
    if ( layer->name() == name )
    {
      return i;
    }
    i++;
  }
  return defaultIndex;
}

int LayersModel::noOfEditableLayers() const
{
  int count = 0;
  for ( QgsMapLayer *layer : pointLayers )
  {
    if ( !layer->readOnly() )
    {
      count++;
    }
  }

  return count;
}

int LayersModel::firstNonOnlyReadableLayerIndex() const
{
  int i = 0;
  for ( QgsMapLayer *layer : pointLayers )
  {
    if ( !layer->readOnly() )
    {
      return i;
    }
    i++;
  }

  return -1;
}

int LayersModel::rowCount( const QModelIndex &parent ) const
{
  Q_UNUSED( parent )
  return pointLayers.count();
}

QList<QgsMapLayer *> LayersModel::layers() const
{
  return pointLayers;
}

void LayersModel::setFeatureSurvey(int index, QString name, QString desc, QgsPoint centerPoint)
{
 /*

            //QgsVectorLayer *tempLayer = new QgsVectorLayer( "Point?crs=epsg:" + epsgcode , QStringLiteral( "Surveying_Point" ), "memory" );
            //QgsVectorFileWriter::writeAsVectorFormat(tempLayer, layerName + ".shp", "CP1250", QgsCoordinateReferenceSystem(epsg_code), "ESRI Shapefile");
            QgsVectorLayer *temp2 = new QgsVectorLayer(layerName + ".shp", "Surveying_Point", "ogr");

            QgsFeature feature(0);
            feature.setGeometry(QgsGeometry::fromPointXY(QgsPointXY(21333.0,6726313.0)));
            feature.setAttributes(QgsAttributes() << "Point1" << "This is my first point");
            QgsFeatureList flist;
            flist << feature;
            temp2->dataProvider()->addFeatures(flist);
            temp2->updateFields();
 */
    if ( index < 0 || index >= pointLayers.count() )
      qDebug() << "Layer index is invalid :::::::::::::::::::::::";

    QgsMapLayer *layer = pointLayers.at( index );
    qDebug() << "map Layer name is :::::::::::::::::::::::" << layer->name();
    QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
    qDebug() << "vector Layer name:::::::::::::::::::::::" << vectorLayer->name();

    QgsFeature feature(0);
    feature.setGeometry(QgsGeometry::fromPointXY(centerPoint));
    feature.setAttributes(QgsAttributes() << name << desc);

    QgsFeatureList flist;
    flist << feature;

    if(vectorLayer->dataProvider()->addFeatures(flist)){
        qDebug() << "feature should be added, its result is true. :::::::::::::";
    }else{
        qDebug() << "feature wasn't added, result is false. :::::::::::::";
    }
    vectorLayer->updateFields();
    vectorLayer->triggerRepaint();

}

void LayersModel::addFeatureSurvey(int index, QString name, QString desc, QString n_str, QString e_str)
{
    if ( index < 0 || index >= pointLayers.count() )
      qDebug() << "Layer index is invalid :::::::::::::::::::::::";

    QgsMapLayer *layer = pointLayers.at( index );
   // qDebug() << "map Layer name is :::::::::::::::::::::::" << layer->name();
    QgsVectorLayer *vectorLayer = qobject_cast<QgsVectorLayer *>( layer );
    //qDebug() << "vector Layer name:::::::::::::::::::::::" << vectorLayer->name();

    double n = n_str.toDouble();
    double e = e_str.toDouble();


    QgsFeature feature(0);
    //feature.setGeometry(QgsGeometry::fromPointXY(QgsPointXY(30.0,40.0)));
    feature.setGeometry(QgsGeometry::fromPointXY(QgsPointXY(e, n)));
    feature.setAttributes(QgsAttributes() << name << desc);

    QgsFeatureList flist;
    flist << feature;

    if(vectorLayer->dataProvider()->addFeatures(flist)){
        qDebug() << "feature should be added, its result is true. :::::::::::::";
    }else{
        qDebug() << "feature wasn't added, result is false. :::::::::::::";
    }
    qDebug() << "name:" << name << " desc: " << desc << " str of n: " << n_str << " str of e: " << e_str << " n: " << n << " e: " << e;
    vectorLayer->updateFields();
    vectorLayer->triggerRepaint();
}
