import QtQuick 2.12
import QtQuick.Controls 2.2

Item {
    id: busyIndicator
    anchors.centerIn: parent
    width: 100
    height: 100
    property alias busy: busy_ind;
    // busy indicator for loading project list
    BusyIndicator {
        id: busy_ind
        opacity: 0
        anchors.centerIn: parent
        width: 45
        height: 45
        running: false
        visible: running
        z: openProjectPanel.z + 1
        OpacityAnimator on opacity {
            id: opac_anime
            target: busy_ind;
            running: busy_ind.running
            from: 0;
            to: 0.5;
            duration: 2000
        }
    }
}