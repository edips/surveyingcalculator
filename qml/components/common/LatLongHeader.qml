import QtQuick 2.9
import "script.js" as Calc
Row{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 120
    layoutDirection: Calc.coord_direction_latlong()
    STextTop{text: "Latitude"; }
    STextTop{text: "Longitude"; }
}
