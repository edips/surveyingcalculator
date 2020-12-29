import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Linear Interpolation"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn

    STextHelp{
            stext:qsTr("Linear interpolation is a method of curve fitting using linear polynomials to construct new data points
 within the range of a discrete set of known data points. If the two known points are given by
the coordinates <b>(N1,E1)</b> and <b>(N2,E2)</b>, the linear interpolant is the straight line between these points.
For a value <b>E</b> in the interval <b>(E1,E2)</b>, the value <b>N</b> along the straight line is given from the equation of slopes:
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang.height
        width:ang.width
        color: "transparent"
        Image {
            id:ang
            width: 180
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/linear.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang2.height
        width:ang2.width
        color: "transparent"
        Image {
            id:ang2
            height: 50
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/linear/l1.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang22.height
        width:ang22.width
        color: "transparent"
        Image {
            id:ang22
            height:50
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/linear/l2.png"
        }
    }
    //Solving this equation for y
    STextHelp{
            stext:qsTr("Solving this equation for <b>E</b>:")
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ang23.height
        width:ang23.width
        color: "transparent"
        Image {
            id:ang23
            height: 50
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/linear/l3.png"
        }
    }




}
    }
}
