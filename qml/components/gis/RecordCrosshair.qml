import QtQuick 2.7
import QgsQuick 0.1 as QgsQuick
import lc 1.0

Item {    
    id: root
    property real size:{
        if (__appSettings.autoCenterMapChecked){
            return 20
        }else{
            return 45
        }
    }

    Image {
        anchors.centerIn: parent
        height: root.size
        width: height
        source:{
            if (__appSettings.autoCenterMapChecked){
                "qrc:/assets/icons/crosshair2.svg"
            }else{
                "qrc:/assets/icons/crosshair.svg"
            }
        }
        sourceSize.width: width
        sourceSize.height: height
    }
}
