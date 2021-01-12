import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtGraphicalEffects 1.0
import "../../components/common"


/*
TODO
needs code clear, simplify and add comments
*/
SRoundButton {
    property int inputFormHeight


    id:fullMapBtn
    z: mapView.mapCanvas.z + 1
    tooltip: qsTr("Store Point");
    icon.source: "qrc:/assets/icons/material/maps/add_location.svg"
    icon.color: "white"

    onClicked: {
        /*
        var screenPoint = Qt.point( mapView.mapCanvas.width/2, mapView.mapCanvas.height/2 )
        var centerPoint = mapView.canvasMapSettings.screenToCoordinate(screenPoint)
        // increment point name after pressing record button
        function incrementString(str) {
            // Find the trailing number or it will match the empty string
            var count = str.match(/\d*$/);
            // Take the substring up until where the integer was matched
            // Concatenate it to the matched count incremented by 1
            return str.substr(0, count.index) + (++count[0]);
        }

          for new version of input cpp files
        // replaced activeLayerPanel.activeVectorLayer with __layersModel.activeLayer()
        if (digitizing.hasPointGeometry(__layersModel.activeLayer())) {
            // set feature survey is our method, it should be moved to SurveyingUtils class
            // use __layersModel.activeIndex instead of activeLayerPanel.activeLayerIndex
            __layersModel.setFeatureSurvey(__layersModel.activeIndex, collect_pane.pointName.text, collect_pane.pointDesc.text, centerPoint)
            collect_pane.pointDesc.text = ""
            collect_pane.pointName.text = incrementString(collect_pane.pointName.text)
        }else{
            snack.open("Not recorded. Point layer is not selected.")
        }*/

        if (digitizing.hasPointGeometry(activeLayerPanel.activeVectorLayer)) {
            //var pair = digitizing.pointFeatureFromPoint(centerPoint)
            //saveRecordedFeature(pair)
            var screenX = mapView.mapCanvas.width/2
            var screenY = mapView.mapCanvas.height/2
            dataCollector.recordFeature(screenX, screenY)
        }else{
            snack.open("Please select a point layer from Active Layer panel to record points.")
        }
    }
}
