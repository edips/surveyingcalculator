import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import QtQuick.Layouts 1.12
import "../database.js" as Db
import "../../../components/common"
import "../"
//property alias country_combo : country

FluidControls.AlertDialog {
    //Combo box values:
    property int countrycombo:country.currentIndex
    property int uscombo: us_combo.currentIndex

    property string country_text:country.currentText
    property string us_text: us_combo.currentText
    //property alias coord_setting_dialog: counter_coord_settings
    Settings{
        id: coordsetting
        property alias countrycombo2:country.currentIndex
        property alias uscombo2:us_combo.currentIndex
    }

    id: settingsDialog_coord
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: parent.width
    height: us_states.visible ? 3*(country.implicitHeight) + 50 : 2*(country.implicitHeight) + 50
    title: country.currentText === "U.S." ? "Select State" : "Select Country"

    Flickable{
        id:settings_flickable
        implicitWidth: settingsDialog_coord.width
   ColumnLayout{

    RowLayout{
        id:settings_column
        //width: parent.width
        spacing: 15
        CustomComboBox {
           id: country
           Layout.alignment: Qt.AlignHCenter
           Layout.preferredWidth: 200
           //model: CoordModel{}

           model: countries
           onCurrentTextChanged: {
               //my_currentText = country.currentText
               //currentindex = currentIndex

               if (country.currentText !== "U.S."){
                   Db.my_coords(country.currentText)
                   coordName_list = Db.coordName_list

                   Db.my_proj(country.currentText)
                   projDef_list = Db.proj_dict;

                   Db.degree_unit(country.currentText)
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
           }
               else{
                   Db.my_coords_us(us_combo.currentText)
                   coordName_list = Db.coordName_list
                   Db.my_proj_us(us_combo.currentText)
                   projDef_list = Db.projdef_list;

                   Db.degree_unit_us(us_combo.currentText)
                   my_unit = Db.unit_dict;

                  //console.log("current text in qml:", us_combo.currentText)
                   SharedXY.cogoInputModel.clear()
                   SharedXY.cogoOutputModel.clear()
                   for(var i2 in coordName_list){
                       SharedXY.cogoInputModel.append({"text": coordName_list[i2]});
                       SharedXY.cogoOutputModel.append({"text": coordName_list[i2]});
                   }
                   coordName_list = []
                   projDef_list = {}
                   my_unit = {}
               }


           }


        }
    }

    RowLayout{
        id:us_states
        //width: parent.width
        visible: country.currentText == "U.S."
        spacing: 15
        ColumnLayout{
            width: parent.width
            CustomComboBox {
               id: us_combo
                Layout.alignment: Qt.AlignHCenter
               Layout.preferredWidth: 200

               model: usa_states
               onCurrentTextChanged: {
                   //my_currentText_us = us_combo.currentText
                   //currentindex_us = currentIndex

                   if (country.currentText === "U.S."){
                       Db.my_coords_us(us_combo.currentText)
                       coordName_list = Db.coordName_list
                       Db.my_proj_us(us_combo.currentText)
                       projDef_list = Db.projdef_list;

                       Db.degree_unit_us(us_combo.currentText)
                       my_unit = Db.unit_dict;

                      //console.log("current text in qml:", us_combo.currentText)
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
                    }
               }

            }
        }
    }

        }

}
}
