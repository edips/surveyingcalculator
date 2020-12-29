import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id: header
    color: "white"

    property real rowHeight
    property string titleText: ""
    property bool withBackButton: true

    signal back()

    Item {
        id: backButton
        height: header.rowHeight
        width: height * 2
        anchors.left: header.left
        anchors.leftMargin: 30
        z: title.z + 1
        visible: withBackButton

        Image {
            id: image
            height: 15
            width: height
            source: "qrc:/assets/icons/material/navigation/arrow_back.svg"
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            anchors.bottomMargin: (parent.height - height)/2
            anchors.topMargin: anchors.bottomMargin
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        ColorOverlay {
            anchors.fill: image
            source: image
            color: "#679D70"
        }

        Text {
            id: backButtonText
            text: "Back"
            color: "#679D70"
            font.pixelSize: 16
            height: header.rowHeight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: image.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.leftMargin: header.rowHeight/4
            visible: (title.contentWidth + backButton.width * 2) > header.width ? false : true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: back()
        }
    }

    Text {
        id: title
        anchors.fill: parent
        text: header.titleText
        color: "#006146"
        font.pixelSize: 16
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

}
