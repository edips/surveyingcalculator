// Author: Edip AHmet Taşkın
// Copy Right Edip Ahmet Taşkın

/* TODO
  * Refactor, collect javascript and use it, it can be stored in script.js
  * Code optimization is needed. When a project is done, after an action run, destructor must destruct or clean things and it should reload things again
*/

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.settings 1.1
import QtQuick.Dialogs 1.2
import QgsQuick 0.1 as QgsQuick
import lc 1.0
import "../../components/common"
import "../../components/common/script.js" as Util

Rectangle {
    id: projectsPanel
    visible: projVisibility
    focus: true
    color: "white"

    signal itemClicked();
    signal menuClicked();
    property bool disabled: false
    property int activeProjectIndex: -1
    property int tempIndex: -1
    property string tempPath
    property string activeProjectPath: __projectsModel.data(__projectsModel.index(activeProjectIndex), ProjectModel.Path)
    property string activeProjectName: __projectsModel.data(__projectsModel.index(activeProjectIndex), ProjectModel.Name)
    property bool projVisibility : {
        if(mycount_map%2===0){
            return true
        }
        else if(mycount_map%2===1){
            return false
        }
    }
    function openPanel() {
        if(mycount_map%2===0){
        projVisibility = true
        }
        else if(mycount_map%2===1){
            projVisibility = false
        }
    }
    function openPanelIcon(){
        if(projectsPanel.visible === true){
         return "navigation/close"
        }
        else{
            return "maps/map"
        }
    }

// Text color chooser white or black
    function lightDark(background, darkColor, lightColor) {
        return isDarkColor(background) ? lightColor : darkColor
    }
    function isDarkColor(background) {
        var temp = Qt.darker(background, 1) //Force conversion to color QML type object
        var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);
        return temp.a > 0 && a >= 0.3
    }

    Component.onCompleted: {
        console.log("---------------current index is: ", activeProjectIndex)

        // load model just after all components are prepared
        // otherwise GridView's delegate item is initialized invalidately
        grid.model = __projectsModel
    }

    Column{
        id:optionsC
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        Rectangle{
            color: Universal.primaryColor
            height: 30
            width: parent.width
            anchors.leftMargin: 10
            anchors.topMargin: 10
            id:lblrect
        Text{
            anchors.left:parent.left
            leftPadding: 15
            anchors.fill: parent
            text:"Select Project to display"
            color:Util.lightDark(Universal.foreground, "black", "white")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 13
        }
        }

// ListView of Projects---------------------------------------------
        Rectangle{
            height: parent.height-40
            width: parent.width
            color: "transparent"
        ListView {
            id:grid
            width: parent.width
            height: parent.height
            focus: true
            interactive: true
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            delegate: FluidControls.ListItem {
                id:listItem
                height: 61 // we get this height from another ProjectPanel as listItem.height
                property string projectName: name
                //text: projectName
                SText {
                    text: projectName
                    font.pixelSize: 15
                    font.bold: false
                    leftPadding: 50
                    width: parent.width - 60
                    clip: true
                    anchors.verticalCenter: parent.verticalCenter
                    color: listItem.highlighted ? Universal.accent
                                                       : Universal.foreground
                }
                icon.source:"qrc:/assets/icons/material/maps/map.svg"

                highlighted: {
                    if (disabled) return true
                    //console.log("project path = ", projectsPanel.activeProjectPath, " and project name = ", projectsPanel.activeProjectName)
                    return path === projectsPanel.activeProjectPath ? true : false
                }
                onClicked: {
                    mycount_map++
                    projectsPanel.activeProjectIndex = index
                    // disabled AppSettings because Project is admin, this is just a viewer. It shouldn't affect selection of a job.
                    //__appSettings.defaultProject = path
                    projVisibility = false
                    projectsPanel.activeProjectIndexChanged()
                    __layersModel.reloadLayers()
                }
            }
// No project found message text
            Label {
                anchors.fill: parent
                leftPadding: 10
                rightPadding: 10
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                visible: parent.count == 0
                text: qsTr("No project found.")
                font.pixelSize: 18
                font.bold: true
                wrapMode: Label.WordWrap
            }
            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }
    }
}
