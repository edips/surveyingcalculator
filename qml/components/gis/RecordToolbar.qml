import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../../components/common/script.js" as Util
import "../../components/common"
import QgsQuick 0.1 as QgsQuick
import lc 1.0

Item {
    signal addClicked
    signal manualRecordingClicked
    signal stopRecordingClicked
    signal removePointClicked
    signal close
    signal layerLabelClicked

    property int extraPanelHeight: 64 * QgsQuick.Utils.dp * 0.6
    property bool pointLayerSelected: true
    property bool manualRecordig: false
    property bool extraPanelVisible: true

    property int activeLayerIndex: -1

    property QgsQuick.VectorLayer activeVectorLayer: __activeLayer.vectorLayer
    property string activeLayerName: activeVectorLayer ? activeVectorLayer.name : ""
    property string activeLayerIcon: __loader.loadIconFromLayer( activeVectorLayer )


    id: root
    onClose: visible = false
    // Active layer panel and chooser-----------------------------------------
    Button {
        id: extraPanel
        width: parent.width
        height: 40
        highlighted: true

        visible: extraPanelVisible
        anchors.top: parent.top

        onClicked: {
            layerLabelClicked()
        }
        Row{
            anchors.left: extraPanel.left
            leftPadding: 10

            Label {
                id: label_txt
                height: extraPanel.height
                text: "Active Layer: "
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "white"
            }

            Item {
                id: iconContainer
                height: extraPanelHeight
                width: extraPanelHeight
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: icon
                    anchors.fill: parent
                    anchors.margins: extraPanelHeight/4
                    sourceSize.width: width
                    sourceSize.height: height
                    source: root.activeLayerIcon
                    fillMode: Image.PreserveAspectFit
                }
            }
            Label {
                id: label_layer
                height: extraPanel.height
                text: root.activeLayerName
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "white"
            }
        }
    }
}
