import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    property real margin: 5
    x: margin
    y: margin
    implicitHeight: 50
    implicitWidth: 150
    Rectangle {
        anchors.fill: parent
        border {
            color {
                r: 0
                b: 0
                g: 0
                a: 1
            }
            width: 3
        }

        Text {
            id: internet
            anchors.centerIn: parent
            text: "Wifi Connection"

            Process {
                running: true
                command: ["nmcli", "-t", "-f DEVICE dev"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        internet.text = this.text || "Connection not found";
                    }
                }
            }
        }
    }
}
