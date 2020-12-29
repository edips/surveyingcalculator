import QtQuick 2.10
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0 as FluidControls
import lc 1.0
import "../../components/common"


FluidControls.AlertDialog {
    id: settingsDialog
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: parent.width
    height: scaleRow.height*4
    title: qsTr("Settings")
    Flickable{
        id:settings_flickable
        Column{
            id:settings_column
            spacing: 15
            // Scalebar Units
            RowLayout{
                id: scaleRow
                SText{
                    text:qsTr("Scale bar unit: ")
                    color: "black"
                    font.bold: false
                }
                CustomComboBox {
                    id: scale_unit
                    implicitWidth: 200
                    currentIndex: __appSettings.scaleUnit
                    model: ListModel {
                        ListElement { text: qsTr("Metric") }
                        ListElement { text: qsTr("Imperial") }
                    }
                    onCurrentIndexChanged: __appSettings.scaleUnit = currentIndex
                }
            }
        }
        
    }
}
