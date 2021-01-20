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
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import QgsQuick 0.1 as QgsQuick
import lc 1.0
//import Qt.labs.settings 1.1
import "../../components/common"

FluidControls.AlertDialog {
    // For resetting project name text field when clicking round button
    property alias project_name: projectName
    //Settings { id: projSettings; property alias epsgCode: epsg_code.text }
    id: inputDialog
    closePolicy: Popup.CloseOnEscape // prevents the drawer closing while moving canvas
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: parent.width
    height: job_column.implicitHeight + 150
    // didn't work: onOpened: inputDialog.textField = ""
    title: qsTr("New Project")
    standardButtons: Dialog.Ok | Dialog.Cancel

    Column{
        id: job_column
        topPadding: 7
        width: parent.width
        spacing: 10
        Row{
            spacing: 10
            SText{
                id:jobName
                font.bold: true
                text: "Project Name"
            }
            STextField2 {
                id: projectName
                width: 150
            }
        }
    }
        /*
        Row{
            spacing: 10
            SText{
                font.bold: true
                text: "EPSG Code"
            }
            STextField {
                id:epsg_code
                text: "4326"
                width: 150
                font.pixelSize: 16
                selectByMouse: true
            }
        }
        Label{
            text:"Enter EPSG code to set a proper coordinate system(E.g. 4326 for WGS84). You can get EPSG code at
                <a href=\"http://epsg.io\">epsg.io</a> with searching for country or coordinate system name."
            onLinkActivated: Qt.openUrlExternally(link)
            textFormat: Label.RichText
            wrapMode: Label.Wrap
            width: parent.width
        }
    }*/
    onAccepted:{
        // warn user if input is empty
        if(projectName.text===""){
            snack.open("Please enter a project name.")
        }
        else if( __projectsModel.addNewProject( projectName.text) === "ok" ) {

            __loader.load("")
            mapView.activeProjectIndex = -1

            __projectsModel.refreshModel()

            mapView.noprojectVisible = false

            //mapView.activeProjectIndexChanged()
            snack.open("Project added: " + projectName.text)
        }
        else if( __projectsModel.addNewProject(projectName.text) === "fileExists" ) {
            snack.open(projectName.text + " already exists. Please try a different name.")
        }
    }
}
