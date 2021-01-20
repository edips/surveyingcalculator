/***************************************************************************
  Copyright            : (C)  Lutra Consulting
  Modified by          : Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef LAYERSMODEL_H
#define LAYERSMODEL_H

#include <QObject>

#include "qgsmaplayermodel.h"
#include "qgsvectorlayer.h"
#include "qgsproject.h"

class LayersModel : public QgsMapLayerModel
{
    Q_OBJECT

  public:
    LayersModel();

    //! Returns list of all layers
    QList<QgsMapLayer *> layers() const { return mLayers; };

    Q_INVOKABLE QgsPoint addFeatureSurvey(QString n_str, QString e_str);
    Q_INVOKABLE bool pointIsEmpty( QgsPoint p );



    enum LayerRoles
    {
      LayerNameRole = Qt::UserRole + 100, //! Reserved for QgsMapLayerModel roles
      VectorLayerRole,
      HasGeometryRole,
      IconSourceRole,
      LayerIdRole,
      HasPointGeometry,
        LayerCheckedRole
    };
    Q_ENUMS( LayerRoles )

    //! Methods overridden from QgsMapLayerModel
    QVariant data( const QModelIndex &index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QgsProject *mProject = nullptr;
};

#endif // LAYERSMODEL_H
