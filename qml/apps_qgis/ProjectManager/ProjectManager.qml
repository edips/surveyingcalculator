// Author: Edip AHmet Taşkın
// Copy Right Edip Ahmet Taşkın

/* TODO
   * Refactor, collect javascript and use it, it can be stored in script.js
  * Code optimization is needed. When a job is done, after an action run, destructor must destruct or clean things and it should reload things again
*/
import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import Qt.labs.settings 1.1
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import "../../components/gis"
import "../../components/common"
import "../../components/common/script.js" as Utils
import "../../help"

FluidControls.Page {
    property string project_name: __projectsModel.data(__projectsModel.index(mapView.menuIndex), ProjectModel.ProjectName)
    title: "Project Manager"
    id: projectsPanelw
    appBar.maxActionCount: 1
    // whenever project manajer page opens, it refresh the files
    Component.onCompleted: { __projectsModel.refreshModel() }
    // Map View component with map canvas and project browser
    MapView {
        id: mapView
        alwaysOpenPanel: true
        anchors.fill: parent
    }
    // New Project Button
    SRoundButton {
        icon.source: "qrc:/assets/icons/material/content/add.svg";
        icon.color: "white"
        anchors {
            bottom: parent.bottom
            right: parent.right
            rightMargin: 5
            bottomMargin: 5
        }
        tooltip: qsTr("Add New Project");
        // reset the project name before the dialog opens
        onClicked: { inputDialog.project_name.text = ""; inputDialog.open() }
    }
    // Help page
    PointDataCollectorHelp{
        id:maphelp
        visible: false
    }
    // Actions
    actions: [
        // Help
        FluidControls.Action {
            id:map_help
            onTriggered: maphelp.open()
            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
    // Dialogs and Bottom sheet menu
    Column {
        id:optionsC
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        // --- DIALOGS ---------------------------------------------------------------------------------
        SErrorDialog {
            id: epsg_error
            error: "Coordinate system code doesn't exist in the database."
        }
        // New Project dialog
        NewProjectDialog { id: inputDialog }
        // Delete Dialog
        DeleteDialog { id: deleteDialog }
        // Project details dialog
        ProjectDetailsDialog { id: info_dialog }
        // BottomSheet Menu
        FluidControls.BottomSheetList {
            id: jobMenu
            title: visible ? project_name : ""
            actions: [
                // select project action
                FluidControls.Action {
                    text: qsTr("Select Project")
                    icon.source: "qrc:/assets/icons/material/action/done.svg"
                    onTriggered: {
                        // get current project's index
                        mapView.activeProjectIndex = __projectsModel.rowAccordingName(mapView.menuIndex)
                        // get current project's path
                        mapView.activeProjectPath = __projectsModel.data(__projectsModel.index(mapView.menuIndex), ProjectModel.Path)
                        // Load the selected index of the project
                        __loader.load(mapView.menuProjectPath)
                        // Set it as the default project
                        __appSettings.defaultProject = mapView.menuProjectPath
                    }
                },
                // Project Details action
                FluidControls.Action {
                    text: qsTr("Project Details")
                    icon.source: "qrc:/assets/icons/material/action/info_outline.svg"
                    onTriggered: info_dialog.projectDetails()
                },
                // Delete Project Action
                FluidControls.Action {
                    id:delete_proj
                    text: qsTr("Delete Project")
                    icon.source: "qrc:/assets/icons/material/action/delete.svg"
                    onTriggered: deleteDialog.open()
                }
            ]
        }
    }
}
