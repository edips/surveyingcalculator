import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../../components/common/script.js" as JS
import "../../../components/common"
import "areaCalc.js" as Calc
import "../../../components/gis"
Item{
    property var my_arr : []
    property int cogo_count: 0
    Settings{
        id:dist_settings
        property alias areaxttext : editor.text
        property alias unitindex_Area : areacombo.currentIndex
        property alias area_result : area.text
    }

    // Coordinate select from map dialog
    Loader {
        id: loadComponent
        anchors.fill: parent
        active: false
        sourceComponent: macomponent
    }
    // Coordinate select from map dialog
    Component.onDestruction: loadComponent.active = false
    Component {
        id: macomponent
        CoordSelect {
            id: mapDialog
            error_txt: xy_feature_error
            onClosed: {
                if( selected && coordName === "editor" ) {
                    editor.text += xCoord + " " + yCoord + "\n"
                    selected = false
                }
            }
        }
    }

    SFlickable {
        id:optionsPage
        contentHeight: Math.max(macolumn.implicitHeight+65, height)
        anchors.topMargin: 15
        Column{
            id:macolumn
            width: parent.width
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            NEHeader {}
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width:  275
                    height:  250
                    color:"transparent"
                    Flickable {
                        id: flickable
                        anchors.fill: parent
                        flickableDirection: Flickable.VerticalFlick
                        contentWidth: parent.width
                        contentHeight: editor.height
                        clip: true
                        Column {
                            id: lineNumber
                            spacing: 0
                            Repeater {
                                id: lineNumberRepeater
                                model: editor.lineCount
                                STextTop {
                                    text: index + 1
                                    font.pixelSize: 19
                                    color: "gray"
                                }
                            }
                        }
                        TextArea.flickable: TextArea {
                            id: editor
                            placeholderText: "Enter the coordinates"
                            wrapMode: TextEdit.WrapAnywhere
                            selectByMouse: true
                            topPadding: 0
                            leftPadding: 10
                            inputMethodHints:  JS.keyboard_display()
                            font.pixelSize: 19
                            anchors.left: lineNumber.right
                        }
                        ScrollBar.vertical: ScrollBar { }
                    }
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 45
                Button {
                    id:hesaplak
                    width: 50
                    Image {
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        width: 40
                        source: "qrc:/assets/images/equal.png"
                    }
                    highlighted: true
                    onClicked: {
                        Calc.calc();
                    }
                }
                Button {
                    id:c
                    width: 40
                    icon.source: "qrc:/assets/icons/material/content/clear.svg"
                    onClicked: area.text = editor.text = ""
                }
                Button {
                    id: btn_map
                    icon.source: "qrc:/assets/icons/material/maps/map.svg"
                    onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "editor"
                        loadComponent.item.open()
                    }
                }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:5
                SText {text: "Area: "; }
                STextField{id:area; readOnly:true}
                CustomComboBox {
                    id: areacombo
                    height: area.height
                    currentIndex: 0
                    implicitWidth:80
                    model: ListModel {
                        id: model
                        ListElement { text: qsTr("m²") }
                        ListElement { text: qsTr("km²") }
                        ListElement { text: qsTr("ha") }
                        ListElement { text: qsTr("acre") }
                        ListElement { text: qsTr("mi²") }
                        ListElement { text: qsTr("yd²") }
                        ListElement { text: qsTr("ft²") }
                    }
                    onCurrentIndexChanged: Calc.unitcalc();
                }
            }
        }

    }
}
