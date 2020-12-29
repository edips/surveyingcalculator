import QtQuick 2.0

import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import org.qgis 1.0
import org.qfield 1.0

import QtQml.Models 2.2

/*
Todo:

- Fix "ReferenceError: delegatedItem2 is not defined"

- Fix "QML Image: Failed to get image from provider: image://legend/group"

- Fix:
file:///home/edip/Qt5.13.0/5.13.0/gcc_64/qml/QtQuick/Controls/Styles/Base/TreeViewStyle.qml:47:5: Unable to assign Legend_QMLTYPE_130 to TreeView_QMLTYPE_109
- Fix
qrc:/qml/content/mapviewer/Legend.qml:74:5: QML Image: Failed to get image from provider: image://legend/group

- Fix

"Passing incompatible arguments to C++ functions from JavaScript is dangerous and deprecated."
"This will throw a JavaScript TypeError in future releases of Qt!"
"Could not convert argument 2 at"
     "expression for index@file:///home/edip/Qt5.13.0/5.13.0/gcc_64/qml/QtQuick/Controls/Private/TreeViewItemDelegateLoader.qml:84"
     "expression for onItemAdded@file:///home/edip/Qt5.13.0/5.13.0/gcc_64/qml/QtQuick/Controls/Private/BasicTableView.qml:615"
     "expression for onCompleted@file:///home/edip/Qt5.13.0/5.13.0/gcc_64/qml/QtQuick/Controls/Private/BasicTableView.qml:545"
"Passing incompatible arguments to C++ functions from JavaScript is dangerous and deprecated."
"This will throw a JavaScript TypeError in future releases of Qt!"
*/

TreeView {
  id: listView
  model: layerTree




  style: TreeViewStyle{
    indentation: 24
    branchDelegate: Item {
        width: 24
        height: 24
        Rectangle{
            anchors.fill: parent
            color:  styleData.row !== undefined && layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.VectorLayer) === currentLayer && currentLayer != null ? "#999" : "#fff"
            Image {
                function getThemeIcon(name) {
                    console.log("dp is: ", dp)
                  var ppi = dp / 0.00768443;
                  var ppiRange
                  if ( ppi >= 360 )
                    ppi = "xxxhdpi";
                   else if ( ppi >= 270 )
                    ppi = "xxhdpi";
                   else if ( ppi >= 180 )
                    ppi = "xhdpi";
                   else if ( ppi >= 135 )
                    ppi = "hdpi";
                   else
                    ppi = "mdpi";

                  var path = "qrc:" + ppi + '_' + name + '.png';
                  console.log("arrow path is: ", path)
                  return path;
                }
              anchors.fill: parent
              source: styleData.isExpanded ? getThemeIcon("ic_arrow_drop_down_black_24dp") : getThemeIcon("ic_arrow_right_black_24dp")
            }
        }
    }
  }

  headerVisible: false

  QtObject {
    id: properties

    property var previousIndex
  }

  property VectorLayer currentLayer

  Controls.TableViewColumn {
    role: "display"
  }

  rowDelegate: Rectangle {
    height: layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.Type) === 'legend' ? 36  : 48
    color: styleData.row !== undefined && layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.VectorLayer) === currentLayer && currentLayer != null ? "#999" : "#fff"
    //small hack: since the image of a root item should be aligned to the expand triangles of branches, it needs to be printed here
    Image {
      visible: styleData.row !== undefined && layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.Type) === 'layer'
      source: "image://legend/" + layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.LegendImage)
      width: delegatedItem2.height
      height: delegatedItem2.height
      x: ( 24  - width )/2
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  itemDelegate: Item {
    id: delegatedItem2
    height: Math.max(16, label.implicitHeight)
    property int implicitWidth: label.implicitWidth + 20

    RowLayout {
      height: layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.Type) === 'legend' ? 36  : 48



      Image {
        visible: layerTree.data(listView.__model.mapRowToModelIndex(styleData.row), LayerTreeModel.Type) === 'legend'
        source: "image://legend/" + layerTree.data(styleData.index, LayerTreeModel.LegendImage)
        width: 24
        height: 24
        Layout.alignment: Qt.AlignVCenter
      }
      Text {
        id: label
        horizontalAlignment: styleData.textAlignment
        Layout.alignment: Qt.AlignVCenter
        elide: styleData.elideMode
        text: styleData.value !== undefined ? styleData.value : ""
        renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
        color: layerTree.data(styleData.index, LayerTreeModel.Visible) ? "black" : "gray"
      }
    }
  }

  /**
   * User clicked an item
   *
   * @param index : QModelIndex
   */
  onClicked: {
    var nodeType = layerTree.data(index, LayerTreeModel.Type)
    if (nodeType !== 'layer') {
      if (listView.isExpanded(index))
          listView.collapse(index)
      else
          listView.expand(index)
    }
    else
      currentLayer = layerTree.data(index, LayerTreeModel.VectorLayer)
  }

  onPressAndHold: {
    itemProperties.index = index
    itemProperties.open()
  }

  onDoubleClicked: {
    if (listView.isExpanded(index))
        listView.collapse(index)
    else
        listView.expand(index)
  }

  LayerTreeItemProperties {
      id: itemProperties
      layerTree: listView.model

      modal: true
      closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
      parent: ApplicationWindow.overlay
  }
}
