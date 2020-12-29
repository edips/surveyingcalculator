import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Cosine Theori"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    //The law of cosines is useful for computing the angles of a triangle if all three sides are known.
    STextHelp{
       stext:qsTr("The law of cosines is useful for computing the angles of a triangle if all three sides are known.")
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
            source:"qrc:/assets/images/cosinus.png"
        }
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g.height
        width:sin_g.width
        color: "transparent"
        Image {
            id:sin_g
            height: 120
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/cosine/cosine.png"
        }
    }

    STextHelp{
        stext:qsTr("In order to calculate angles it can be in either of these forms:")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin2_img.height
        width:sin2_img.width
        color: "transparent"
        Image {
            id:sin2_img
            height: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/cosine/cosine_img.png"
        }
    }
}
    }
}
