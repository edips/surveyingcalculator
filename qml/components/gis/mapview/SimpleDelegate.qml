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
