import Quickshell
import Quickshell.Services.UPower
import QtQuick

Item {
    id: root
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottomMargin: 25

    Text {
        id: battery_text
        anchors.centerIn: parent
        color.r: 255
        color.g: 255
        color.b: 255
        font {
            family: "FiraCodeNerdFont"
            bold: true
            pointSize: 13
        }
        z: 1

        text: {
            if (UPower.onBattery) {
                "%1%".arg(UPower.displayDevice.percentage * 100);
            } else {
                " ∞\n%1%".arg(UPower.displayDevice.percentage * 100);
            }
        }
    }
}
