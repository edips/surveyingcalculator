import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "script.js" as Script

/*
This component is used for XY coordinates with coordinate name side by side like that:
X1: ____    Y1: ____
X2: ____    Y2: ____
*/

Row {
    property string name;
    property alias northing : north
    property alias easting : east
    property alias elev: kot

    property bool readonly : false

    // for settings
    property alias north_txt: north.text
    property alias east_txt: east.text
    property alias elev_txt: kot.text

    property string z_txt: "Z" + name
    property string n_txt: Script.textN() + name
    property string e_txt: Script.textE() + name

    id: ne_root
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 5
    SText {text: name + " "; }
    Row {
        layoutDirection: Script.coord_display()
        spacing: 5
        STextField {
            id:east
            width: 100
            readOnly: ne_root.readonly
            font.pixelSize: 15
            placeholderText: Script.textE() + name
        }
        STextField {
            id:north
            width: 100
            readOnly: ne_root.readonly
            font.pixelSize: 15
            placeholderText: Script.textN() + name
        }
    }
    Row {
        STextField{
            id: kot
            width: 55
            font.pixelSize: 15
            readOnly: ne_root.readonly
            placeholderText: "Z" + name
        }
    }
}
