import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                WlrLayershell.namespace: "widget"
                required property var modelData
                screen: modelData
                color.r: 0
                color.b: 0
                color.g: 0
                color.a: 0.1
                width: 30

                anchors {
                    top: true
                    left: true
                    bottom: true
                }

                implicitHeight: 30
                ClockWidget {}
            }
        }
    }
}
