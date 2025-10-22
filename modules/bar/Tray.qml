import "../../config"
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

Item {
    anchors.leftMargin: 4
    anchors.topMargin: 25
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    Column {
        spacing: 15
        IconImage {
            source: `${Paths.config}/arch.png`
            implicitSize: 25
        }
        Repeater {
            model: SystemTray.items.values
            delegate: IconImage {
                source: modelData.icon
                implicitSize: 25
            }
        }
    }
}
