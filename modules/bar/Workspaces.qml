import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: 8

    Repeater {
        model: 9

        Text {
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            text: index + 1
            color: isActive ? "#ffffff" : (ws ? "#909090" : "dimgray")
            font {
                pixelSize: 19
                bold: true
                family: "FiraCodeNerdFont"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
        }
    }
    Item {
        Layout.fillHeight: true
    }
}
