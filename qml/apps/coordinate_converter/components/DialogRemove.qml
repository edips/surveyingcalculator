import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1

// to import Shared.qml
import "../"
import "../../../components/common"
import "../database.js" as Db


// Remove CRS Dialog
SDialog {
    id: removeCRS
    height: 230
    width: parent.width
    title: qsTr("Remove Coordinate System")
    SFlickable{
        interactive: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 5
        }
        contentHeight: remove_column.implicitHeight
        //contentWidth: parent.width
        clip: true
        ScrollIndicator.vertical: ScrollIndicator { }
        Column{
            id:remove_column
            anchors.fill: parent
            spacing: 10

            STextTop{
                text:qsTr("Select a Coordinate System to Remove")
                font.pixelSize: 12
                leftPadding: 10
            }
            CustomComboBox {
                id: combo_coord
                width:parent.width
                currentIndex: 0
                model: SharedXY.cogoOutputModel
            }
        }
    }
    standardButtons: Dialog.Ok | Dialog.Cancel
    onAccepted:{
        if(combo_coord.currentText === ""){
            snack.open("Failed to remove. Coordinate system is not selected.")
        }
        else{
            var mysnack = snack
            mysnack.duration = 4000
            if (country_text !== "U.S."){
                Db.remove_CRS(country_text, combo_coord.currentText, mysnack)

                // repeat this workfrom from CustomComboBox onCurrentIndexChanged. TODO: Make a function for this
                Db.my_coords(country_text)
                coordName_list = Db.coordName_list

                Db.my_proj(country_text)
                projDef_list = Db.proj_dict;

                Db.degree_unit(country_text)
                my_unit = Db.unit_dict;

                SharedXY.cogoInputModel.clear()
                SharedXY.cogoOutputModel.clear()
                for(var i in coordName_list){
                    SharedXY.cogoInputModel.append({"text": coordName_list[i]});
                    SharedXY.cogoOutputModel.append({"text": coordName_list[i]});
                }
                coordName_list = []
                projDef_list = {}
                my_unit = {}
                // end workflow
            }else{
                Db.remove_CRS_us(us_text, combo_coord.currentText, mysnack)

                // repeat this workfrom from CustomComboBox onCurrentIndexChanged. TODO: Make a function for this
                Db.my_coords_us(us_text)
                coordName_list = Db.coordName_list
                Db.my_proj_us(us_text)
                projDef_list = Db.projdef_list;

                Db.degree_unit_us(us_text)
                my_unit = Db.unit_dict;

               //console.log("current text in qml:", us_text)
                //console.log("coordinate_systems: ", coordName_list)
                SharedXY.cogoInputModel.clear()
                SharedXY.cogoOutputModel.clear()
                for(var i2 in coordName_list){
                    SharedXY.cogoInputModel.append({"text": coordName_list[i2]});
                    SharedXY.cogoOutputModel.append({"text": coordName_list[i2]});
                }
                coordName_list = []
                projDef_list = {}
                my_unit = {}
                // end workflow
            }

            projDef.text = ""
            crsName.text = ""
        }
    }
}
