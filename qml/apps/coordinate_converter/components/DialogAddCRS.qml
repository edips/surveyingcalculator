import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1

// to import SharedXY.qml
import "../"
import "../../../components/common"
import "../database.js" as Db

// AddCRS Dialog
SDialog {
    height: 380
    width: parent.width
    title: qsTr("Add Custom Coordinate System")
    SFlickable{
        interactive: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 5
        }
        contentHeight: add_column.implicitHeight
        //contentWidth: parent.width
        clip: true
        ScrollIndicator.vertical: ScrollIndicator { }
    Column{
        id:add_column
        anchors.fill: parent
        spacing: 10

        ColumnLayout{
            id:mayrow22
            spacing: 5
            SText{
                text:qsTr("Coordinate System Name")
                font.pixelSize: 12
                leftPadding: 10
            }
            TextField {
                id: crsName
                implicitWidth: 275
                leftPadding: 10
                inputMethodHints:  Qt.ImhSensitiveData
                font.pixelSize: 15
                font.bold: true
                selectByMouse: true
                EnterKey.type: Qt.EnterKeyNext
                Keys.onReturnPressed:  nextItemInFocusChain().forceActiveFocus()
                background: Rectangle {
                        color: "#f4f4f0"
                        border.color: "#b3c2cb"
                        width: 275
                    }
            }
         }

        Rectangle{
            width: windoww.width
            height: 1
            color: "gainsboro"
        }

        ColumnLayout{
            spacing: 5
            SText{
                text:qsTr("Proj4 Definition")
                font.pixelSize: 12
                leftPadding: 10
            }
            Rectangle{
                width:  275
                height:  110
                color:"transparent"
                Flickable {
                      id: flickable
                      anchors.fill: parent
                      flickableDirection: Flickable.VerticalFlick
                      contentWidth: parent.width
                      clip: true
                      TextArea.flickable: TextArea {
                          id: projDef
                          wrapMode: TextEdit.WrapAnywhere
                          selectByMouse: true
                          topPadding: 0
                          leftPadding: 10
                          inputMethodHints:  Qt.ImhSensitiveData
                          font.pixelSize: 14
                          background: Rectangle {
                              color: "#f4f4f0"
                              border.color: "#b3c2cb"
                              width: 275
                          }
                      }
                }
            }

        }
    }
    }
    standardButtons: Dialog.Ok | Dialog.Cancel
    onAccepted:{
        if(projDef.text === "" || crsName.text === ""){
            snack.open("Error! Coordinate System Name or Proj4 Definition cannot be empty.")
        }else if(!(__projectsModel.projDefValid(projDef.text))){
            snack.open("Error! Proj definition is invalid! Please check the Proj4 definition.")
        }
        else{
            var mysnack = snack
            mysnack.duration = 4000
            if (country_text !== "U.S."){
                Db.insert_CRS(country_text, crsName.text, projDef.text, mysnack)

                // repeat this workfrom from combobox onCurrentIndexChanged. TODO: Make a function for this
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
                Db.insert_CRS_us(country_text, us_text, crsName.text, projDef.text, mysnack)

                // repeat this workfrom from combobox onCurrentIndexChanged. TODO: Make a function for this
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
