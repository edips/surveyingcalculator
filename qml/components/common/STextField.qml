import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.12
import "script.js" as JS
//property var validator_txt: RegExpValidator { regExp: /^-?(\d+(?:[\.\,]\d{15})?)$/ }
//inputMethodHints:  Qt.ImhSensitiveData
//inputMethodHints: Qt.ImhDigitsOnly
//verticalAlignment: Text.AlignVCenter
// implicitWidth: 120

TextField {
    id: myfield
    height: 38
    implicitWidth: 120
    leftPadding: 5
    font.pixelSize: 16
    inputMethodHints: JS.keyboard_display()
    selectByMouse: true
    validator: RegExpValidator { regExp: /^-?(\d+(?:[\.\,]\d{15})?)$/ }
    EnterKey.type: Qt.EnterKeyNext
    Keys.onReturnPressed:  nextItemInFocusChain().forceActiveFocus() 
}
