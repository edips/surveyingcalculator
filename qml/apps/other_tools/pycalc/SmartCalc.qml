import QtQuick 2.9
import QtQuick.Controls 2.2
import QtWebView 1.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Universal 2.0
import Fluid.Controls 1.0

Item{
    id: my_page
    Shortcut
        {
            sequences: ["Esc", "Back"]
            enabled: webViewUrl.canGoBack
            onActivated:
            {
                webViewUrl.goBack(); //or any other action
            }
        }

        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            id:optionsColumn
            spacing: 5
            anchors.fill : parent
            anchors.topMargin    : 5
            anchors.bottomMargin : 5
            anchors.leftMargin :5
            anchors.rightMargin  : 5
        WebView {
            id: webViewUrl
            url: "file:///android_asset/html/python.html"
            width: parent.width
            height: parent.height
        }
        }
}

