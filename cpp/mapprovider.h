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

#ifndef MAPPROVIDER_H
#define MAPPROVIDER_H

#include <QObject>


class mapProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString mapType MEMBER m_mapType NOTIFY mapTypeChanged)
public:
    explicit mapProvider(QObject *parent = nullptr);
private:
    QString m_mapType;
signals:
    void mapTypeChanged(QString newValue);
public slots:
    void setMapType(QString mapType);
};

#endif // MAPPROVIDER_H
