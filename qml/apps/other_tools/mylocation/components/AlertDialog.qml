import QtQuick 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3

// Alert dialog used by UTM Map for displaying coordinates
// About dialog
Dialog {
    id: alertt
    default property alias content: dialogContent.data
    property alias text: dialogLabel.text
    property int fontSize: 13
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    focus: true
    modal: true
    width: parent.width
    Column {
        id: dialogContent
        anchors {
            left: parent.left
            top: parent.top
        }
        spacing: 10
        width: parent.width

        Label {
            id: dialogLabel
            font.pixelSize: fontSize
            wrapMode: Text.Wrap
            width: parent.width
            visible: text !== ""
        }
    }
}
