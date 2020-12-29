import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
SDialog{
    id:alertt
    height: parent.height-15
    width: parent.width-30
    title: qsTr("Surveying Calculator 3.5")
    onClosed: {
        loaderAboutVisible = false
    }
    SFlickable{
        id:settings_flickable
        interactive: true
        anchors {
            bottom: rectbutton.top
        }
        contentHeight: column.implicitHeight
        Column {
            id: column
            anchors.fill: parent
            spacing: 10

            Label {
                onLinkActivated: Qt.openUrlExternally(link)
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Label.RichText
                font.pixelSize:14
                wrapMode: Label.WordWrap
                id:mylabel
                text:qsTr("Copyright © 2020 Edip Ahmet Taşkın<br>
User interface of the app is based on <a href=\"https://github.com/lirios/fluid\">Fluid QML Library</a> Many thanks to
<a href=\"https://liri.io/\">LiriOS & Fluid team</a>,
<a href=\"https://www.lutraconsulting.co.uk/\">Lutra Consulting</a> ,
and <a href=\"https://www.opengis.ch/\">OPENGIS.ch</a> for providing open source projects.
This app is improving with suggestions of users. Bugs are fixed with user's reports. You can mail to <a href='mailto:geosoft66@gmail.com'>geosoft66@gmail.com</a><br>.
You can get more information from these links:<br>
• Surveying Calculator videos on  <a href=\"https://www.youtube.com/playlist?list=PLZiS4HY11oVdN7jUd_PmBb4pYud3ieJbw\">YouTube</a><br>
• Join Surveying Calculator group to ask questions on <a href=\"https://www.facebook.com/groups/820226478150041/?ref=bookmarks\">Facebook Group</a><br>
• Follow news about the app on <a href=\"https://fb.me/surveyingcalculator\">Facebook Page</a>
"
                          )
            }


            FlatButton {
                id:delegate
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Rate Surveying Calculator")
                width: parent.width - 30
                icon.source: "qrc:/assets/icons/material/toggle/star_border.svg"
                onClicked: {
                    Qt.openUrlExternally("https://play.google.com/store/apps/details?id=org.project.geoclass&hl=tr")
                }
            }
            Label {
                onLinkActivated: Qt.openUrlExternally(link)
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Label.RichText
                font.pixelSize:14
                wrapMode: Label.WordWrap
                id:mylabel2
                text:qsTr("
<a href=\"https://edips.github.io/privacypolicy.html\">Privacy policy</a><br><br>
<a href=\"https://edips.github.io\">Developer Website</a><br>
")

            }



        }

    }
    Rectangle{
        id: rectbutton
        width: parent.width
        height: okbutton.height
        color: "transparent"
        anchors.bottom: parent.bottom
        FlatButton{
            id:okbutton
            anchors.horizontalCenter: parent.horizontalCenter
            width: 50
            height: 50
            text: "OK"
            onClicked: alertt.close()
        }
    }


}
