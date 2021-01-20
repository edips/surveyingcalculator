/***************************************************************************
  Copyright            : (C)  Lutra Consulting
  Modified by          : Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import QgsQuick 0.1 as QgsQuick

Popup {
    id: featurePanel
    focus: true
    modal: true
    Component.onCompleted: forceActiveFocus()
    height: parent.height + FluidCore.Device.gridUnit
    width: parent.width
    visible: false
    closePolicy: Popup.CloseOnEscape // prevents the drawer closing while moving canvas
    padding: 0


    property var mapSettings
    property var project
    property alias state: featureForm.state
    property alias feature: attributeModel.featureLayerPair
    property alias currentAttributeModel: attributeModel

    function show_panel(feature, state) {
        featurePanel.feature = feature
        featurePanel.state = state
        featurePanel.visible = true
    }

    QgsQuick.FeatureForm {
        id: featureForm

        // using anchors here is not working well as
        width: featurePanel.width
        height: featurePanel.height
        externalResourceHandler: externalResourceBundle.handler

        model: QgsQuick.AttributeFormModel {
            attributeModel: QgsQuick.AttributeModel {
                id: attributeModel
            }
        }

        project: featurePanel.project

        toolbarVisible: true

        onSaved: {
            featurePanel.visible = false
        }
        onCanceled:
        {
            featurePanel.visible = false
        }
    }

    ExternalResourceBundle {
        id: externalResourceBundle
    }

}
