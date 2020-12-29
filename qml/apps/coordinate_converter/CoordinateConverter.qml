import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import QtQuick.LocalStorage 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

import "../../components/common/script.js" as Calc
import "database.js" as Db
import "../../components/common"

Item{
    Settings{
        id:coordsettings222
        property alias coord_decimcheck:decim.checked
        property alias aacoord_combo_index2: output_coord.currentIndex
        property alias aacoord_combo_index1: input_coord.currentIndex
        property alias vccoord_combo_text2 : output_coord.currentText
        property alias sdcoord_combo_text1 : input_coord.currentText
        property alias coord1:nres.text
        property alias coord2:eres.text
        property alias coord3:north.text
        property alias coord4:east.text
        property alias coord_geo_1:latin.text
        property alias coord_geo_2:lonin.text
        property alias coord_geo_3:latdegin.text
        property alias coord_geo_4:londegin.text
        property alias coord_geo_5:latminin.text
        property alias coord_geo_6:lonminin.text
        property alias coord_geo_7:latsecin.text
        property alias coord_geo_8:lonsecin.text
        property alias coord_geo_9:latres.text
        property alias coord_geo_10:lonres.text
        property alias coord_geo_11:latdegres.text
        property alias coord_geo_12:latminres.text
        property alias coord_geo_13:latsecres.text
        property alias coord_geo_14:lonminres.text
        property alias coord_geo_15:londegres.text
        property alias coord_geo_16:lonsecres.text
    }
    // GPS positioning function:
    function gps_position(n,e,n_rest,e_rest,icoord,ocoord){
        var north = parseFloat(n)
        var east = parseFloat(e)
        // Key value'den koordinat isimlerine gore proj4 defi çıkarır
        var proj_output = Db.proj_dict[ocoord];
        // new--------------------
        console.log("gps_position() function works in js Debug 1")
        var coords = (__surveyingUtils.transformer(east, north, icoord, proj_output)).split(",")
        // new--------------------
        //console.log("transformed coordinate: ", coords[0], coords[1]  )
        n_rest = coords[1]
        e_rest = coords[0]
        return [parseFloat(n_rest), parseFloat(e_rest)]
    }

    // Transform Coordinate
    function convert_coordinate(n,e,n_rest,e_rest,icoord,ocoord,mysnack){
        var north = parseFloat(n)
        var east = parseFloat(e)
        if( north==="" || east==="")
        {
            mysnack.open(qsTr("Please enter the values."))
        }

        // Key value'den koordinat isimlerine gore proj4 defi çıkarır
        var proj_input = Db.proj_dict[icoord];
        var proj_output = Db.proj_dict[ocoord];
        console.log("convert_coordinate() function works in js Debug 1")
        // new--------------------
        var coord = (__surveyingUtils.transformer(parseFloat(east), parseFloat(north), proj_input, proj_output)).split(",")
        // new--------------------
        n_rest = coord[1]
        e_rest = coord[0]
        return [parseFloat(n_rest), parseFloat(e_rest)]
    }

    id:myitem
    Component.onCompleted: {

        if( isNaN(latin.text) || isNaN(lonin.text) || isNaN(latdegin.text) || isNaN(londegin.text) ||
                isNaN(latminin.text) || isNaN(lonminin.text) || isNaN(latsecin.text) || isNaN(lonsecin.text))
         {
            latin.text      = ""
            lonin.text      = ""
            latdegin.text   = ""
            londegin.text   = ""
            latminin.text   = ""
            lonminin.text   = ""
            latsecin.text   = ""
            lonsecin.text   = ""
            latres.text     = ""
            lonres.text    = ""
            latdegres.text = ""
            latminres.text = ""
            latsecres.text = ""
            lonminres.text = ""
            londegres.text = ""
            lonsecres.text = ""

         }
    }

    PositionSource {
        id: src
        updateInterval: 1000
        active: Db.startgps(SharedXY.mycount)
        onPositionChanged: {
            var i_current_text = input_coord.currentText;
            var currentPosition = src.position.coordinate

            var latdegin_ = latdegin.text;
            var latminin_ = latminin.text;
            var latsecin_ = latsecin.text;
            var londegin_ = londegin.text;
            var lonminin_ = lonminin.text;
            var lonsecin_ = lonsecin.text;

            var lat_input = latin.text;
            var lon_input = lonin.text;

            var lat_ = currentPosition.latitude;
            var lon_ = currentPosition.longitude;

            var my_pos = gps_position(lat_,lon_,lat_input, lon_input,"4326",i_current_text);

            if(Db.unit_input(input_coord.currentText)){
                if(decim.checked==true){
                    latin.text=parseFloat( my_pos[0].toFixed(10) )
                    lonin.text=parseFloat( my_pos[1].toFixed(10) )
                }
                else if(decim.checked==false){
                    var latdec2 = parseFloat( my_pos[0].toFixed(10) )
                    var londec2 = parseFloat( my_pos[1].toFixed(10) )

                    var latdegg=parseInt(latdec2)
                    var latminn=parseInt((latdec2-latdegg)*60)
                    var latsecc=(latdec2-latdegg-latminn/60)*3600
                    latdegin.text = latdegg
                    latminin.text = latminn
                    latsecin.text = parseFloat( (latsecc).toFixed(6))

                    var londegg=parseInt(londec2)
                    var lonminn=parseInt((londec2-londegg)*60)
                    var lonsecc=(londec2-londegg-lonminn/60)*3600
                    londegin.text=londegg
                    lonminin.text=lonminn
                    lonsecin.text=parseFloat( (lonsecc).toFixed(6) )
                }
            }

            else if(Db.unit_input(input_coord.currentText)===false){
                // new parseFloat
                north.text = parseFloat( my_pos[0].toFixed(3) )
                east.text = parseFloat( my_pos[1].toFixed(3) )
            }
        }
    }

    SFlickable {
        id:optionswgs
        contentHeight: root_column.implicitHeight
        anchors.topMargin: 20

        ColumnLayout{
            id: root_column
            anchors.fill: parent
            width: parent.width
            spacing:15
//---------------ust form Başlangıç-----------------------------
        // from combo box input
        Rectangle{
            id: toprow
            color: "transparent"
            height: toprect3.implicitHeight
            width: parent.width
            Row {
                id:toprect3
                width: parent.width
                spacing: 1
                Layout.alignment: Qt.AlignHCenter
                Rectangle{
                    id:rectyes3
                    color:"transparent"
                    width:40
                    height: parent.height
                    SText{
                        text: "from: "
                        width:parent.width
                        height: parent.height;
                    }
                }
                CustomComboBox{
                    id: input_coord
                    width:optionswgs.width-rectyes3.width - 15
                    currentIndex: 0
                    model: SharedXY.cogoInputModel
                    onCurrentTextChanged: {
                        var icoord = input_coord.currentText;
                    }
                }
            }
        }


        // koordinatlar input
            ColumnLayout{
                id:mygrid2
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                // North East
                Grid {
                    width: parent.width
                    rowSpacing: 5
                    columnSpacing: 5
                    columns:2
                    rows:2
                    function viz_in(){
                        var icoord = input_coord.currentText;
                        if ( Db.unit_output(icoord)!==true){
                             return true
                        }
                        else{
                            return false
                        }
                    }
                    visible: viz_in()

                    layoutDirection: Calc.coord_display()

                    Row{
                        id:my_row
                        spacing: 6
                        SText{text: Calc.textN() + ": "; height: my_row.height; }
                        STextField{id:north}
                    }

                    Row{
                        spacing: 6
                        SText{text: Calc.textE() + ": "; height: my_row.height; }
                        STextField{id:east}
                    }
                }

            // LAT/LON DECIMAL
                    Grid {
                        function vizz223(){
                            var ocoord = input_coord.currentText;
                            if (decim.checked===true && Db.unit_output(ocoord)===true){
                                 return true
                            }
                            else{
                                return false
                            }
                        }
                        Layout.alignment: Qt.AlignHCenter
                        visible: vizz223()
                        id:result_decimal_grid2
                        width: parent.width
                        rowSpacing: 5
                        columnSpacing: 6
                        columns:2
                        rows:2
                        SText{anchors.margins: 1;  text: qsTr("Latitude:"); height: my_row.height; }

                        STextField{id:latin; placeholderText: qsTr("°")}

                        SText{anchors.margins: 1;  text: qsTr("Longitude:"); height: my_row.height; }

                        STextField{id:lonin;placeholderText: qsTr("°")}
                    }

            // LAT/LON
            Grid{
                id:mygrid52
                width: parent.width
                rowSpacing: 5
                columnSpacing: 6
                columns:4
                //Layout.alignment: Qt.AlignHCenter
                rows:2
                    function text_viz3(){
                        var ocoord = input_coord.currentText;
                    if (decim.checked===false && Db.unit_output(ocoord)===true){
                        return true
                    }
                    else{
                        return false
                    }
                    }
               visible: text_viz3()

                   SText{id:matext223; text: qsTr("Latitude: ");  height: my_row.height; }
                   STextField{id:latdegin;placeholderText: qsTr("°"); implicitWidth: 35}
                   STextField{id:latminin;placeholderText: qsTr("'"); implicitWidth: 35}
                   STextField{id:latsecin;placeholderText: qsTr("''"); implicitWidth: 100}
                   SText{id:matext2_son2; text: qsTr("Longitude: ");  height: my_row.height; }
                   STextField{id:londegin;placeholderText: qsTr("°"); implicitWidth: 35}
                   STextField{id:lonminin;placeholderText: qsTr("'"); implicitWidth: 35}
                   STextField{id:lonsecin;placeholderText: qsTr("''"); implicitWidth: 100}
            }
        }


      // Hesap
      // TODO: add Hesap component and enable decimal checkable button
      Row{
          id:myrow
          spacing: 20
          Layout.alignment: Qt.AlignHCenter
          width: parent.width
          Button {
              id:hsp
              width: 50
              Image {
                  fillMode: Image.PreserveAspectFit
                  anchors.centerIn: parent
                  width: 40
                  source: "qrc:/assets/images/equal.png"
              }
              highlighted: true
              //onclicked----------------------------------------------------------------------------------------
              onClicked: {
                  function myparser(inp){
                      return parseFloat(inp.text.replace(',','.').replace(' ',''))
                  }

                  var n         = myparser(north)
                  var e         = myparser(east)
                  var latin_    = myparser(latin)
                  var lonin_    = myparser(lonin)
                  var latdegin_ = myparser(latdegin)
                  var latminin_ = myparser(latminin)
                  var latsecin_ = myparser(latsecin)
                  var londegin_ = myparser(londegin)
                  var lonminin_ = myparser(lonminin)
                  var lonsecin_ = myparser(lonsecin)

                  var n_rest;
                  var e_rest;
                  var icoord = input_coord.currentText;
                  var ocoord = output_coord.currentText;
                  var mysnack = snack

                  function coord_input(){
                      if(Db.unit_input(icoord) === false){
                          return [n, e];
                      }
                      else{
                          if(decim.checked === true){
                              return [latin_,lonin_]
                          }
                          else{
                              var lat2dec=Math.abs(latdegin_) + Math.abs(latminin_/60) + Math.abs(latsecin_/3600)
                              if (latdegin_<0){
                                  lat2dec=-lat2dec
                              }
                              var lon2dec=Math.abs(londegin_) + Math.abs(lonminin_/60) + Math.abs(lonsecin_/3600)
                              if(londegin_<0){
                                  lon2dec=-lon2dec
                              }
                              return [lat2dec, lon2dec]
                          }
                      }
                  }

                  var input_coords = coord_input();


                  var my_results = convert_coordinate(input_coords[0],input_coords[1],n_rest,e_rest,icoord,ocoord,mysnack)
                  my_results = [parseFloat(my_results[0]), parseFloat(my_results[1])]
                  //console.log("output unit degeri: ", Db.unit_output(ocoord))

                  if(Db.unit_output(ocoord) === false){
                      nres.text = parseFloat( my_results[0].toFixed(3) );
                      eres.text = parseFloat( my_results[1].toFixed(3) );
                  }
                  else{
                      if(decim.checked === true){
                          // Output değerleri: Latitude Longitude decimal values
                          latres.text = parseFloat( my_results[0].toFixed(8) );
                          lonres.text = parseFloat( my_results[1].toFixed(8) );
                      }
                      else{
                          // Output değerleri:
                          // Latitude Longitude degree minute second
                          //console.log("my_results[0],[1]: ", my_results[0], my_results[1])
                          var latdegg=parseInt(my_results[0])
                          var latminn=parseInt((my_results[0]-latdegg)*60)
                          var latsecc=(my_results[0]-latdegg-latminn/60)*3600
                          latdegres.text=latdegg
                          latminres.text=Math.abs(latminn)
                          latsecres.text=parseFloat( (Math.abs(latsecc)).toFixed(6) )
                          // Longitude degree minute second
                          var londegg=parseInt(my_results[1])
                          var lonminn=parseInt((my_results[1]-londegg)*60)
                          var lonsecc=(my_results[1] - londegg-lonminn/60)*3600
                          londegres.text=londegg
                          lonminres.text=Math.abs(lonminn)
                          lonsecres.text=parseFloat( (Math.abs(lonsecc)).toFixed(6) )
                      }
                    }
              }
          }
          Button {
              id:clr
              width: 40
              icon.source: "qrc:/assets/icons/material/content/clear.svg"
              onClicked: {
                          east.text=north.text=nres.text=eres.text=latin.text=lonin.text=
                          latdegin.text=latminin.text=latsecin.text=londegin.text=lonminin.text=lonsecin.text=latres.text=lonres.text=
                          latdegres.text=latminres.text=latsecres.text=londegres.text=lonminres.text=lonsecres.text=""
              }
          }
          CheckBox{
              id:decim
              height: clr.height
              text:qsTr("Decimal")
              checked: false
              function check_viz(){
                  var ocoord = output_coord.currentText;
                  var icoord = input_coord.currentText;
              if (Db.unit_input(icoord)===true || Db.unit_output(ocoord)===true){
                  return true
              }
              else{
                  return false
              }
              }
              visible: check_viz()
           }
      }



      // to CustomComboBox
      Rectangle{
          id: toColumn
          color: "transparent"
          height: toprect2.implicitHeight
          width: parent.width
          Row {
              id:toprect2
              width: parent.width
              spacing: 1
              Layout.alignment: Qt.AlignHCenter
              Rectangle{
                  id:rectyes2
                  color:"transparent"
                  width:35
                  height: parent.height
                  SText{
                      id:label1
                      text: "to: "
                      width:parent.width
                      height: parent.height;
                  }
              }
              CustomComboBox{
                  id: output_coord
                  width:optionswgs.width-rectyes2.width - 15
                  currentIndex: 0
                  model: SharedXY.cogoOutputModel
                  onCurrentTextChanged: {
                      var ocoord = output_coord.currentText;
                  }
              }
          }
      }


          //-----------Result-------------------------------------
          ColumnLayout{
              Layout.alignment: Qt.AlignHCenter
              Layout.fillWidth: true
              id:toprow2
              // North East
              Grid {
                  id:grid_utm
                  width: parent.width
                  rowSpacing: 5
                  columnSpacing: 5
                  columns:2
                  rows:2
                  function viz_out(){
                      var ocoord = output_coord.currentText;
                      if ( Db.unit_output(ocoord)!==true){
                           return true
                      }
                      else{
                          return false
                      }
                  }
                  visible: viz_out()

                  layoutDirection: Calc.coord_display()

                  Row{
                      spacing: 6
                      SText{text: Calc.textN() + ": ";  height: my_row.height; }
                      STextField{id:nres; readOnly:true}
                  }

                  Row{
                      spacing: 6
                      SText{text: Calc.textE() + ": ";  height: my_row.height; }
                      STextField{id:eres; readOnly:true}
                  }
              }

              // LAT/LON DECIMAL
              Grid {
                  Layout.alignment: Qt.AlignHCenter
                  width: parent.width
                  function vizz22(){
                      var ocoord = output_coord.currentText;
                      if (decim.checked===true && Db.unit_output(ocoord)===true){
                           return true
                      }
                      else{
                          return false
                      }
                  }
                  visible: vizz22()
                  id:result_decimal_grid
                  rowSpacing: 5
                  columnSpacing: 5
                  columns:2
                  rows:2

                  SText{anchors.margins: 1;  text: qsTr("Latitude:"); height: my_row.height; }

                  STextField{id:latres; placeholderText: qsTr("°"); readOnly:true}

                  SText{anchors.margins: 1;  text: qsTr("Longitude:"); height: my_row.height; }

                  STextField{id:lonres;placeholderText: qsTr("°"); readOnly:true}
              }
              // LAT/LON DMS
              Grid {
                  id:mygrid5
                  rowSpacing: 5
                  columnSpacing: 5
                  columns:4
                  width: parent.width
                  rows:2
                      function text_viz(){
                          var ocoord = output_coord.currentText;
                      if (decim.checked===false && Db.unit_output(ocoord)===true){
                          return true
                      }
                      else{
                          return false
                      }
                      }
                 visible: text_viz()

                     SText{id:matext22; text: qsTr("Latitude: ");  height: my_row.height; }
                     STextField{id:latdegres;placeholderText: qsTr("°"); implicitWidth: 35; readOnly:true}
                     STextField{id:latminres;placeholderText: qsTr("'"); implicitWidth: 35; readOnly:true}
                     STextField{id:latsecres;placeholderText: qsTr("''"); implicitWidth: 100; readOnly:true}
                     SText{id:matext2_son; text: qsTr("Longitude: ");  height: my_row.height; }
                     STextField{id:londegres;placeholderText: qsTr("°"); implicitWidth: 35; readOnly:true}
                     STextField{id:lonminres;placeholderText: qsTr("'"); implicitWidth: 35; readOnly:true}
                     STextField{id:lonsecres;placeholderText: qsTr("''"); implicitWidth: 100; readOnly:true}
              }
      }

              // Accuracy
              RowLayout{
                  width: parent.width
                  spacing: 1
                  Layout.alignment: Qt.AlignHCenter
                  SText{
                      id: acrc
                      visible: Db.startgps(SharedXY.mycount)
                      text: "Accuracy: " + parseFloat((src.position.horizontalAccuracy).toFixed(2)) + " m"
                      font.italic: true
                  }
              }

}
      }
}
