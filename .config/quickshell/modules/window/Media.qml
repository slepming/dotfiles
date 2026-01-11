import Quickshell
import Quickshell.Hyprland
import QtQuick
import "./Components/"

PanelWindow {
    id: root
    property real margin: 5
    implicitWidth: 500
    implicitHeight: 500
    visible: false
    anchors.top: true
    anchors.right: true
    focusable: true

    color {
        r: 0.2
        b: 0.2
        g: 0.2
        a: 1
    }

    GlobalShortcut {
        name: "openMedia"
        description: "Open media panel window for bar"

        onReleased: {
            root.visible = !root.visible;
        }
    }
    Wifi {
        margin: 10
    }
}
