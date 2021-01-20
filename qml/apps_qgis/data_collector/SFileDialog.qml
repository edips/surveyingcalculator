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

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.2

Dialog{
    width: parent.width
    height: 500
    anchors.centerIn: parent
    Rectangle {
        id: mainRect
        width: parent.width
        height: parent.height - 100
        ListView {
            width: parent.width
            height: parent.height
            clip: true
            model: FolderListModel {
                id: folderListModel
                showDirsFirst: true
                nameFilters: ["*"]
                rootFolder: "file:///sdcard/Surveying_Calculator/yr/John_Snow"
                folder: "file:///sdcard/Surveying_Calculator/yr/John_Snow"
            }

            delegate: Button {
                width: parent.width
                height: 50
                text: fileName
                onClicked: {
                    if (fileIsDir) {
                        folderListModel.folder = fileURL
                        // fileURL starts with: file:///
                        console.log("File URL is: ", fileURL)
                    }
                    console.log("File Path: ", filePath)
                    console.log("File Name: ", fileName)
                    console.log("File base name: ", fileBaseName)
                    console.log("File suffix: ", fileSuffix)
                    console.log("file is dir? ", fileIsDir)

                    //filePath
                    if(__loader.addVectorLayer(filePath))
                        console.log("ok, layer added")

                }
                background: Rectangle {
                    color: fileIsDir ? "orange" : "gray"
                    border.color: "black"
                }
            }
        }
    }
    Button {
        anchors.leftMargin: 5
        anchors.top: mainRect.bottom
        text: "back"
        onClicked: {
            folderListModel.folder = folderListModel.parentFolder
            console.log("folderListModel.folder.toString(): ", folderListModel.folder.toString())
        }
    }
}
