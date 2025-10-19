import Quickshell
import Quickshell.Wayland
import QtQuick

Item {
    id: widget_clock
    property string background: "#00E78A40"
    property string borderColour: "#00323232"
    anchors.centerIn: parent
    rotation: -90
    width: time.width + 15
    height: time.height + 5

    Rectangle {
        anchors.fill: parent
        color: widget_clock.background

        border.color: widget_clock.borderColour
        border.pixelAligned: true
        border.width: 2

        z: 0
        radius: 5
    }

    Text {
        id: time
        anchors.centerIn: parent
        color.r: 255
        color.g: 255
        color.b: 255
        z: 1

        text: {
            Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy");
        }
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }
}
