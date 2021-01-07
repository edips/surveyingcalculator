import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import "../../help"
import "../../components/common"
import "../../components/common/script.js" as Util

FluidControls.Page {
    // Loading pages
    function load_page () {
        if( ucd.currentIndex === 0 ) {
            return hDist
        }
        else if( ucd.currentIndex === 1 ) {
            return sDist
        }
        else if( ucd.currentIndex === 2 ) {
            return latlongDist
        }
        else if( ucd.currentIndex === 3 ) {
            return xyCalc
        }
        else if( ucd.currentIndex === 4 ) {
            return latlongCalc
        }
        else if( ucd.currentIndex === 5 ) {
            return bearingCalc
        }
        else if( ucd.currentIndex === 6 ) {
            return interiorAngle
        }
    }

    // Loading help pages
    function load_help_page () {
        if( ucd.currentIndex === 0 ) {
            return harizHelp
        }
        else if( ucd.currentIndex === 1 ) {
            return harizHelp
        }
        else if( ucd.currentIndex === 2 ) {
            return harizHelp
        }
        else if( ucd.currentIndex === 3 ) {
            return xyCalcHelp
        }
        else if( ucd.currentIndex === 4 ) {
            return xyCalcHelp
        }
        else if( ucd.currentIndex === 5 ) {
            return interiorHelp
        }
        else if( ucd.currentIndex === 6 ) {
            return bearingHelp
        }
    }

    id: basic_surveying
    appBar.maxActionCount: 1
    title: "Distance, Bearing"

    SFlickable {
        id:optionsPage
        contentHeight: dist_column.implicitHeight
        anchors.topMargin: 15

        // Main column
        ColumnLayout {
            id: dist_column
            spacing: 15
            width: parent.width

            // Menu
            ComboMenu {
                id: ucd
            }
            // Loading pages
            Loader {
                id: apploader
                Layout.fillWidth: true
                Layout.fillHeight: true
                sourceComponent: load_page ()
            }
            // Pages
            // Lat Long distance, azimuth
            Component {
                id: latlongDist
                LatLongDist {}
            }
            // Horizontal distance bearing
            Component {
                id: hDist
                HDist {}
            }
            // Sloped distance, bearing
            Component {
                id: sDist
                SlopedDist {}
            }
            // XY from distance, bearing
            Component {
                id: xyCalc
                XYCalc {}
            }
            // Latlong from distance, azimuth
            Component {
                id: latlongCalc
                LatLongCalc {}
            }
            // Bearing Calculation
            Component {
                id: bearingCalc
                BearingCalc {}
            }
            // Interior Angle
            Component {
                id: interiorAngle
                InteriorAngle {}
            }

            // Loading help Pages
            Loader {
                id: helploader
                Layout.fillWidth: true
                Layout.fillHeight: true
                sourceComponent: load_help_page()
                active: false
            }
            Component {
                id: harizHelp
                FirstHelp { parent: basic_surveying; onClosed: helploader.active = false }
            }
            Component {
                id: xyCalcHelp
                SecondHelp { parent: basic_surveying; onClosed: helploader.active = false }
            }

            Component {
                id: interiorHelp
                ThirdHelp { parent: basic_surveying; onClosed: helploader.active = false }
            }
            Component {
                id: bearingHelp
                FourHelp { parent: basic_surveying; onClosed: helploader.active = false }
            }
        }
    }

    actions: [
        FluidControls.Action {
            id:first_action2
            visible: false
            onTriggered: {
                helploader.active = true
                helploader.item.open()
            }

            icon.source: "qrc:/assets/icons/material/action/help_outline.svg"
            toolTip: qsTr("Help")
        }
    ]
}

