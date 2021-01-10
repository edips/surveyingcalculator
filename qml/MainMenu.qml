import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Fluid.Layouts 1.0 as FluidLayouts
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import "components/common"
import "components/common/script.js" as Util

SFlickable {
    id:optionsPage
    anchors {
        topMargin: 10
        leftMargin: 2
    }
    contentHeight: Math.max(malist.implicitHeight, height)
    z: 2
    Rectangle{
        width: parent.width
        anchors.centerIn: parent
        height: parent.height
        color: "transparent"

        FluidLayouts.AutomaticGrid {
            id: malist
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            rowSpacing: 5
            cellWidth: 110
            cellHeight: 140
            model: ListModel {
                ListElement { title: qsTr("Project Manager"); source: "apps_qgis/ProjectManager/ProjectManager.qml"; imgsrc:"qrc:/assets/icons/projects.svg" }
                ListElement { title: qsTr("Survey"); source: "apps_qgis/data_collector/DataCollector.qml"; imgsrc:"qrc:/assets/icons/point_data_collector.svg" }

                //ListElement { title: qsTr("Map Viewer"); source: "apps_qgis/mapviewer/MapViewer2.qml"; imgsrc:"qrc:/assets/icons/mapviewer.png" }
                ListElement { title: qsTr("Distance, Bearing"); source: "apps/basic_surveying/BasicSurveying.qml" ; imgsrc:"qrc:/assets/icons/basic_surveying.svg" }
                ListElement { title: qsTr("Intersection Methods"); source: "apps/intersection/Intersection.qml" ; imgsrc:"qrc:/assets/icons/intersection.png" }
                ListElement { title: qsTr("Lat/Long UTM"); source: "apps/wgs84/Wgs842.qml" ; imgsrc:"qrc:/assets/icons/utm_latlon.png" }
                ListElement { title: qsTr("Degree Decimal"); source: "apps/other_tools/deg2dec/Degree2decimal2.qml" ; imgsrc:"qrc:/assets/icons/degree_decimal.png" }
                ListElement { title: qsTr("UTM Map"); source: "apps/other_tools/mylocation/Maps2.qml"; imgsrc:"qrc:/assets/icons/mylocation.png"  }
                ListElement { title: qsTr("Generate Coordinates"); source: "apps_qgis/coordinate_generator/CoordinateGenerator.qml"; imgsrc:"qrc:/assets/icons/generator.png" }
                ListElement { title: qsTr("Coordinate Converter"); source: "apps/coordinate_converter/CoordinateConverter2.qml" ; imgsrc:"qrc:/assets/icons/coord_convert.png" }
                ListElement { title: qsTr("Other Tools"); source: "apps/other_tools/OtherTools.qml"; imgsrc:"qrc:/assets/icons/others.png" }
            }

            delegate: FluidControls.ListItem {
                width: 110
                height: parent.cellHeight
                Rectangle{
                    height:parent.height
                    width:110
                    id:rootrect
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    ColumnLayout{
                        width: parent.width
                        height: parent.height-20
                        Layout.alignment: Qt.AlignVCenter
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
                                sourceSize.width: 70
                                sourceSize.height: 70
                                //anchors.fill: parent
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
                onClicked:{
                    pageStack.push(model.source, {}, StackView.Immediate)
                }
            }
        }
    }
}
