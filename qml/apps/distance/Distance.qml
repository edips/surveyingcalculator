import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.1
import "../../components/common/script.js" as Calc
import "distance.js" as Hesap
import "../../apps/other_tools/libs/geographiclib.js" as MyGeo
import "../../components/common"
import "../../components/gis"
/*
TODO:
- fix bearing
*/
Item{
    Settings{
        id:mycombooo
        property alias dist_combo: ucd.currentIndex
        // Latitude and longitude
        property alias latdeg1: dist_latlon1.latdeg_txt
        property alias latmin1: dist_latlon1.latmin_txt
        property alias latsec1: dist_latlon1.latsec_txt
        property alias latdeg2: dist_latlon2.latdeg_txt
        property alias latmin2: dist_latlon2.latmin_txt
        property alias latsec2: dist_latlon2.latsec_txt
        property alias londeg1: dist_latlon1.londeg_txt
        property alias lonmin1: dist_latlon1.lonmin_txt
        property alias lonsec1: dist_latlon1.lonsec_txt
        property alias londeg2: dist_latlon2.londeg_txt
        property alias lonmin2: dist_latlon2.lonmin_txt
        property alias lonsec2: dist_latlon2.lonsec_txt
        // Remove it for Surveying Calculator
        //property alias decimal_check: decim.checked

        property alias londec1: dist_latlon1.lon_decimal_txt
        property alias londec2: dist_latlon2.lon_decimal_txt
        property alias latdec1: dist_latlon1.lat_decimal_txt
        property alias latdec2: dist_latlon2.lat_decimal_txt
        // Distance 2D
        property alias easting1:       dist2d_1.east_txt
        property alias northing1:      dist2d_1.north_txt
        property alias easting2:       dist2d_2.east_txt
        property alias northing2:      dist2d_2.north_txt
        // Distance 3D
        property alias easting1_3d:    dist3d_1.east_txt
        property alias northing1_3d:   dist3d_1.north_txt
        property alias z_kot1:         dist3d_1.elev_txt
        property alias easting2_3d:    dist3d_2.east_txt
        property alias northing2_3d:   dist3d_2.north_txt
        property alias z_kot2:         dist3d_2.elev_txt
        // Result
        // LatLOng result
        property alias dist_result:    dist.text

        // 2d bearing and distance
        property alias distance2d:    dist_2d.text
        property alias dsabg_to2_dec: abg_to2.decimal_txt
        property alias dsabg_to2_deg: abg_to2.degree_txt
        property alias dsabg_to2_min: abg_to2.minute_txt
        property alias dsabg_to2_sec: abg_to2.second_txt
        property alias dsabg_to2_gon: abg_to2.gon_txt
        // 3D Bearing and distance
        property alias dsabg_to2_decz: abg_to2_z.decimal_txt
        property alias dsabg_to2_degz: abg_to2_z.degree_txt
        property alias dsabg_to2_minz: abg_to2_z.minute_txt
        property alias dsabg_to2_secz: abg_to2_z.second_txt
        property alias dsabg_to2_gonz: abg_to2_z.gon_txt
        property alias dist33:         dist3dd.text
        property alias dist34:         hdist.text
        property alias dist35:         zdif.text
    }

    // Coordinate select from map dialog for LATITUDE LONGITUDE
    Loader {
        id: loadComponent
        anchors.fill: parent
        asynchronous: true
        active: false
        sourceComponent: macomponent
    }
    // Coordinate select from map dialog
    Component.onDestruction: loadComponent.active = false
    Component {
        id: macomponent
        CoordSelect {
            id: mapDialog
            onClosed: {
                if ( selected && coordName === "dist_latlon1" ) {
                    dist_latlon1.lat_decimal.text = yCoord
                    dist_latlon1.lon_decimal.text = xCoord
                    selected = false
                }
                else if ( selected && coordName === "dist_latlon2" ) {
                    dist_latlon2.lat_decimal.text = yCoord
                    dist_latlon2.lon_decimal.text = xCoord
                    selected = false
                }
                else if ( selected && coordName === "dist2d_1" ) {
                    dist2d_1.east.text = xCoord
                    dist2d_1.north.text = yCoord
                    selected = false
                }
                else if ( selected && coordName === "dist2d_2" ) {
                    dist2d_2.east.text = xCoord
                    dist2d_2.north.text = yCoord
                    selected = false
                }
            }
        }
    }

    SErrorDialog {
        id: errDialog
    }

    SFlickable {
        id:optionsPage
        contentHeight: dist_column.implicitHeight
        anchors.topMargin: 15
        // Main column
        Column{
            id: dist_column
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15
            width: parent.width
            // CustomComboBox
            Rectangle{
                id:comborect
                width: parent.width
                height:ucd.height
                color:"transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing:25
                    CustomComboBox {
                        id: ucd
                        currentIndex: 0
                        width: comborect.width - 20
                        height: 38
                        model: ListModel {
                            id: model
                            ListElement { text: "Horizontal Distance, Bearing" }
                            ListElement { text: "Sloped Distance" }
                            ListElement { text: "Lat/Long Distance" }
                        }
                        onAccepted: {
                            id:maccepted
                            if (find(editText) === -1)
                                model.append({text: editText})
                        }
                    }
                }
            }
            // Latitude Longitude distance
            Column{
                spacing: 10
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                visible: ucd.currentIndex==2
                LatLong{
                    id: dist_latlon1
                    text_lat: "Latitude1 : "
                    text_lon: "Longitude1 : "
                    mapBtn.onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "dist_latlon1"
                        coordinateSelector( loadComponent.item, errDialog )
                    }
                }
                LatLong {
                    id: dist_latlon2
                    text_lat: "Latitude2 : "
                    text_lon: "Longitude2 : "
                    mapBtn.onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "dist_latlon2"
                        coordinateSelector( loadComponent.item, errDialog )
                    }
                }
            }

            // 2D Distance
            Column{
                spacing: 5
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                visible: ucd.currentIndex==0
                NEHeader {}
                // Point A
                NorthEastP{
                    id: dist2d_1
                    name: "1"
                    mapBtn.onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "dist2d_1"
                        coordinateSelector( loadComponent.item, errDialog )
                    }
                }
                // Point B
                NorthEastP{
                    id: dist2d_2
                    name: "2"
                    mapBtn.onClicked: {
                        // send property to mapView component to detect which button is clicked
                        loadComponent.active = true
                        loadComponent.item.coordName = "dist2d_2"
                        coordinateSelector( loadComponent.item, errDialog )
                    }
                }
            }




            // 3D Distance
            Column{
                spacing: 3
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                visible: ucd.currentIndex==1
                NorthEast{
                    id: dist3d_1
                    n_txt: Calc.textN() + "1: "
                    e_txt: Calc.textE() + "1: "
                    z_txt: "Z1: "
                    z_enabled: true
                }
                NorthEast{
                    id: dist3d_2
                    n_txt: Calc.textN() + "2: "
                    e_txt: Calc.textE() + "2: "
                    z_txt: "Z2: "
                    z_enabled: true
                }
            }
            // Calculate
            Row{
                anchors.horizontalCenter: parent.horizontalCenter

                Hesap{
                    id: hesap_btn
                    decimalCheck: ucd.currentIndex === 2
                    // Calculate the result
                    hesap.onClicked: Hesap.distancecalc()
                    // Clear all text fields
                    clear_list: [
                        dist_latlon1.lat_deg, dist_latlon1.lat_min, dist_latlon1.lat_sec,
                        dist_latlon2.lat_deg, dist_latlon2.lat_min, dist_latlon2.lat_sec,
                        dist_latlon1.lon_deg, dist_latlon1.lon_min, dist_latlon1.lon_sec,
                        dist_latlon2.lon_deg, dist_latlon2.lon_min, dist_latlon2.lon_sec,
                        dist_latlon1.lon_decimal,dist_latlon2.lon_decimal,
                        dist_latlon1.lat_decimal,dist_latlon2.lat_decimal,
                        dist2d_1.east, dist2d_1.north,
                        dist2d_2.east, dist2d_2.north,
                        dist3d_1.easting,dist3d_1.northing,dist3d_1.elev,dist3d_2.easting,dist3d_2.northing,dist3d_2.elev,
                        dist,dist3dd,hdist,zdif, dist_2d, dist
                    ]
                    clear.onClicked:{
                        clearAll();
                        Calc.angle_clear([abg_to2])
                        Calc.angle_clear([abg_to2_z])
                        //Calc.angle_clear([bearing])
                        //Calc.angle_clear([arclen])
                    }
                }
            }
            // Result
            // LatLong
            Row{
                visible: ucd.currentIndex === 2
                anchors.horizontalCenter: parent.horizontalCenter
                Label {text: "Distance: "; font.pixelSize: 16; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                STextField{id:dist; implicitWidth: 150;font.pixelSize: 16; readOnly:true}
            }

            // dist_2d
            Column{
                spacing: 7
                visible: ucd.currentIndex === 0
                anchors.horizontalCenter: parent.horizontalCenter
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Label {text: "Distance: "; font.pixelSize: 14; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                    STextField{id:dist_2d; implicitWidth: 150;font.pixelSize: 16; readOnly:true}
                }
                Row{
                    Label {text: "Bearing: "; font.pixelSize: 14; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                    SAngle{read_only: true; id:abg_to2}
                }
            }
            // dist_3d
            Column{
                spacing: 7
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: 15
                visible: ucd.currentIndex === 1

                Row{
                    Label {text: "Sloped Dist.: "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                    STextField{id:dist3dd; implicitWidth: 150;font.pixelSize: 16; readOnly:true}
                }

                Row{
                    Label {text: "Horizontal Dist.:  "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                    STextField{id:hdist; implicitWidth: 150;font.pixelSize: 16; readOnly:true}
                }

                Row{
                    Label {text: "Height Difference: "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                    STextField{id:zdif; implicitWidth: 100;font.pixelSize: 16; readOnly:true}
                }

                Row{
                    Label {text: "Bearing: "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height;}
                    SAngle{read_only: true; id:abg_to2_z}
                }

            }
        }
    }
}
