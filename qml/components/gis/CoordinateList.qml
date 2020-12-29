import QtQuick 2.10
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import "../common"
import "../common/script.js" as Util


Popup {
    property string title;
    property alias toolbar: tool_bar
    property alias toolbar_group: toolbarGroup
    property color universalcolor: Universal.accent
    property alias editor: editor_txt
    property bool editable: false

    property bool isGeographic: false

    id: coordList
    title: "Coordinate List"
    focus: true
    modal: true

    onClosed: {
        loaderVisible =  false
    }
    Component.onCompleted: forceActiveFocus()
    height: parent.height + FluidCore.Device.gridUnit
    width: parent.width
    visible: false
    closePolicy: Popup.CloseOnEscape // prevents the drawer closing while moving canvas

    padding: 0

    Timer {
        id: timer
        interval: 500; running: false; repeat: false
        onTriggered: editor_txt.deselect()
    }

    FluidControls.AppToolBar {
        id:tool_bar
        height: FluidCore.Device.gridUnit * 0.8
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        RowLayout {
            id: toolbarGroup
            anchors.fill: parent
            Layout.margins: 0
            spacing: 2
            FluidControls.ToolButton {
                id: copyBtn
                flat: true
                icon.source: "qrc:/assets/icons/material/content/content_copy.svg"
                icon.color: "white"
                onClicked: {
                    editor_txt.selectAll()
                    editor_txt.copy()
                    timer.start()
                }
            }
            FluidControls.ToolButton {
                id: editBtn
                icon.source: "qrc:/assets/icons/material/editor/mode_edit.svg"
                icon.color: "white"
                checkable: true
                onClicked: {
                    if( editBtn.checked ) {
                        editable = true
                    } else {
                        editable = false
                    }
                }
                background: Rectangle {
                    color: editBtn.checked ? "#0088ff" : "#003B6D"
                }
            }
            Item{
                Layout.fillWidth: true
            }

            FluidControls.ToolButton {
                id: closeButton
                Layout.alignment: Qt.AlignRight
                flat: true
                icon.source: "qrc:/assets/icons/material/navigation/close.svg"
                icon.color: "white"
                onClicked: {
                    coordList.close()
                }
            }
        }
    }

    Item {
        id:optionsPage
        anchors.top: coordList.toolbar.bottom
        width: parent.width
        height: parent.height

        SColumnHelp {
            id: optionsColumn
            width: parent.width
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            NEHeader {id: coordHearder; topPadding: 15; visible: !isGeographic; }
            LatLongHeader { topPadding: 15; visible: isGeographic; }
            Component.onCompleted: console.log( "__loader.isGeographic() in cordinate list: ", __loader.isGeographic())
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width:  coordList.width - 50
                    height:  coordList.height - coordHearder.height - coordList.toolbar.height - 50
                    color:"transparent"
                    Flickable {
                        id: flickable
                        anchors.fill: parent
                        flickableDirection: Flickable.VerticalFlick
                        contentWidth: parent.width
                        contentHeight: editor_txt.height
                        clip: true
                        Column {
                            id: lineNumber
                            spacing: 0
                            Repeater {
                                id: lineNumberRepeater
                                model: editor_txt.lineCount
                                STextTop {
                                    text: index + 1
                                    color: 'gray'
                                    font.pixelSize: 15
                                }
                            }
                        }
                        TextArea.flickable: TextArea {
                            id: editor_txt
                            placeholderText: "Empty"
                            wrapMode: TextEdit.WrapAnywhere
                            selectByMouse: editable
                            readOnly: !editable
                            topPadding: 0
                            leftPadding: 10
                            inputMethodHints:  Util.keyboard_display()
                            font.pixelSize: 15
                            anchors.left: lineNumber.right

                        }
                        ScrollBar.vertical: ScrollBar { }
                    }
                }
            }
        }
    }
}
