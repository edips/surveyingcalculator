import QtQuick 2.10
import QtQuick.Controls 2.3
import lc 1.0
import "../../components/common"

SDialog{
    id: deleteDialog
    title: "Delete Project"
    height: 130 + mylabel.height
    standardButtons: Dialog.Yes | Dialog.No

    Item {
        anchors.fill: parent
        DialogLabel{
            id: mylabel
            textFormat: Label.RichText
            text: "Really wanna delete <b>%1</b>?".arg(project_name)
        }
    }

    onAccepted: {
        if (mapView.menuIndex < 0) {
            return;
        }
        __projectsModel.deleteProject(mapView.menuIndex)
        __loader.load("")
        mapView.activeProjectIndex = -1
        if (mapView.activeProjectIndex === mapView.menuIndex) {
            __loader.load("")
            projectsPanel.activeProjectIndex = -1
        }
        mapView.menuIndex = -1
    }
    onRejected: {
        mapView.menuIndex = -1
        visible = false
    }
}
