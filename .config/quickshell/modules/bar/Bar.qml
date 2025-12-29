import Quickshell
import Quickshell.Wayland
import Quickshell.Services.UPower
import "./Components"
import "../../config/"
import QtQuick

Variants {
    model: Quickshell.screens
    delegate: Component {

        Item {
            id: root
            required property var modelData
            width: 40

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

                Tray {
                    anchors.leftMargin: 4
                    anchors.topMargin: 25
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                Battery {
                    visible: Configuration.battery
                }
            }
        }
    }
}
