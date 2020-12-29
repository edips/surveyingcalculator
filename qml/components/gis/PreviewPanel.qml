import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QgsQuick 0.1 as QgsQuick

Item {
    id: previewPanel
    property real rowHeight: 64* QgsQuick.Utils.dp
    property QgsQuick.AttributeFormModel model

    property alias titleBorder: titleBorder
    property string title: ""
    property string mapTipType: ""
    property string mapTipImage: ""
    property string mapTipHtml: ""
    property variant previewFields: []
    property bool isReadOnly

    signal contentClicked()
    signal editClicked()

    MouseArea {
        anchors.fill: parent
        onClicked: {
            contentClicked()
        }
    }

    layer.enabled: true
    //layer.effect: Shadow {}

    Rectangle {
        anchors.fill: parent
        color:  "white"

        Rectangle {
            anchors.fill: parent
            anchors.margins: 30* QgsQuick.Utils.dp
            anchors.topMargin: 0

            Item {
                id: header
                width: parent.width
                height: previewPanel.rowHeight

                Item {
                    id: title
                    width: parent.width
                    height: parent.height - titleBorder.height
                    Text {
                        id: titleText
                        height: parent.height
                        width: parent.width - rowHeight
                        text: previewPanel.title
                        font.pixelSize: 15
                        color: "#006146"
                        font.bold: true
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        elide: Qt.ElideRight
                    }

                    Item {
                        id: iconContainer
                        height: rowHeight
                        width: height
                        anchors.left: titleText.right
                        anchors.right: parent.right
                        visible: !previewPanel.isReadOnly

                        MouseArea {
                            id: editArea
                            anchors.fill: iconContainer
                            onClicked: editClicked()
                        }

                        Image {
                            id: icon
                            anchors.fill: parent
                            anchors.margins: rowHeight/4
                            anchors.rightMargin: 0
                            source: "edit.svg"
                            sourceSize.width: width
                            sourceSize.height: height
                            fillMode: Image.PreserveAspectFit
                        }

                        ColorOverlay {
                            anchors.fill: icon
                            source: icon
                            color: "#006146"
                        }
                    }
                }

                Rectangle {
                    id: titleBorder
                    width: parent.width
                    height: 1
                    color: "#006146"
                    anchors.bottom: title.bottom
                }
            }

            Item {
                id: content
                width: parent.width
                anchors.top: header.bottom
                anchors.bottom: parent.bottom

                // we have three options what will be in the preview content: html content, image or field values

                Text {
                    visible: mapTipType == 'html'
                    text: mapTipHtml
                    anchors.fill: parent
                    anchors.topMargin: 30* QgsQuick.Utils.dp
                }

                Image {
                    visible: mapTipType == 'image'
                    source: mapTipImage
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    anchors.topMargin: 30* QgsQuick.Utils.dp
                }

                ListView {
                    visible: mapTipType == 'fields'
                    model: previewPanel.model
                    anchors.fill: parent
                    anchors.topMargin: 30* QgsQuick.Utils.dp
                    spacing: 2 * QgsQuick.Utils.dp
                    interactive: false

                    delegate: Item {
                        id: root
                        width: parent.width
                        height:previewFields.indexOf(Name) >= 0 ? previewPanel.rowHeight/2 : 0
                        visible: height

                        Text {
                            id: fieldName
                            text: Name
                            width: root.width/2
                            height: root.height
                            font.pixelSize: 15
                            color: "#679D70"
                            elide: Text.ElideRight
                            anchors.rightMargin: 30* QgsQuick.Utils.dp
                        }

                        Text {
                            id: text2
                            text: AttributeValue ? AttributeValue : ""
                            anchors.left: fieldName.right
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.top: parent.top
                            height: root.height
                            font.pixelSize: 15
                            color: "#006146"
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }
}
