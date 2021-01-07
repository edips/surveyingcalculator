import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "script.js" as Script

/*
This component is used for XY coordinates with coordinate name side by side like that:
X1: ____    Y1: ____
X2: ____    Y2: ____
*/

Item {
    id: ne_root
    height: grid_utm.height
    width: parent.width

    property string name;
    property int neWidth: 2*north.width + 2*mat2.width
    // Properties Decimal
    property alias northing : north
    property alias easting : east
    property alias elev: kot
    property alias zones: zone

    property bool utm_exists: false
    property bool readonly : false
    property bool z_enabled: false

    // for settings
    property alias north_txt: north.text
    property alias east_txt: east.text
    property alias zone_txt: zone.text
    property alias elev_txt: kot.text


    property string z_txt: "Z: "
    property string n_txt: Script.textN() + ": "
    property string e_txt: Script.textE() + ": "

    Rectangle {
        height: utm_exists ? 100 : 50
        width: neWidth
        color: "transparent"
        id:grid_utm
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: main_column
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10

            Row{
                id: ne_row
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Row{
                    layoutDirection: Script.coord_display()
                    spacing: z_enabled ? 5 : 10
                    // Easting
                    Row{
                        Label {
                            id:mateee2;
                            text: e_txt;
                            verticalAlignment:
                                Text.AlignVCenter; height: parent.height;
                            font.pixelSize: z_enabled ? 13 : 15
                        }
                        STextField{id:east;
                            width: z_enabled ? 90 : 110;
                            readOnly: ne_root.readonly;
                            font.pixelSize: z_enabled ? 15 : 16;
                        }
                    }
                    // Northing
                    Row{
                        Label {
                            id:mat2;
                            text: n_txt;
                            verticalAlignment: Text.AlignVCenter;
                            height: parent.height;
                            font.pixelSize: z_enabled ? 13 : 15
                        }
                        STextField {
                            id: north;
                            width: z_enabled ? 90 : 110;
                            readOnly: ne_root.readonly;
                            font.pixelSize: z_enabled ? 15 : 16;
                        }
                    }
                }
                Row{
                    visible: z_enabled
                    Label {
                        id: z_label
                        text: z_txt
                        verticalAlignment: Text.AlignVCenter
                        height: parent.height
                        font.pixelSize: z_enabled ? 13 : 15
                    }
                    STextField{
                        id: kot
                        width: 55
                        font.pixelSize: z_enabled ? 15 : 16
                    }
                }
            }

            Row {
                visible: utm_exists
                anchors.horizontalCenter: parent.horizontalCenter
                rightPadding: 50;
                spacing:5
                Label { font.pixelSize: 14;
                    text: qsTr("UTM Zone: ");
                    font.bold: true;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height
                }
                STextField{
                    id:zone;
                    readOnly:ne_root.readonly;
                    width: 50;
                    font.pixelSize: 16
                }
            }
        }
    }
}
