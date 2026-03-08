import "Components/"
import "../../config"
import Quickshell.Services.SystemTray
import QtQuick

Rectangle {
    Column {
        visible: !Configuration.horizontal
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
            id: itemsColumn

            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
    Row {
        visible: Configuration.horizontal
        spacing: 30
        add: Transition {
            NumberAnimation {
                properties: "scale"
                from: 0
                to: 1
                duration: 200
            }
        }
        Repeater {
            id: itemsRow

            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}
