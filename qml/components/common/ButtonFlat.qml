// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import QtGraphicalEffects 1.0

// Flat Button
Button {
    id: button
    // default: flatButtonTextColor
    property alias textColor: buttonText.color
    property bool materialBackground: false
    property alias textAlignment: buttonText.horizontalAlignment
    focusPolicy: Qt.NoFocus
    Layout.fillWidth: true
    Layout.preferredWidth : 1
    leftPadding: 6
    rightPadding: 6
    contentItem: Text {
        id: buttonText
        text: button.text
        opacity: enabled ? 1.0 : 0.3
        color: flatButtonTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.capitalization: Qt.platform.os == "ios" ? Font.Capitalize : Font.AllUppercase
        font.weight: Font.Medium
    }
    background:
        Rectangle {
        id: buttonBackground
        implicitHeight: 48
        Layout.minimumWidth: 88
        color: button.pressed ? buttonText.color : button.materialBackground? Universal.background : "transparent"
        radius: 2
        opacity: button.pressed ? 0.12 : 1.0
    } // background
} // button
