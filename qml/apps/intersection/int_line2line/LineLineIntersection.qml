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
import "line.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
import "../../../components/gis"

Item{
    SFlickable{
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings {
            id:my_first
            property alias line1: pt_a.north_txt
            property alias line2: pt_a.east_txt
            property alias line3: pt_au.north_txt
            property alias line4: pt_au.east_txt
            property alias line5: pt_b.north_txt
            property alias line6: pt_b.east_txt
            property alias line7: pt_bu.north_txt
            property alias line8: pt_bu.east_txt
            property alias line9:yp.text
            property alias line10:xp.text
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
                    if( selected && coordName === "pt_a" ) {
                        pt_a.east.text = xCoord
                        pt_a.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_au" ) {
                        pt_au.east.text = xCoord
                        pt_au.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_b" ) {
                        pt_b.east.text = xCoord
                        pt_b.north.text = yCoord
                        selected = false
                    }
                    else if( selected && coordName === "pt_bu" ) {
                        pt_bu.east.text = xCoord
                        pt_bu.north.text = yCoord
                        selected = false
                    }
                }
            }
        }

        Column{
            id:optionsColumn
            spacing: 10
            anchors.fill : parent
            anchors.topMargin    : 15
            anchors.bottomMargin : 15
            anchors.leftMargin :15
            anchors.rightMargin  : 15
            // coordinate header NE OR XY
            NEHeader {}
            // Point A
            NorthEastP{
                id: pt_a
                name: "A"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_a"
                    loadComponent.item.open()
                }
            }
            // Point A'
            NorthEastP{
                id: pt_au
                name: "A'"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_au"
                    loadComponent.item.open()
                }
            }
            // Point B
            NorthEastP{
                id: pt_b
                name: "B"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_b"
                    loadComponent.item.open()
                }
            }
            // Point B'
            NorthEastP{
                id: pt_bu
                name: "B'"
                mapBtn.onClicked: {
                    // send property to mapView component to detect which button is clicked
                    loadComponent.active = true
                    loadComponent.item.coordName = "pt_bu"
                    loadComponent.item.open()
                }
            }
            //Hesap Form
            Hesapla {
                id: hesap_btn
                anchors.horizontalCenter: parent.horizontalCenter
                // Calculate the result
                hesap.onClicked: Hesap.linecalc()
                // Clear all text fields
                clear_list: [ pt_a.north, pt_a.east, pt_b.north, pt_b.east, pt_au.north, pt_au.east, pt_bu.north, pt_bu.east, xp, yp ]
                clear.onClicked:{
                    clearAll();
                }
            }
            Row{
                id:row
                anchors.horizontalCenter: parent.horizontalCenter
                layoutDirection: Calc.coord_display()
                spacing:5
                Row{
                    SText {text: Calc.textN() + "P: "; }
                    STextField{id:xp; readOnly:true}
                }
                Row{
                    SText {text: Calc.textE() + "P: "; }
                    STextField{id:yp; readOnly:true}
                }
            }
            Rectangle{
                height:geri.height
                width:geri.width
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    width: 250
                    //height: 200
                    fillMode: Image.PreserveAspectFit
                    id:geri
                    source:"qrc:/assets/images/line2line.png"
                }
            }
        }
    }
}
