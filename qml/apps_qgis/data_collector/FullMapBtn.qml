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

import QtQuick 2.10
import QtQuick.Window 2.12
import "../../components/common"

RoundBtn{
    property int inputFormHeight
    z: mapCanvas.z + 1
    id:fullMapBtn
    background_color: "#80d9d9d9"
    icon.height: 35
    icon.width: 35
    anchors{
        right: parent.right
        top: count_full %2 === 0 ? recordToolbar.bottom : parent.top
        rightMargin: 5

    }
    onClicked: {
        count_full++
        if (count_full %2 === 0){
            windoww.visibility = Window.AutomaticVisibility
            collect_pane.height = inputFormHeight + 20
            recordToolbar.visible = true
            recordButton.visible = true
            windoww.footer.visible = true
            crosshair.visible = true
            north.visible = true
        }
        else if(count_full %2 === 1){
            windoww.visibility = Window.FullScreen
            collect_pane.height = 0
            recordToolbar.visible = false
            recordButton.visible = false
            windoww.footer.visible = false
            crosshair.visible = false
            north.visible = false
        }
    }
    icon.source:{
        if (count_full %2 === 0){
            return "qrc:/assets/icons/material/navigation/fullscreen.svg"
        }
        else if(count_full %2 === 1){
            return "qrc:/assets/icons/material/navigation/fullscreen_exit.svg"
        }
    }
}
