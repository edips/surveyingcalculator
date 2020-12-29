import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.12
import "script.js" as JS
//property var validator_txt: RegExpValidator { regExp: /^-?(\d+(?:[\.\,]\d{15})?)$/ }
//inputMethodHints:  Qt.ImhSensitiveData
//inputMethodHints: Qt.ImhDigitsOnly
//verticalAlignment: Text.AlignVCenter

TextField {
    property int textHeight: 38
    id: myfield2
    height: textHeight
    leftPadding: 5
    font.pixelSize: 16
    selectByMouse: true
    EnterKey.type: Qt.EnterKeyNext
    Keys.onReturnPressed:  nextItemInFocusChain().forceActiveFocus()
}
