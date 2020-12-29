pragma Singleton
import QtQuick 2.0
import QtQuick.Controls 2.12
import "components"

QtObject {
    property ListModel cogoInputModel: CoordInputModel{}
    property ListModel cogoOutputModel: CoordOutputModel{}
    property int mycount: 0;
}
