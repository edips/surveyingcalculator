import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3

Label {
    onLinkActivated: Qt.openUrlExternally(link)
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width
    textFormat: Label.RichText
    font.pixelSize:16
    wrapMode: Label.WordWrap
}
