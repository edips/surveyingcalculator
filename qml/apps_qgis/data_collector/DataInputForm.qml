import QtQuick 2.10
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import "../../components/common"
import "../../components/common/script.js" as Util

Rectangle {
    property int inputFormHeight: data_column.implicitHeight
    property string coordinateText: (Util.datacollector_coord()).toString()
    color: Universal.background
    id: collect_pane
    width: parent.width
    height: data_column.implicitHeight + 15
    anchors.bottom: parent.bottom
    z: 3
    Column{
        id:data_column
        anchors.fill: parent
        spacing: 7
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                width: 300
                height: 30
                STextTop{
                    id: coordTxt
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height;
                    text: coordinateText
                    // * TODO: it gives error: "Unable to assign [undefined] to QString" this should be fixed with c++ source codes. if the error keeps, ask it to irc or issues.
                    //text: {
                        /*if ( positionKit.hasPosition ){
                            return (Util.datacollector_coord()).toString();
                        }
                        return "";
                        */

                   // }
                    width: 300
                    font.pixelSize: 13
                }
            }
            Row {
                spacing: 30
                
                STextTop{
                    clip: true
                    font.bold: false
                    horizontalAlignment: Text.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                    /*
                    text: {
                        var label = "Signal Lost"
                        if ( positionKit.hasPosition )
                            //label = QgsQuick.Utils.formatPoint( positionKit.position )
                            if (positionKit.accuracy > 0)
                                label = "Accuracy: " + QgsQuick.Utils.formatDistance( positionKit.accuracy, positionKit.accuracyUnits, 1 )
                        label;
                    }
                    */
                    width: 120
                    font.pixelSize: 13
                    /*color: {
                        if (positionKit.accuracy > 5 || !positionKit.hasPosition){
                            return "crimson"
                        }else if(positionKit.accuracy < 5 && positionKit.accuracy > 2){
                            return "coral"
                        }
                        else{
                            return "green"
                        }
                    }*/
                }
                
                SText {
                    horizontalAlignment: Text.AlignLeft
                    // Project's Ccoordinate System Name
                    text: epsgName
                    font.bold: false
                    width: 140
                    wrapMode: Label.WordWrap
                    font.pixelSize: 12
                }
            }
        }
    }
}