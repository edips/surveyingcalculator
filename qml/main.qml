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

import QtQuick 2.12 as QQ
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Universal 2.12
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import "components/common"
import "components/common/script.js" as Js
import "."

FluidControls.ApplicationWindow {
    // Settings loader visibility
    property bool loaderVisible: false
    property int count;
    // About loader visible
    property bool loaderAboutVisible: false
    id: windoww
    visible:true
    title: "Surveying Calculator"
    visibility: Window.AutomaticVisibility
    // font loader
    font.family : "Lato"
    width: 1080
    height: 1920
    // Count of the app action icons
    appBar.maxActionCount: 1
    Universal.theme: __appSettings.theme === 0 ? Universal.Light : Universal.Dark
    Universal.accent: "#0050EF"

    // snack bar
    FluidControls.SnackBar { id: snack }

    QQ.Loader {
        id: about
        anchors.fill: parent
        source: loaderAboutVisible ? "components/common/DialogAbout.qml" : ""
    }
    QQ.Loader {
        id: dialog_settings
        anchors.fill: parent
        source: loaderVisible ? "components/common/DialogSettings.qml" : ""
    }
    // Initial Main Page
    initialPage: FluidControls.Page {
        title: windoww.title
        MainMenu{

        }
        id:initPage
        actions: [
            FluidControls.Action {
                id:setAction
                hasDividerAfter: true
                checkable: false
                toolTip: qsTr("Settings")
                icon.source: "qrc:/assets/icons/material/action/settings.svg"
                onTriggered: {
                    loaderVisible = true
                    dialog_settings.item.settingsPage.open()
                }
            },
            FluidControls.Action {
                hasDividerAfter: true
                id:aboutAction
                text: qsTr("About")
                icon.source: "qrc:/assets/icons/material/action/info_outline.svg"
                onTriggered: {
                    loaderAboutVisible = true
                    about.item.open()
                }
            }
        ]
    }

    // Close the app ToolTip
    property bool alreadyCloseRequested: false
    onClosing: {
        if(__androidUtils.isAndroid){
            if( !alreadyCloseRequested )
            {
                __androidUtils.showToast( "Press back again to exit" )
                close.accepted = false
                alreadyCloseRequested = true
                closingTimer.start()
            }
            else
            {
                close.accepted = true
            }
        }else{
            close.accepted = true
        }
    }

    QQ.Timer {
        id: closingTimer
        interval: 2000
        onTriggered: {
            alreadyCloseRequested = false
        }
    }
}
