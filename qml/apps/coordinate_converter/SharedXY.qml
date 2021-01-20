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

pragma Singleton
import QtQuick 2.0
import QtQuick.Controls 2.12
import "components"

QtObject {
    property ListModel cogoInputModel: CoordInputModel{}
    property ListModel cogoOutputModel: CoordOutputModel{}
    property int mycount: 0;
}
