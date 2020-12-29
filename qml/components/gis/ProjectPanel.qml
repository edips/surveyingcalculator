// Author: Edip AHmet Taşkın
// Copy Right Edip Ahmet Taşkın

/* TODO
  * Refactor, collect javascript and use it, it can be stored in script.js
  * Code optimization is needed. When a job is done, after an action run, destructor must destruct or clean things and it should reload things again
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
import "../common"
import "../common/script.js" as Util

Rectangle {
    id: projectsPanel
    visible: false
    focus: true
    color: "white"

}
