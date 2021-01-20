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
import QtQuick.Layouts 1.3
import "../../components/common"
import "components"
import "coordinateconverter.js" as JS
import "database.js" as Db
import "../../components/common/script.js" as Utils

/*
TODO:
- add Hesap component and enable decimal checkable button
- Code clear and add explanations, comments
- Prepare a detailed documentation step by step. add every detals
- Prepare a help page about how to use this app
*/

FluidControls.Page{
    appBar.maxActionCount: 1
    id:coordcalc

    property int counter_coord_settings;
    // Country list from database, it will be used as country CustomComboBox
    property var countries: Db.country_list
    // US state list from database, it will be used as US state CustomComboBox
    property var usa_states: Db.us_state_list
    // Coordinate name list; gets list of coordinate names from database. It can be coordinate name list of country or U.S. states
    property var coordName_list
    // projDef list; gets list of coordinate names from database. It can be coordinate name list of country or U.S. states
    property var projDef_list
    property var my_unit

    property int country_currentIndex: country_dialog.countrycombo
    property int us_currentIndex: country_dialog.uscombo

    property string country_text: country_dialog.country_text
    property string us_text: country_dialog.us_text

    Component.onCompleted: {
        if(counter_coord_settings===0){
            country_dialog.visible=true
        }
        counter_coord_settings = 1;
    }

    Settings{
        id: transform_settings
        property alias country_counter: coordcalc.counter_coord_settings
    }

    // In order to make settings work correctly we must first load CoordinateConverter qml file. Then we load CountryDialog.
    CoordinateConverter{
        anchors.fill: parent
    }
    // If CountryDialog is loaded before CoordinateConverter.qml, then it will not be able to initialize current index of input and output CustomComboBoxes
    // CustomComboBox first fetch data from database according to country group. That's why we must consider the wml file before settings
    CountryDialog{
        id: country_dialog
    }

    DialogAddCRS{
        id: addCRS
    }

    DialogRemove{
        id: removeCRS
    }


    actions: [
        FluidControls.Action {
            id:fav_action_coord
            onTriggered:{
                SharedXY.mycount++;
            }
            toolTip: qsTr("Get GPS Location")
            icon.source: JS.startgps(SharedXY.mycount) ? "qrc:/assets/icons/material/av/pause.svg" : "qrc:/assets/icons/material/maps/my_location.svg"
        },

        FluidControls.Action {
            id:coord_remove
            text: qsTr("Add New CRS")
            onTriggered:{
                addCRS.open()
            }
            icon.source: "qrc:/assets/icons/material/content/add_circle_outline.svg"
        },
        FluidControls.Action {
            id:coord_action2
            text: qsTr("Remove CRS")
            onTriggered:{
                removeCRS.open()
            }
            icon.source: "qrc:/assets/icons/material/action/delete.svg"
        },

        FluidControls.Action {
            id:setAction
            //toolTip: qsTr("Select Country")
            text: qsTr("Select Country")
            icon.source: "qrc:/assets/icons/material/action/language.svg"
            onTriggered:{
                country_dialog.open()
            }
         }


    ]
}
