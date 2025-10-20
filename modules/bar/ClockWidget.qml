import Quickshell
import QtQuick

Item {
    id: widget_clock
    property string background: "#00ff8A40"
    property string borderColour: "#00323232"
    property alias textVisible: time.visible
    anchors.centerIn: parent
    rotation: 0
    width: parent.width
    height: parent.height / 3

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
        font.family: "FiraCodeNerdFont"
        font.bold: true
        font.pointSize: 13
        z: 1

        text: {
            Qt.formatDateTime(clock.date, "hh:\nmm:\nss");
        }
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "visible"

            NumberAnimation {
                target: time
                property: "width"
                duration: 100
                easing.bezierCurve: 0.755, 0.05, 0.855, 0.06
            }
        },
        Transition {
            from: "visible"
            to: ""

            NumberAnimation {
                target: time
                property: "width"
                duration: 200
                easing.bezierCurve: 0.755, 0.05, 0.855, 0.06
            }
        }
    ]
}
