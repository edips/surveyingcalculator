import QtQuick 2.11
import QtQuick.Controls 2.4

Menu {
    property variant coordinate
    property int markersCount
    property int mapItemsCount
    signal itemClicked(string item)
    modal: true

    Action {
        text: qsTr("Get coordinate")
        onTriggered: itemClicked("getCoordinate")
    }

    function update() {
    }
}
