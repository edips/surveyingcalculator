import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../components/common"
import "../../components/common/script.js" as Util
FluidControls.Page {
    id: frame11
    title:qsTr("Basic Surveying")
    z: 2
    SFlickable {
        id:options
        contentHeight: Math.max(malist2.implicitHeight, height)

        Column{
            id:optionsC
            width: parent.width
            height: parent.height
            anchors.topMargin    : 15
            anchors.bottomMargin : 15
            anchors.leftMargin :15
            anchors.rightMargin  : 15
            Rectangle{
                height: parent.height
                color: "transparent"
                width: parent.width
                ListView {
                    id:malist2
                    boundsBehavior: Flickable.StopAtBounds
                    width: parent.width
                    height: parent.height
                    focus: true
                    interactive: true
                    clip: true
                    model: ListModel {
                        ListElement { title: qsTr("Calculate X,Y"); source: "basic_first/First2.qml"; imgsrc:"qrc:/assets/images/first.png" }
                        ListElement { title: qsTr("Distance, Azimuth"); source: "basic_second/Second2.qml"; imgsrc:"qrc:/assets/images/second.png" }
                        ListElement { title: qsTr("Azimuth Calculation"); source: "basic_third/Third2.qml"; imgsrc:"qrc:/assets/images/third.png" }
                        ListElement { title: qsTr("Interior Angle"); source: "basic_four/Four2.qml"; imgsrc:"qrc:/assets/images/four.png" }
                        ListElement { title: qsTr("Calculate Lat,Lon"); source: "latlong_calc/latlongcalc2.qml"; imgsrc:"qrc:/assets/icons/latlong_calc.png" }
                    }
                    delegate: FluidControls.ListItem {
                        height:70
                        Row{
                            anchors.verticalCenter: parent.verticalCenter
                            Rectangle{
                                id:maimg
                                Layout.alignment: Qt.AlignHCenter
                                height:60
                                width:60
                                //color: "#a0c5a6"
                                color:"transparent"

                                Image {
                                    id: img
                                    source:model.imgsrc
                                    anchors.fill: parent
                                }
                            }
                            SText {
                                text: model.title
                                font.pixelSize: 15
                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: 10
                                font.family: windoww.font
                                font.bold: false
                            }

                        }
                        onClicked: pageStack.push(model.source, {}, StackView.Immediate)
                    }
                    ScrollIndicator.vertical: ScrollIndicator {}
                }

            }
        }

    }
}

