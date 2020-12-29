import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0 as FluidControls
import "../../../components/common/script.js" as Calc
import "third.js" as Hesap
import Qt.labs.settings 1.1
import "../../../components/common"
Item{
    SFlickable {
        id:optionsPage
        contentHeight: Math.max(optionsColumn.implicitHeight+65, height)
        Settings{
            id:my_first
            property alias tbcg_to3_dec: bcg_to3.decimal_txt
            property alias tbcg_to3_deg: bcg_to3.degree_txt
            property alias tbcg_to3_min: bcg_to3.minute_txt
            property alias tbcg_to3_sec: bcg_to3.second_txt
            property alias tbcg_to3_gon: bcg_to3.gon_txt
            property alias tabg_to3_dec: abg_to3.decimal_txt
            property alias tabg_to3_deg: abg_to3.degree_txt
            property alias tabg_to3_min: abg_to3.minute_txt
            property alias tabg_to3_sec: abg_to3.second_txt
            property alias tabg_to3_gon: abg_to3.gon_txt
            property alias tbeta_to3_dec: beta_to3.decimal_txt
            property alias tbeta_to3_deg: beta_to3.degree_txt
            property alias tbeta_to3_min: beta_to3.minute_txt
            property alias tbeta_to3_sec: beta_to3.second_txt
            property alias tbeta_to3_gon: beta_to3.gon_txt
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
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                SText {text: "(AB): "; }
                SAngle{id:abg_to3}
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                SText {text: "β=(ABC): "; }
                SAngle{id:beta_to3}
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:50
                Button {
                    id:hesapla_to3
                    width: 50
                    highlighted: true
                    onClicked: Hesap.thirdcalc()
                    Image {
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        width: 40
                        source: "qrc:/assets/images/equal.png"
                    }
                }
                Button {
                   id:c
                   width: 40
                   icon.source: "qrc:/assets/icons/material/content/clear.svg"
                   onClicked: Calc.angle_clear([bcg_to3,abg_to3,beta_to3])
                }
            }
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5

                Row{
                    SText {text: "(BC): "; }
                    SAngle{read_only: true; id:bcg_to3}
                }
                Rectangle{
                    id:reco
                    height:geri.height
                    width:geri.width
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        width: 250
                        fillMode: Image.PreserveAspectFit
                        id:geri
                        source:"qrc:/assets/images/third.png"
                    }
                }
            }
        }
    }
}
