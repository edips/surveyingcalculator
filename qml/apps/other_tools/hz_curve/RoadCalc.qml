import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import "../../../components/common/script.js" as Calc
import "roadcalc.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
Item{
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:my_first
            property alias rat_dec: at.decimal_txt
            property alias rat_deg: at.degree_txt
            property alias rat_min: at.minute_txt
            property alias rat_sec: at.second_txt
            property alias rat_gon: at.gon_txt
            property alias road2:rt.text
            property alias road3:tt.text
            property alias road4:lt.text
            property alias road5:bst.text
        }
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            id:optionsColumn
            spacing: 10
            anchors.fill : parent
            anchors.topMargin    : 15
            anchors.bottomMargin : 15
            anchors.leftMargin :15
            anchors.rightMargin  : 15
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10
            Row{
                SText {text: "α: ";}
                SAngle{id:at }
            }
            Row{
                SText {text: "R: ";}
                STextField{id:rt}
            }
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:50
            Button {
                id:hesaplak
                width: 50
                Image {
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    width: 40
                    source: "qrc:/assets/images/equal.png"
                }
                highlighted: true
                onClicked: Hesap.roadcalc()
            }
            Button {
                id:c
                width: 40
                icon.source: "qrc:/assets/icons/material/content/clear.svg"
                onClicked: {
                    tt.text=rt.text=lt.text=bst.text=""
                    Calc.angle_clear([at])
                }
            }
        }
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            Row{
                SText {text: "T: ";}
                STextField{id:tt; readOnly:true}
            }
            Row{
                SText {text: "L: ";}
                STextField{id:lt; readOnly:true;}
            }
            Row{
                SText {text: "BS: "}
                STextField{id:bst; readOnly:true;}
            }
        }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                height:geri.height
                width:geri.width
                color: "transparent"
                Image {
                    id:geri
                    width: 250
                    //height: 300
                    fillMode: Image.PreserveAspectFit
                    source:"qrc:/assets/images/karayolu.png"
                }
            }

         }
     }
}
