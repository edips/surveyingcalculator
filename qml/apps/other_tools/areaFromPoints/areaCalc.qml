/***************************************************************************
  Copyright            : (C) 2021 by Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

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
Item {
    property var my_arr : []
    Settings{
        id:dist_settings
        property alias areaxttext : editor.text
        property alias unitindex_Area : areacombo.currentIndex
        property alias area_result : area.text
        property alias perim_txt: perimeter.text
        property alias perimCombo: perim_combo.currentIndex
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
        Column {
            id:macolumn
            width: parent.width
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            NEHeader {}

            Row{
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
                                    color: 'gray'
                                    font.pixelSize: 17
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
                            inputMethodHints: JS.keyboard_display()
                            font.pixelSize: 17
                            anchors.left: lineNumber.right
                        }
                        ScrollBar.vertical: ScrollBar { }
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:50

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
                        Calc.result();
                        canvas.visible = true
                    }
                }

                Button {
                    id:c
                    width: 40
                    icon.source: "qrc:/assets/icons/material/content/clear.svg"
                    onClicked: {
                        area.text = editor.text = perimeter.text = ""
                        var ctx = canvas.getContext("2d");
                        ctx.reset();
                        canvas.visible = false
                    }
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

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:5
                SText {text: "Area: "; font.pixelSize: 16; height: area.height; }
                STextField{id:area; readOnly:true}
                ComboBox {
                    id: areacombo
                    currentIndex: 0
                    implicitWidth: 80
                    height: area.height
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
                    onCurrentIndexChanged: {
                        Calc.areaByUnits();
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:5
                SText{ text: "Perimeter: "; font.pixelSize: 16; height: perimeter.height }
                STextField{ id: perimeter; readOnly:true; width: 100; }
                ComboBox {
                    id: perim_combo
                    currentIndex: 0
                    implicitWidth: 80
                    height: perimeter.height
                    model: ListModel {
                        ListElement { text: qsTr("m") }
                        ListElement { text: qsTr("km") }
                        ListElement { text: qsTr("mi") }
                        ListElement { text: qsTr("yd") }
                        ListElement { text: qsTr("ft") }
                    }
                    onCurrentIndexChanged: {
                        Calc.perimByUnits();
                    }
                }
            }

            // Print the area
            Canvas {
                id: canvas
                visible: false
                width: parent.width > 600 ? 580 : parent.width - 15
                height: width  + 150
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
