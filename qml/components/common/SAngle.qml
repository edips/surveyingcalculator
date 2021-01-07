import QtQuick 2.12
import Qt.labs.settings 1.0
import "../"
import "../../"
import "script.js" as Settings

Item {
    property alias decimal_txt: dec.text;
    property alias degree_txt: deg.text;
    property alias minute_txt: min.text;
    property alias second_txt: sec.text;
    property alias gon_txt: gon_txt.text;

    //property var text_value: angle_settings()
    property int sfontsize: 16;
    property alias degree: deg;
    property alias minute: min;
    property alias second: sec;
    property alias decimal: dec;
    property alias gon: gon_txt;
    property bool viz_dec;
    property bool viz_deg;
    property bool read_only:false

    // angle text values for settings
    /*
    function angle_settings(){
        if(__appSettings.angleUnit === 0){
            var x = String(/decimal_txt/);
            x = x.substring(1, x.length-1);
            return x
        }
        else if(__appSettings.angleUnit === 1){
            var y = String(/[degree_txt, minute_txt, second_txt]/);
            y = y.substring(1, y.length-1);
            return y
        }
        else if(__appSettings.angleUnit === 2){
            var z = String(/gon_txt/);
            z = z.substring(1, z.length-1);
            return z
        }
    }*/
    height: 38
    width: __appSettings.angleUnit === 0 ? dec.width : dec_row.implicitWidth

    Row {
        id: dec_row
        visible: {
            if(__appSettings.angleUnit === 1){
                return true
            }
            else{
                return false
            }
        }

        spacing: 5
        STextField{ id:deg; placeholderText: qsTr("°"); implicitWidth: 45; font.pixelSize: sfontsize; readOnly: read_only; }
        STextField{ id:min; placeholderText: qsTr("'"); implicitWidth: 35; font.pixelSize: sfontsize; readOnly: read_only; }
        STextField{ id:sec; placeholderText: qsTr("''"); implicitWidth: 100; font.pixelSize: sfontsize; readOnly: read_only; }
    }
    Row {
        visible: {
            if(__appSettings.angleUnit === 0 ){
                return true
            }
            else{
                return false
            }
        }
        spacing: 5
        STextField { id: dec; placeholderText: qsTr("°"); font.pixelSize: sfontsize; readOnly: read_only;  }
    }

    Row {
        visible: {
            if(__appSettings.angleUnit === 2){
                return true
            }
            else{
                return false
            }
        }
        spacing: 5
        STextField { id: gon_txt; placeholderText: qsTr("‎ᵍ"); font.pixelSize: sfontsize; readOnly: read_only; }
    }

}
