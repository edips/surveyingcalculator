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

import QtQuick 2.7
import QtQuick.Controls 2.2
import Fluid.Controls 1.0 as FluidControls

Component {
    id: simpleDelegate
    FluidControls.ListItem {
        id: listItem
        text: (projectNamespace && projectName) ? (projectNamespace + "/" + projectName) : folderName
        width: parent.width
        visible: height ? true : false
        enabled: isValid
        highlighted: activeProjectPath !== "" && path === activeProjectPath ? true : false
        onClicked: {
            activeProjectIndex = index
            openProject = false
        }
    }
}
