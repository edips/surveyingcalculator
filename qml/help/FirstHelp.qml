import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    id: first_help
    title: "Calculation of X,Y"

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
            width:170
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/first.png"
        }
    }
    STextHelp{
            stext:qsTr("If coordinates of <b>A</b> point, <b>(AB)</b> angle and <b>|AB|</b> length are known, coordinates of <b>B</b> can be calculated:
")
    }


    Rectangle{
        anchors.left: parent.left
        height:ang.height
        width:ang.width
        color: "transparent"
        Image {
            id:ang
            height: 70
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/basicsurvey/first.png"
        }
    }


}
    }
}
