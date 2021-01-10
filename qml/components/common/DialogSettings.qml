import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Universal 2.12
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
import "script.js" as Js
import "../../"
import lc 1.0
// Settings dialog
TopSheet {
    title: "Settings"

    id: settingsDialog
    //topPadding: banner2.visible ? banner2.height : 0
    closePolicy: QQC2.Popup.CloseOnEscape | QQC2.Popup.CloseOnPressOutside
    // settings_page to open dialog
    property alias settingsPage: settingsDialog
    focus: true

    SFlickable {
        id:settings_flickable
        topMargin: 10
        anchors.top: settingsDialog.toolbar.bottom
        contentHeight: settings_column.implicitHeight
        anchors.margins: 10
        ColumnLayout{
            id:settings_column
            spacing: 20

            // Units
            ColumnLayout {
                spacing: 10
                SText{
                    text:qsTr("Units")
                    font.pixelSize: 16
                    font.bold: true
                }
                Rectangle{
                    width: windoww.width
                    height: 1
                    color: __appSettings.theme === 0 ? "#d5d5c3" : "#505050"
                }
            }

            // Distance unit chooser
            RowLayout {
                SText{
                    text:qsTr("Distance Unit: ")
                }
                CustomComboBox {
                    id: distance_chooser
                    implicitWidth: 150
                    currentIndex: __appSettings.lenUnit
                    onCurrentIndexChanged: __appSettings.lenUnit = currentIndex
                    model: ListModel {
                        ListElement { text: qsTr("meter") }
                        ListElement { text: qsTr("kilometer") }
                        ListElement { text: qsTr("mile") }
                        ListElement { text: qsTr("nautical mile") }
                        ListElement { text: qsTr("yard") }
                        ListElement { text: qsTr("feet") }
                    }
                }
            }
            // Ange unit chooser
            RowLayout {
                SText{
                    text:qsTr("Angle Unit: ")
                    font.bold: false
                }
                CustomComboBox {
                    id: angle_chooser
                    implicitWidth: 200
                    currentIndex: __appSettings.angleUnit
                    onCurrentIndexChanged: __appSettings.angleUnit = currentIndex
                    model: ListModel {
                        ListElement { text: qsTr("Degree Decimal") }
                        ListElement { text: qsTr("Degree DMS") }
                        ListElement { text: qsTr("Grad (Gon)") }
                    }
                }
            }
            // Coordinate Settings
            ColumnLayout {
                spacing: 10
                Rectangle{
                    width: windoww.width
                    height: 1
                    color: __appSettings.theme === 0 ? "#d5d5c3" : "#505050"
                }
                SText{
                    id:coord_display_txt
                    text:qsTr( "Coordinate Settings" )
                    font.pixelSize: 16
                    font.bold: true
                }
                Rectangle{
                    width: windoww.width
                    height: 1
                    color: __appSettings.theme === 0 ? "#d5d5c3" : "#505050"
                }
            }
            // Display of Latitude and Longitude
            QQC2.Button{
                implicitWidth: settingsDialog.width
                implicitHeight: 80
                flat: true
                contentItem: ColumnLayout{
                    SText{
                        font.pixelSize: 15
                        text:qsTr(" Latitude and Longitude Display")
                        font.bold: true
                    }
                    SText{
                        text:{
                            rd_lat_dec.checked ? "Decimal" : "Degree Minute Second"
                        }
                        font.bold: false
                        font.italic: true
                        color: __appSettings.theme === 0 ? "gray" : "#BDBDBD"
                    }
                }
                onClicked: latlon_display_dialog.open()
            }

            // Fornmat of Latitude and Longitude
            QQC2.Button{
                implicitWidth: settingsDialog.width
                implicitHeight: 80
                flat: true
                contentItem: ColumnLayout{
                    SText{
                        font.pixelSize: 15
                        text:qsTr("Latitude and Longitude Format")
                        font.bold: true
                    }
                    SText{
                        text:{
                            rd_lat_format1.checked ? rd_lat_format1.text : rd_lat_format2.text
                        }
                        font.bold: false
                        font.italic: true
                        color: __appSettings.theme === 0 ? "gray" : "#BDBDBD"
                    }
                }
                onClicked: latlon_format_dialog.open()
            }
            // Order of Latitude and Longitude
            QQC2.Button {
                implicitWidth: settingsDialog.width
                implicitHeight: 80
                flat: true
                contentItem: ColumnLayout{
                    SText{
                        id: order_text
                        font.pixelSize: 15
                        text:qsTr("Latitude and Longitude Order")
                        font.bold: true
                    }
                    SText{
                        text:rd_lat1.checked ? rd_lat1.text : rd_lat2.text
                        font.bold: false
                        font.italic: true
                        color: __appSettings.theme === 0 ? "gray" : "#BDBDBD"
                    }
                }
                onClicked: latlon_dialog.open()
            }
            // Order of Northing and Easting
            QQC2.Button {
                id: coordinate_display
                implicitWidth: settingsDialog.width
                implicitHeight: 80
                flat: true
                contentItem: ColumnLayout{
                    SText{
                        font.pixelSize: 15
                        text:qsTr("Northing and Easting Order")
                        font.bold: true
                    }
                    SText{
                        id: latlon_order_txt
                        text:rd_NE_order.checked ? "Northing before Easting" : "Easting before Northing"
                        font.bold: false
                        font.italic: true
                        color: __appSettings.theme === 0 ? "gray" : "#BDBDBD"
                    }
                }
                onClicked: xy_order_dialog.open()
            }


            // Display of North and East
            ColumnLayout {
                SText {
                    font.pixelSize: 15
                    text:qsTr("X,Y Display")
                    font.bold: true
                    leftPadding: 5
                }

                RowLayout {
                    spacing: 15
                    Row{
                        SText{
                            text:qsTr("North:  ")
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }
                        CustomComboBox {
                            id: north_combo
                            width: 70
                            currentIndex: __appSettings.xyDisplay

                            model: ListModel {
                                id: model9
                                ListElement { text: qsTr("N") }
                                ListElement { text: qsTr("X") }
                                ListElement { text: qsTr("Y") }
                            }
                            onCurrentIndexChanged: {
                                __appSettings.xyDisplay = currentIndex
                            }
                        }
                    }
                    RowLayout{
                        visible: Js.vizN()
                        SText{
                            text:qsTr("East:  ")
                            font.bold: false
                        }
                        SText {
                            anchors.margins: 1
                            text: qsTr("E")
                            font.bold: false
                        }
                    }
                    RowLayout{
                        visible: Js.vizX()
                        SText{
                            text:qsTr("East:  ")
                            font.bold: false
                        }
                        SText {
                            anchors.margins: 1
                            text: qsTr("Y")
                            font.bold: false
                        }
                    }
                    RowLayout{
                        visible: Js.vizY()
                        SText{
                            text:qsTr("East:  ")
                            font.bold: false
                        }
                        SText {
                            anchors.margins: 1
                            text: qsTr("X")
                            font.bold: false
                        }
                    }
                }
            }
            // General settings
            ColumnLayout {
                spacing: 10
                Rectangle{
                    width: windoww.width
                    height: 1
                    color: __appSettings.theme === 0 ? "#d5d5c3" : "#505050"
                }
                SText {
                    text:qsTr("General")
                    font.pixelSize: 16
                    font.bold: true

                }
                Rectangle{
                    width: windoww.width
                    height: 1
                    color: __appSettings.theme === 0 ? "#d5d5c3" : "#505050"
                }
            }
            // Keyboard settings
            RowLayout{
                SText{
                    text:qsTr("Keyboard: ")
                    font.bold: false
                }
                CustomComboBox {
                    id: keyboard_settings
                    implicitWidth: 150
                    currentIndex: __appSettings.keyboard
                    model: ListModel {
                        id: keyboard_model
                        ListElement { text: qsTr("Numeric") }
                        ListElement { text: qsTr("Alphanumeric") }
                    }
                    onCurrentIndexChanged: __appSettings.keyboard = currentIndex
                }
            }
            // Theme
            RowLayout{
                SText{
                    text:qsTr("Theme: ")
                    font.bold: false
                }
                CustomComboBox {
                    implicitWidth: 150
                    currentIndex: __appSettings.theme
                    model: ListModel {
                        ListElement { text: qsTr("Light") }
                        ListElement { text: qsTr("Dark") }
                    }
                    onCurrentIndexChanged: __appSettings.theme = currentIndex
                }
            }

            // Space
            Rectangle {
                height: 100
                color: "transparent"
            }
        }
    }

    // Latitude LOngitude order dialog
    QQC2.Dialog {
        id:latlon_dialog
        title: "Latitude and Longitude Order"
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width
        Column {
            QQC2.RadioButton {
                id:rd_lat1
                text: qsTr("Latitude before Longitude")
                checked: __appSettings.latlongOrder === "order_latlong"
                onClicked: {
                    __appSettings.latlongOrder = "order_latlong"
                    latlon_dialog.close()
                }
            }
            QQC2.RadioButton {
                id:rd_lat2
                text: qsTr("Longitude before Latitude")
                checked: __appSettings.latlongOrder === "order_longlat"
                onClicked: {
                    __appSettings.latlongOrder = "order_longlat"
                    latlon_dialog.close()
                }
            }
        }
    }

    // Order of Northing and Easting
    QQC2.Dialog {
        id:xy_order_dialog
        title: "Northing and Easting Order"
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width
        Column{
            QQC2.RadioButton{
                id:rd_EN_order
                text: qsTr("Easting before Northing")
                checked: __appSettings.xyOrder === "en"
                onClicked: {
                    __appSettings.xyOrder = "en"
                    xy_order_dialog.close()
                }
            }
            QQC2.RadioButton{
                id:rd_NE_order
                text: qsTr("Northing before Easting")
                checked: __appSettings.xyOrder === "ne"
                onClicked: {
                    __appSettings.xyOrder = "ne"
                    xy_order_dialog.close()
                }
            }
        }
    }

    // Display of Latitude and Longitude Dialog
    QQC2.Dialog {
        id:latlon_display_dialog
        title: "Display of Latitude and Longitude coordinates"
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width
        Column{
            QQC2.RadioButton{
                id:rd_lat_dec
                text: qsTr("Decimal")
                checked: __appSettings.latlongDisplay === "display_dec"
                onClicked: {
                    __appSettings.latlongDisplay = "display_dec"
                    latlon_display_dialog.close()
                }
            }
            QQC2.RadioButton{
                id:rd_lat_dms
                text: qsTr("Degree Minute Second")
                checked: __appSettings.latlongDisplay === "display_dms"
                onClicked: {
                    __appSettings.latlongDisplay = "display_dms"
                    latlon_display_dialog.close()
                }
            }
        }
    }

    // Display of Latitude and Longitude Dialog
    QQC2.Dialog {
        id:latlon_format_dialog
        title: "Latitude and Longitude Format"
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width
        Column{
            QQC2.RadioButton{
                id:rd_lat_format1
                text: qsTr("Include direction (N, E, S, W)")
                checked: __appSettings.latlongFormat === "format_included"
                onClicked: {
                    __appSettings.latlongFormat = "format_included"
                    latlon_format_dialog.close()
                }
            }
            QQC2.RadioButton{
                id:rd_lat_format2
                text: qsTr("Without suffix")
                checked: __appSettings.latlongFormat === "format_notincluded"
                onClicked: {
                    __appSettings.latlongFormat = "format_notincluded"
                    latlon_format_dialog.close()
                }
            }
        }
    }
}
