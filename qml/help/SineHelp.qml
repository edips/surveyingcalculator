import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Sine Theori"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id: optionsColumn
    STextHelp{
            stext:qsTr("In trigonometry, sine law is an equation relating the lengths of the sides of a triangle (any shape) to the sines of
its angles. According to the law,")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g.height
        width:sin_g.width
        color: "transparent"
        Image {
            id:sin_g
            height: 55
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/sine/sine_genel.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g2.height
        width:sin_g2.width
        color: "transparent"
        Image {
            id:sin_g2
            height: 150
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/sine/sinelaw.png"
        }
    }
    STextHelp{
            stext:qsTr("Uses the law of sines to calculate unknown angles or sides of a triangle. In order to calculate the unknown values you must enter 3 known values.")
    }
    STextHelp{
            stext:qsTr("Calculate Angle α")
    }
    STextHelp{
            stext:qsTr("To calculate angle α enter the opposite side a then another angle-side pair b and β.")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:geri.height
        width:geri.width
        color: "transparent"
        Image {
            id:geri
            height: 65
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/sine_alpha.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin1_img.height
        width:sin1_img.width
        color: "transparent"
        Image {
            id:sin1_img
            height: 150
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/sine1.png"
        }
    }
// calculate a side:
    STextHelp{
            stext:qsTr("Calculate Side a")
    }
    STextHelp{
            stext:qsTr("To calculate side a enter the opposite angle α then another angle-side pair b and β.")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:ger2.height
        width:ger2.width
        color: "transparent"
        Image {
            id:ger2
            height: 65
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/sine_a_side.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin2_img.height
        width:sin2_img.width
        color: "transparent"
        Image {
            id:sin2_img
            height: 150
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/sine2.png"
        }
    }
}
    }
}
