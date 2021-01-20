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

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import "../../"
import "generateLatLong.js" as JS
import "../../../components/common/script.js" as Utils


FluidControls.Page{
    title:qsTr("Generate Lat-Long between two Points")
    appBar.maxActionCount: 2
    id:latloncalc
    Settings{
        id:latlonancesetting
        property alias latlonanceChecked2: latloncalc.latlon_count
    }
    Loader{
            id: latlon_loader
            source: "GenerateLatLon.qml"
            anchors.fill: parent
    }
    property int latlon_count: 0
    property int latlon_count2: 0
    actions: [
       /* FluidControls.Action {
          id:latlon_action
            onTriggered:{
                latlon_count++
                JS.latlon_fav()
            }
            text: qsTr("Favourite")
            icon.source: FluidControls.Utils.iconUrl(JS.latlon_icon())
            toolTip: qsTr("Favourite")
        }
        ,
        FluidControls.Action {
          id:latlon_action2
              onTriggered:{
                  latlon_count2++
                  latlon_loader.source=JS.latlon_help()
              }
            
            icon.source: FluidControls.Utils.iconUrl(JS.latlon_helpicon())
            toolTip: qsTr("Help")
        }*/
    ]
}
