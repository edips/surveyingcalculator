import QtQuick 2.12
import QtLocation 5.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

MapItemGroup {

    id: itemGroup
    property alias text: labelText.text
    property alias coordinate:  tgtRect.coordinate
    property alias track: area.track

    property string color: "#e41e25"
    property bool makeVisible: true

    signal targetChanged(string tgtName)
    // didn't work
    //Component.onCompleted: targetChanged(labelText.text);

    MapQuickItem {
        id: tgtRect

        sourceItem: Item {
            width: 30;
            height: width
            Image {
                id: direction
                source: "qrc:/assets/icons/marker.svg"
                sourceSize.width: 30
                sourceSize.height: 30
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                transformOrigin: Item.Center
            }
            ColorOverlay {
                anchors.fill: direction
                source: direction
                color: "red"
                transformOrigin: Item.Center
            }
        }

        anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)

        MouseArea {
            id: area
            property bool track: false
            anchors.fill: parent
            drag.target: tgtRect
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            propagateComposedEvents: true
            onClicked: {
                    followTgt.popup()
                    track = true
                    mouse.accepted = false
            }
        }

        Menu {
            id: followTgt
            Action {
                id: addTarget
                text: qsTr("Follow")
                onTriggered: {
                    targetChanged( labelText.text );
                }
            }
        }
    }
// Target NUmber
    MapQuickItem {
        sourceItem: Text {
            id: labelText
            text: ""
            color:"black"
            font.bold: true
        }
        coordinate: tgtRect.coordinate
        anchorPoint: Qt.point(tgtRect.sourceItem.width * 0.5,tgtRect.sourceItem.height * 1.5)
    }
}
