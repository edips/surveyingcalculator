import QtQuick 2.9
import "script.js" as Calc
Row {
    property int rowspace: 120
    property bool has_z: false
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: rowspace
    layoutDirection: Calc.coord_display()
    STextTop { text: Calc.textE(); }
    STextTop { text: Calc.textN(); }
    STextTop { visible: has_z; text: "Z"; }
}
