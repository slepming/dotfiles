import "../../config"
import "Components/"
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

Rectangle {
    anchors.leftMargin: 4
    anchors.topMargin: 25
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    Column {
        spacing: 15
        add: Transition {
            NumberAnimation {
                properties: "scale"
                from: 0
                to: 1
                duration: 200
            }
        }
        Repeater {
            id: items

            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}
