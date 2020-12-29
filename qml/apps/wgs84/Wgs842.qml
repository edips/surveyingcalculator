import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.3
import "../../components/common"
import "wgs84.js" as Hesap
import "../../components/common/script.js" as Script
FluidControls.Page{
    title:qsTr("WGS84 Lat/Long-UTM Converter")
    appBar.maxActionCount: 2
    id:wgscalc
    property int counter_wgs_settings;

    Component.onCompleted: {
        if(counter_wgs_settings===0){
            settingsDialog_wgs.visible=true
        }forceActiveFocus()
        counter_wgs_settings = 1;
    }
    Settings{
        id:wgssetting
        property alias wgsChecked2: wgscalc.wgs_count
        property alias northcombo:hemisphere.currentIndex
        property alias settings_dialog_wgs: wgscalc.counter_wgs_settings
    }
    FluidControls.AlertDialog {
        id: settingsDialog_wgs
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width
        height: mayrow22.height*4 + 70
        title: qsTr("Settings")
        Flickable{
            id:settings_flickable
            Column{
                id:settings_column
                spacing: 25

                RowLayout{
                    id:mayrow22
                    spacing: 15
                    SText{
                        text:qsTr("Hemisphere:  ")
                    }
                    CustomComboBox {
                        id: hemisphere
                        width: 100
                        currentIndex: 0

                        model: ListModel {
                            id: model9
                            ListElement { text: qsTr("North") }
                            ListElement { text: qsTr("South") }
                        }
                    }
                }
                // Switch to display Grid Zone Designation beside UTM zone
                RowLayout{
                    Switch{
                        id: zone_designator
                        checked: __appSettings.gridZone
                        onCheckedChanged: __appSettings.gridZone = checked
                        text: "Grid Zone Designator Alpha Code"
                    }
                }
            }

        }
    }
    Loader{
        id: wgs_loader
        source: "Wgs84.qml"
        anchors.fill: parent
    }
    property int wgs_count: 0
    property int wgs_count2: 0
    actions: [
        // GPS Button
        FluidControls.Action {
            id: start_gps
            //text: qsTr("Get GPS Coordinates")
            toolTip: qsTr("Get GPS Coordinates")
            icon.source: Hesap.startgps(SharedWGS84.mycount) ? "qrc:/assets/icons/material/av/pause.svg" : "qrc:/assets/icons/material/maps/my_location.svg"
            onTriggered:{
                SharedWGS84.mycount++
            }
        },
        FluidControls.Action {
            id:setAction
            toolTip: qsTr("Settings")
            icon.source: "qrc:/assets/icons/material/action/settings.svg"
            onTriggered:{
                settingsDialog_wgs.forceActiveFocus()
                settingsDialog_wgs.open()
            }
        }

        /*,
        FluidControls.Action {
          id:wgs_action2
           onTriggered:{
                  wgs_count2++
                  wgs_loader.source=JS.wgs_help()
              }

            icon.source: FluidControls.Utils.iconUrl(JS.wgs_helpicon())
            toolTip: qsTr("Help")
        }*/
    ]
}
