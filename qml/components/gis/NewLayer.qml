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
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import QtQuick.Layouts 1.3
import lc 1.0
import QgsQuick 0.1 as QgsQuick
import "../common"
import "../common/script.js" as Util

FluidControls.AlertDialog {
    id: newLayer
    x: (parent.width - width) / 2
    y: 0
    width: parent.width
    height: lyr_column.height + 130
    title: qsTr("Add Point Layer")
    standardButtons: Dialog.Ok | Dialog.Cancel
    z:layerPanel.z + 1
    
    ColumnLayout{
        id: lyr_column
        width: parent.width
        RowLayout{
            spacing: 10
            width: parent.width
            SText{
                id:formatName
                font.bold: true
                text: "Layer Name: "
            }
            TextField{
                id:textField
                width: 150
                font.pixelSize: 16
                selectByMouse: true
            }
        }
    }
    // Todo: look at the c++ code, debug it to find a solution..
    onAccepted:{
        if(__projectsModel.addPointLayer(textField.text)){
            __layersModel.reloadLayers()
            
            updateActiveLayerByName(textField.text)
            
            snack.open("Point layer has been added.")
        }else{
            snack.open("Unable to add layer.")
        }
    }
}
