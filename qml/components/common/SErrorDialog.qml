/***************************************************************************
  Copyright            : (C) 2021 by Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.AlertDialog {
    property string error;
    property string dialog_title;
    id: error_dialog
    title: "Error"
    modal: true
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    text: error
    width: parent.width
    height: 120 + dialog_text.implicitHeight
}
