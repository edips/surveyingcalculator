import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Forward Intersection"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    STextHelp{
            stext:qsTr("The app calculates the third point on a triangle where the coordinates of points P1, P2 and angles  α, β are known.
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang2.height
        width:ang2.width
        color: "transparent"
        Image {
            id:ang2
            width: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/onden.png"
        }
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang.height
        width:ang.width
        color: "transparent"
        Image {
            id:ang
            width: 310
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/forward.png"
        }
    }


}
    }
}
