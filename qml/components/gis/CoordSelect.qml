import QtQuick 2.0
import "../common"
import QgsQuick 0.1 as QgsQuick
import lc 1.0
/* TODO:
- Add zoom button left size of the tool bar
*/
TopSheet {
    property string coordName;
    property bool isGeographic: false
    property string xCoord; // easting
    property string yCoord; // northing
    // when selected true, it means user chose a point from map canvas. if it is false, close button pressed, and coords aren't selected
    property bool selected: false

    onOpened: {
        // reset selected to false when the dialog open,
        selected = false
    }

    id: map_dialog
    title: "Choose a point"
    // toolbar z must be more than map canvas
    toolbar.z: mapView.z + 1
    // Map View component with map canvas and basic project browser
    MapView {
        id: mapView
        z: activeProjectIndex === -1 ? 10 : 0
        projectPanelEnabled: false
        anchors.top: map_dialog.toolbar.bottom
        width: map_dialog.width
        height: map_dialog.height
        mapCanvas.onClicked: {
            // set selected true to set coordX and coordY
            mapCanvas.forceActiveFocus()
            var screenPoint = Qt.point( mouse.x, mouse.y );
            var res = identifyKit.identifyOne(screenPoint);
            if (res.valid && __surveyingUtils.featureIsPoint(res)) {
                var pointCoord = __surveyingUtils.qgsPoint2String(res, __loader.isGeographic())
                xCoord = pointCoord[0] // easting
                yCoord = pointCoord[1] // northing
                selected = true
                // close the dialog after selecting a point
                map_dialog.close()
            }
        }
    }
    // FeaturePanel to choose features
    QgsQuick.IdentifyKit {
        id: identifyKit
        //parent: mapView.mapCanvas
        mapSettings: mapView.canvasMapSettings
        identifyMode: QgsQuick.IdentifyKit.TopDownAll
    }
}
