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
            width: Configuration.horizontal ? modelData.width * 0.992 : modelData.width * 0.03

            PanelWindow {
                id: bar
                screen: root.modelData
                WlrLayershell.namespace: "widget"
                implicitWidth: root.width
                implicitHeight: Configuration.horizontal ? 50 : root.height
                color.a: 0
                property bool horizontal: Configuration.horizontal
                margins {
                    left: !horizontal
                    top: horizontal
                }

                anchors {
                    top: true
                    left: !horizontal
                    bottom: !horizontal
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
                        anchors.leftMargin: Configuration.horizontal ? 25 : 6.5
                        anchors.topMargin: Configuration.horizontal ? parent.height / 2 - 30 / 2 : 25

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
