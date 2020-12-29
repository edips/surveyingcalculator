import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Calculation of Parcel Error"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
SColumnHelp{
    id:optionsColumn

    STextHelp{
            stext:qsTr("
Sometimes parcel areas can be registered to title deeds(land registry or property register)
 by mistake or parcel areas may be miscalculated by digitizing cadastral map sheets or by planimetric methods.
In order to detect miscalculated areas this tool is used. If it exceeds error limit, parcel area is written red,
elsewhere it is green. The calculation of error limit of parcel may vary from country to country.
If the calculation formula below is suitable for your cadastre law you can use this tool for checking parcel areas.
 <br><br><b>k</b>: error limit<br>
 <b>s</b>: map scale<br>
 <b>t</b>: area of title deed<br>
 <b>f</b>: calculated area<br><br>
If area of title deed is calculated by digitizing cadastre map sheet:
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sins2d1.height
        width:sins2d1.width
        color: "transparent"
        Image {
            id:sins2d1
            height: 32
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/tecviz/digitized.png"
        }
    }
    STextHelp{
            stext:qsTr("
<br>If area of title deed is calculated with planimetric method:
")
    }
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        height:sins2d.height
        width:sins2d.width
        color: "transparent"
        Image {
            id:sins2d
            height: 32
            fillMode: Image.PreserveAspectFit
            source:"qrc:/assets/images/help/tecviz/planimetric.png"
        }
    }

    STextHelp{
            stext:qsTr("
<br>If <b>k > |t-f|<qsTr(/b> error limit exceeds.
")
    }
}
    }
}
