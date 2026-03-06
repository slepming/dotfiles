import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
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
                implicitWidth: root.width
                color.a: 0
                margins {
                    left: 1
                }

                anchors {
                    top: true
                    left: true
                    bottom: true
                }

                Rectangle {
                    color.r: 0
                    color.b: 0
                    color.g: 0
                    color.a: 0.3
                    radius: 20
                    implicitWidth: parent.implicitWidth
                    anchors.fill: parent

                    Tray {
                        anchors.leftMargin: 6.5
                        anchors.topMargin: 25
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                    }

                    ClockWidget {}

                    Battery {
                        visible: Configuration.battery
                    }
                }
            }
        }
    }
}
