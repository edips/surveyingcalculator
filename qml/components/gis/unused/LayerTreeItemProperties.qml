import QtQuick 2.4
import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.qgis 1.0
import org.qfield 1.0
Popup {
    property alias itemVisible: itemVisibleCheckBox.checked

    Page {
        header: Label {
            text: title
            font.pointSize: 14
        }

        CheckBox {
            id: itemVisibleCheckBox
            text: qsTr("Show on map canvas")
            font.pointSize: 14
        }
    }
    property var layerTree
    property var index

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    onIndexChanged: {
      itemVisible = layerTree.data(index, LayerTreeModel.Visible)
      title = qsTr("%1 : Properties").arg(layerTree.data(index, 0))
    }

    onItemVisibleChanged: {
      layerTree.setData(index, itemVisible, LayerTreeModel.Visible)
    }
}
