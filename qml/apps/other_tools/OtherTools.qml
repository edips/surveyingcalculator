import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0
import Fluid.Layouts 1.0 as FluidLayouts
import QtQuick.Layouts 1.3
import "../../components/common"
import "../../components/common/script.js" as Util
Page {
    id: frame11
    //anchors.fill: parent
    title:qsTr("Other Tools")
    z: 2
SFlickable {
    id:options
    anchors.topMargin: 10
    leftMargin: 2
    contentHeight: Math.max(malist.implicitHeight, height)

    FluidLayouts.AutomaticGrid {
            id: malist
            anchors.fill: parent
            cellWidth: 110
            cellHeight: 130
            model: ListModel {
                ListElement { title: qsTr("Area from X,Y"); source: "areaFromPoints/areaCalc2.qml" ; imgsrc:"qrc:/assets/icons/areaXY.png" }
                ListElement { title: qsTr("2D Helmert Transform"); source: "helmert/Helmert2.qml"; imgsrc:"qrc:/assets/icons/helmert.png"  }
                ListElement { title: qsTr("Horizontal Curve"); source: "hz_curve/RoadCalc2.qml"; imgsrc:"qrc:/assets/images/karayolu.png" }
                ListElement { title: qsTr("Angle Conversion"); source: "angle/Angle_convert2.qml"; imgsrc:"qrc:/assets/icons/angle_conversion.png"  }
                ListElement { title: qsTr("Map Scale Calculator"); source: "mapscale/MapScale2.qml" ; imgsrc:"qrc:/assets/icons/map_scale.png" }
            }
            delegate: ListItem {
                width: 110
                height: 130
                Rectangle{
                    height:130
                    width:110
                    id:rootrect
                    color:"transparent"
                    anchors.verticalCenter: parent.verticalCenter
                ColumnLayout{
                    anchors.fill: parent
                    spacing: 2
                Rectangle{
                    id:maimg
                    Layout.alignment: Qt.AlignHCenter
                    height:70
                    width:70
                    color:"transparent"

                Image {
                      id: img
                      source:model.imgsrc
                      anchors.fill: parent
                   }
                }
                Rectangle{
                    id:matext
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    width:110
                    height: 60
                    color: "transparent"
                STextGrid {
                    id:label
                    font.pixelSize: 16
                }

                    }
                }
                }
                onClicked: pageStack.push(model.source, {}, StackView.Immediate)
            }
    }

}
}
