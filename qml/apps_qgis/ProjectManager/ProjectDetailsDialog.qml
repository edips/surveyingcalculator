import QtQuick 2.10
import QtQuick.Controls 2.3
import lc 1.0
import "../../components/common"

SDialog{
    property string infolabel: ""

    function projectDetails() {
        // get current project's index
        // get current project's path
        mapView.activeProjectIndex = __projectsModel.rowAccordingName(mapView.menuIndex)
        mapView.activeProjectPath = __projectsModel.data(__projectsModel.index(mapView.menuIndex), ProjectModel.Path)
        __loader.load(mapView.menuProjectPath)
        __appSettings.defaultProject = mapView.menuProjectPath

        info_dialog.infolabel = "<b>Job Name: </b>" + __surveyingUtils.project_details()[0] +
        "<br>" + "<b>Job Path: </b>" + __surveyingUtils.project_details()[1] +
        "<br>" + "<b>Coordinate Unit: </b>" + __surveyingUtils.project_details()[2] +
        "<br>" + "<b>Distance Unit: </b>" + __surveyingUtils.project_details()[3] +
        "<br>" + "<b>Coordinate System Name: </b>" + __surveyingUtils.project_details()[4] +
        "<br>" + "<b>EPSG Code: </b>" + __surveyingUtils.project_details()[5] +
        "<br>" + "<b>Coordinate Type: </b>" + __surveyingUtils.project_details()[7] +
        "<br>" + "<b>Coordinate System Parameters: </b>" + __surveyingUtils.project_details()[6]

        info_dialog.open()
    }
    id:info_dialog
    height: 280
    title: qsTr("Project Details")
    Flickable{
        boundsBehavior: Flickable.StopAtBounds
        id:settings_flickable2
        contentHeight: mylabel.height
        clip: true
        anchors.fill: parent
        ScrollIndicator.vertical: ScrollIndicator {}
        DialogLabel{
            textFormat: Label.RichText
            id: mylabel
            text: infolabel
        }
    }
}
