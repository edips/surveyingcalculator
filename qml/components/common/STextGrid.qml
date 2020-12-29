import QtQuick 2.12

SText {
    width: parent.width
    height: parent.height
    text: model.title
    font.bold: false
    verticalAlignment: Text.AlignTop
    wrapMode: SText.WordWrap
    horizontalAlignment: SText.AlignHCenter
    font.family: windoww.font
    z:1
}
