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

#include "mapprovider.h"

mapProvider::mapProvider(QObject *parent):
    QObject(parent)
{

}

//---------------------------------------------------------------
void mapProvider::setMapType(QString mapProvider) {
        m_mapType = mapProvider;
        mapTypeChanged(mapProvider);
}
