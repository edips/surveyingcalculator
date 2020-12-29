import QtQuick 2.12 as QQ
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Universal 2.12
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import "components/common"
import "components/common/script.js" as Js
import "."
//import QtAndroidTools 1.0

FluidControls.ApplicationWindow {
    // Settings loader visibility
    property bool loaderVisible: false
    // About loader visible
    property bool loaderAboutVisible: false
    id: windoww
    visible:true
    title: "Surveying Calculator"
    visibility: Window.AutomaticVisibility
    // font loader
    font.family : "Roboto"
    width: 480
    height: 720
    // Count of the app action icons
    appBar.maxActionCount: 1
    Universal.theme: Universal.Light
    Universal.accent: "#003B6D"
    //Universal.background: Universal.chromeMediumLowColor

    // snack bar
    FluidControls.SnackBar { id: snack }
    QQ.Component.onCompleted: {
        console.log( "__loader.isGeographic() in func: ", __loader.isGeographic() )
        // banner makes the app slow, is there any way to load it asyncroniously? for example the app opens on Galaxy a5 in 2.5 secons
        // without banner2.show the start up time is 2.0 seconds
        //banner2.show();
    }

    QQ.Loader{
        id: about
        anchors.fill: parent
        source: loaderAboutVisible ? "components/common/DialogAbout.qml" : ""
    }
    QQ.Loader{
        id: dialog_settings
        anchors.fill: parent
        source: loaderVisible ? "components/common/DialogSettings.qml" : ""
    }
    // Initial Main Page
    initialPage: FluidControls.Page {
        title: windoww.title
        MainMenu{}
        /*Loader{
            layer.enabled: true
            anchors.fill: parent
            source: "LocationCalculus.qml"
        }*/
        id:initPage
        actions: [
            FluidControls.Action {
                id:setAction
                hasDividerAfter: true
                checkable: false
                toolTip: qsTr("Settings")
                icon.source: "qrc:/assets/icons/material/action/settings.svg"
                onTriggered: {
                    loaderVisible = true
                    dialog_settings.item.settingsPage.open()
                }
            },
            FluidControls.Action {
                hasDividerAfter: true
                id:aboutAction
                text: qsTr("About")
                icon.source: "qrc:/assets/icons/material/action/info_outline.svg"
                onTriggered: {
                    loaderAboutVisible = true
                    about.item.open()
                }
            }
        ]
    }

    // Close the app ToolTip
    property bool alreadyCloseRequested: false
    onClosing: {
        if(__androidUtils.isAndroid){
            if( !alreadyCloseRequested )
            {
                __androidUtils.showToast( "Press back again to exit" )
                close.accepted = false
                alreadyCloseRequested = true
                closingTimer.start()
            }
            else
            {
                close.accepted = true
            }
        }else{
            close.accepted = true
        }
    }

    QQ.Timer {
        id: closingTimer
        interval: 2000
        onTriggered: {
            alreadyCloseRequested = false
        }
    }
}
