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

import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1
import "../../components/common"
import "../../components/common/script.js" as Utils
import "js/dist3d.js" as Hesap

Column {
    Settings {
        id: mycombooo
        // Input
        property alias easting1_3d:    dist3d_1.east_txt
        property alias northing1_3d:   dist3d_1.north_txt
        property alias z_kot1:         dist3d_1.elev_txt
        property alias easting2_3d:    dist3d_2.east_txt
        property alias northing2_3d:   dist3d_2.north_txt
        property alias z_kot2:         dist3d_2.elev_txt
        // Result
        property alias dsabg_to2_decz: abg_to2_z.decimal_txt
        property alias dsabg_to2_degz: abg_to2_z.degree_txt
        property alias dsabg_to2_minz: abg_to2_z.minute_txt
        property alias dsabg_to2_secz: abg_to2_z.second_txt
        property alias dsabg_to2_gonz: abg_to2_z.gon_txt
        property alias dist33:         dist3dd.text
        property alias dist34:         hdist.text
        property alias dist35:         zdif.text
    }
    spacing: 15
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter

    NEHeader { has_z: true; rowspace: 80; leftPadding: 30; }
    NorthEastZ {
        id: dist3d_1
        name: "1"
    }
    NorthEastZ {
        id: dist3d_2
        name: "2"
    }

    // Calculation
    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        Hesapla {
            id: hesap_btn
            decimalCheck: false
            // Calculate the result
            hesap.onClicked: Hesap.calc3d()
            // Clear all text fields
            clear_list: [ dist3d_1.easting, dist3d_1.northing, dist3d_1.elev, dist3d_2.easting, dist3d_2.northing, dist3d_2.elev, dist3dd, hdist, zdif ]
            clear.onClicked:{
                clearAll();
                Utils.angle_clear( [ abg_to2_z ] )
            }
        }
    }
    // result
    Column {
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter
        visible: ucd.currentIndex === 1
        Row{
            Label {text: "Sloped Dist.: "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height; }
            STextField{id:dist3dd; implicitWidth: 150;font.pixelSize: 16; placeholderText: Utils.length_txt( ); readOnly: true; }
        }
        Row{
            Label {text: "Horizontal Dist.:  "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height; }
            STextField{id:hdist; implicitWidth: 150;font.pixelSize: 16; placeholderText: Utils.length_txt( ); readOnly: true; }
        }

        Row{
            Label { text: "Height Difference: "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height;}
            STextField{ id:zdif; implicitWidth: 100;font.pixelSize: 16; placeholderText: Utils.length_txt( ); readOnly: true; }
        }

        Row{
            Label { text: "Bearing: "; font.pixelSize: 13; verticalAlignment: Text.AlignVCenter; height: parent.height; }
            SAngle { id: abg_to2_z; read_only: true; }
        }

    }
}
