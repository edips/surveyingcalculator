import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Circle by 3 Points"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sin_g2.height
        width:sin_g2.width
        color: "transparent"
        Image {
            id:sin_g2
            width: 200
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/circle.png"
        }
    }
    STextHelp{
            stext:qsTr("
Center Point (Nc, Ec);")
    }

    Flickable {
        anchors.left: parent.left
        width: parent.width; height: sins2d.height
        contentWidth: sins2d.width+20; contentHeight: sins2d.height
        Image {
            id:sins2d
            height: 64
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/circle/nc.png"
        }
    }

    Flickable {
        anchors.left: parent.left
        width: parent.width; height: sinsd.height
        contentWidth: sinsd.width+20; contentHeight: sinsd.height
        Image {
            id:sinsd
            height: 64
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/circle/ec.png"
        }
    }
    Rectangle{
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        height:kj2.height
        width:kj2.width
        color: "transparent"
        Image {
            id:kj2
            height: 38
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/circle/radius.png"
        }
    }
//-----------------------------------------------------------


}
    }
}
