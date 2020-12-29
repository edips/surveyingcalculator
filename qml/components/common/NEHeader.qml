import QtQuick 2.9
import "script.js" as Calc
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 120
    layoutDirection: Calc.coord_display()
    STextTop{text: Calc.textN(); }
    STextTop{text: Calc.textE(); }
}
