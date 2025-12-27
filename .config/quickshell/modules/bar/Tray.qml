import "Components/"
import Quickshell.Services.SystemTray
import QtQuick

Rectangle {
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
