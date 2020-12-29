import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QgsQuick 0.1 as QgsQuick

Item {
    id: root
    property string contentText: ""
    property string imageSource: ""
    property real rowHeight: 64* QgsQuick.Utils.dp
    property real panelMargin: 30* QgsQuick.Utils.dp
    property bool overlayImage: true
    property bool highlight: false
    property bool showBorder: true

    property color fontColor: "#006146"
    property color panelColor: "white"
    property color highlightColor: "#679D70"

    anchors.fill: parent

    Item {
        id: row
        anchors.fill: parent
        width: parent.width
        height: parent.height

        Item {
            id: iconContainer
            height: rowHeight
            width: rowHeight

            Image {
                id: icon
                anchors.fill: parent
                anchors.margins: rowHeight/4
                source: imageSource
                sourceSize.width: width
                sourceSize.height: height
                fillMode: Image.PreserveAspectFit
            }

            ColorOverlay {
                anchors.fill: icon
                source: icon
                color: root.highlight ? root.panelColor : root.fontColor
                visible: overlayImage
            }
        }

        Item {
            id: textContainer
            y: 0
            x: iconContainer.width + panelMargin
            width: parent.width - rowHeight
            height: rowHeight

            Text {
                id: mainText
                text: root.contentText
                height: parent.height
                width: parent.width

                font.pixelSize: 15
                font.weight: Font.Bold
                color: root.highlight ? root.panelColor : root.fontColor
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Rectangle {
        id: borderLine
        color: root.highlightColor
        width: row.width
        height: 1
        visible: root.showBorder
        anchors.bottom: parent.bottom
    }
}
