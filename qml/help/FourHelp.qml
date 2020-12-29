import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    id: four_help
    title: "Interior Angle"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang2.height
        width:ang2.width
        color: "transparent"
        Image {
            id:ang2
            width:200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/third.png"
        }
    }
    STextHelp{
            stext:qsTr("If <b>A,B</b> and <b>C</b> coordinates are known <b>(ABC)</b> interior angle can be calculated with <b>(BA)</b> and <b>(BC)</b> azimuth angles.
 For more information about azimuth calculation, you can see help page in 'Distance, Azimuth' app.<br><br>
<b>(ABC) = (BA) - (BC)</b>
")
    }
}
    }
}
