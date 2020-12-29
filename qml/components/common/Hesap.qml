import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Fluid.Controls 1.0 as FluidControls
import "script.js" as Util

Rectangle {
    height: 60
    width: 200
    color: "transparent"

    property variant clear_list : []
    property alias clear: c
    property alias hesap: hesaplak
    property int row_spacing: decimalCheck ? 30 : 50
    property bool decimalCheck: false
    property bool decimalActive: dec_check.checked

    function clearAll(){
        for(var i = 0; i < clear_list.length; i++){
            clear_list[i].text = ""
        }
    }

    Row{
        id:myrow
        spacing:row_spacing
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Button {
            id:hesaplak
            width: 50
            Image {
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                width: 40
                source: "qrc:/assets/images/equal.png"
            }
            highlighted: true
        }
        Button {
            id:c
            width: 40
            icon.source: "qrc:/assets/icons/material/content/clear.svg"
        }
        CheckBox {
            id: dec_check
            visible: decimalCheck
            text: "decimal"
            checked: __appSettings.latlongDisplay === "display_dec"
            onCheckedChanged: {
                if( checked ) {
                    __appSettings.latlongDisplay = "display_dec"
                } else {
                    __appSettings.latlongDisplay = "display_dms"
                }
            }
        }
    }
}
