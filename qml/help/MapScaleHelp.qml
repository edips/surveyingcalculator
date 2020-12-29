import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Map Scale Calculation"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    STextHelp{
            stext:qsTr("Map scale is the proportion between a distance on a map and a corresponding distance on the ground. The calculation is convenient for large-scale maps (1:25000 or more).
<br>
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g2.height
        width:sin_g2.width
        color: "transparent"
        Image {
            id:sin_g2
            width: 270
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/mapscale.png"
        }
    }
}
    }
}
