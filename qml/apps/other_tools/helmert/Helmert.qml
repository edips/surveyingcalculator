/***************************************************************************
  Copyright            : (C) 2021 by Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../../components/common/script.js" as Calc
import "helmert.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
import "../../../components/gis"
Item {
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)

        Settings{
            id:my_first
            property alias helmert1: pt_a.north_txt
            property alias helmert2: pt_a.east_txt
            property alias helmert3: pt_b.north_txt
            property alias helmert4: pt_b.east_txt
            property alias helmert5: pt_pu.north_txt
            property alias helmert6: pt_pu.east_txt
            property alias helmert7: pt_au.north_txt
            property alias helmert8: pt_au.east_txt
            property alias helmert9: pt_bu.north_txt
            property alias helmert10: pt_bu.east_txt
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
                    if( selected && coordName === "pt_au" ) {
                        pt_au.east.text = xCoord
                        pt_au.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_bu" ) {
                        pt_bu.east.text = xCoord
                        pt_bu.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_pu" ) {
                        pt_pu.east.text = xCoord
                        pt_pu.north.text = yCoord
                        selected = false
                    }

                    else if( selected && coordName === "pt_a" ) {
                        pt_a.east.text = xCoord
                        pt_a.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_b" ) {
                        pt_b.east.text = xCoord
                        pt_b.north.text = yCoord
                        selected = false
                    }
                }
            }
        }

        Column{
            id:optionsColumn
            spacing: 5
            anchors.fill : parent
            anchors.topMargin    : 15
            anchors.bottomMargin : 15
            anchors.leftMargin :15
            anchors.rightMargin  : 15
            NEHeader {}

            // Point A pt_au
            NorthEastP {
                id: pt_au
                name: "A"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_au"
                    loadComponent.item.open()
                }
            }
            // Point B pt_bu
            NorthEastP {
                id: pt_bu
                name: "B"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_bu"
                    loadComponent.item.open()
                }
            }
            // Point P pt_pu
            NorthEastP {
                id: pt_pu
                name: "P"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_pu"
                    loadComponent.item.open()
                }
            }
            // Point A' pt_a
            NorthEastP {
                id: pt_a
                name: "A'"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_a"
                    loadComponent.item.open()
                }
            }
            // Point B' pt_b
            NorthEastP {
                id: pt_b
                name: "B'"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_b"
                    loadComponent.item.open()
                }
            }

            //Hesap Form
            Hesapla {
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.helmertcalc()
                // Clear all text fields
                clear_list: [ pt_a.north, pt_a.east, pt_b.north, pt_b.east, pt_au.north, pt_au.east, pt_bu.north, pt_bu.east, pt_pu.north, pt_pu.east, np, ep ]
                clear.onClicked:{
                    clearAll();
                }
            }

            NEHeader {}

            Row{
                id:row
                anchors.horizontalCenter: parent.horizontalCenter
                SText {text: "P' ";}
                spacing: 5
                Row{
                    layoutDirection: Calc.coord_display()
                    spacing: 10
                    STextField{id:np; readOnly:true}
                    STextField{id:ep; readOnly:true}
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                height:geri.height
                width:geri.width
                color: "transparent"
                Image {
                    id:geri
                    width: 280
                    //height: 300
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/helmert.png"
                }
            }
        }
    }
}
