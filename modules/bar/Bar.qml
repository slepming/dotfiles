import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
    model: Quickshell.screens
    delegate: Component {
        Item {
            id: root
            required property var modelData
            width: 35
            PanelWindow {
                id: bar
                screen: root.modelData
                WlrLayershell.namespace: "widget"
                color.r: 0
                color.b: 0
                color.g: 0
                color.a: 0.1
                implicitWidth: root.width

                anchors {
                    top: true
                    left: true
                    bottom: true
                }

                ClockWidget {}
                Tray {}
            }
        }
    }
}
