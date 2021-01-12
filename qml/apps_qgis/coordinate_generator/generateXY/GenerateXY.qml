import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../../components/common/script.js" as Calc
import "interpolatePoint.js" as Js_point
import "../../../components/common"
import "../../../components/gis"
Item{
    id: root_xy
    property var my_arr : []
    property int cogo_count: 0
    Settings{
        id: dist_settings
        property alias gen1: pt_1.north_txt
        property alias gen2: pt_1.east_txt
        property alias gen3: pt_2.north_txt
        property alias gen4: pt_2.east_txt
        property alias gen5:intervals.text
    }

    // Generate coordinates from active layer dialog
    CoordinateList {
        id: coordList
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
                if( selected && coordName === "pt_1" ) {
                    pt_1.east.text = xCoord
                    pt_1.north.text = yCoord
                    selected = false
                }
                else if( selected && coordName === "pt_2" ) {
                    pt_2.east.text = xCoord
                    pt_2.north.text = yCoord
                    selected = false
                }
            }
        }
    }

    SFlickable {
        id:optionsPage
        contentHeight: Math.max(macolumn.implicitHeight+65, height)
        anchors.topMargin: 15
        Column{
            id:macolumn
            width: parent.width
            spacing: 25
            anchors.horizontalCenter: parent.horizontalCenter
            // coordinate header NE OR XY
            NEHeader {}

            // Point 1
            NorthEastP {
                id: pt_1
                name: "1"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_1"
                    loadComponent.item.open()
                }
            }
            // Point 2
            NorthEastP {
                id: pt_2
                name: "2"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_2"
                    loadComponent.item.open()
                }
            }
            // Number of intervals
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:10
                SText {text: "Number of Intervals: "; font.bold: false;}
                STextField{id:intervals; implicitWidth: 45}
            }
            // Hesap
            Row{
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
                        var x1 = parseFloat( pt_1.north.text) ;
                        var y1 = parseFloat( pt_1.east.text )
                        var x2 = parseFloat( pt_2.north.text )
                        var y2 = parseFloat( pt_2.east.text )
                        var interval = parseInt(intervals.text)+1
                        console.log("interval is: ", interval)
                        if(pt_1.north.text === "" || pt_2.north.text === "" || pt_1.east.text === "" || pt_2.east.text === "" || intervals.text === ""){
                            snack.open("Please enter the parameters.")
                        }

                        else if(interval <= 0){
                            snack.open("Intervals should be positive numbers.")
                        }
                        else if(interval >=1001){
                            snack.open("Intervals should be less than 1000.")
                        }

                        else {
                            var coords = interpolateLineRange ( [ [x1, y1 ], [x2 , y2] ], interval)
                            if( coords.length > 0 ) {
                                var coord_txt = ""
                                // Be careful to do this for extracting list of coordinates!
                                if( __appSettings.xyOrder === "en" ) {
                                    for( var i = 0; i < coords.length; i++ ) {
                                        // x: coords[ i ][0]
                                        coord_txt += coords[ i ][1].toFixed(2) + "  " + coords[ i ][0].toFixed(2) + "\n"
                                    }
                                } else {
                                    for( var k = 0; k < coords.length; k++ ) {
                                        // x: coords[ i ][0]
                                        coord_txt += coords[ k ][0].toFixed(2) + "  " + coords[ k ][1].toFixed(2) + "\n"
                                    }
                                }

                                coordList.editor.text = coord_txt
                                coordList.open()
                            }
                        }
                    }
                }
                Button {
                    id:c
                    width: 40
                    icon.source: "qrc:/assets/icons/material/content/clear.svg"
                    onClicked: {
                        pt_1.north.text = pt_2.north.text = pt_1.east.text = pt_2.east.text = intervals.text = ""
                    }
                }
            }
        }
    }
}
