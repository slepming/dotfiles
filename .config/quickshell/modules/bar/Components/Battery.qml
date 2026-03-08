import "../../../config"
import Quickshell.Services.UPower
import QtQuick

Item {
    id: root
    anchors {
        bottom: parent.bottom
        left: Configuration.horizontal ? undefined : undefined
        right: Configuration.horizontal ? parent.right : undefined
        verticalCenter: Configuration.horizontal ? parent.verticalCenter : undefined
        horizontalCenter: Configuration.horizontal ? undefined : parent.horizontalCenter
        bottomMargin: !Configuration.horizontal ? 70 : 0
        rightMargin: Configuration.horizontal ? 100 : 0
    }

    Text {
        id: battery_text
        anchors.verticalCenter: Configuration.horizontal ? parent.verticalCenter : undefined
        anchors.horizontalCenter: Configuration.horizontal ? undefined : parent.horizontalCenter
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
