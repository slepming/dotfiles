import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: 80
    height: 80
    property real margin: 5
    x: margin
    y: margin

    property int signal: 0
    property bool wifiEnabled: false
    property string ssid: ""

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Item {
            id: icon
            anchors.centerIn: parent
            width: 50
            height: 40

            Repeater {
                model: 4

                Rectangle {
                    width: 8
                    height: (index + 1) * 8
                    radius: 2

                    x: index * 12
                    y: parent.height - height

                    color: {
                        if (!wifiEnabled)
                            return "#444";
                        return signalLevel() > index ? "black" : "green";
                    }
                }
            }
        }
    }

    function signalLevel() {
        if (signal >= 75)
            return 4;
        if (signal >= 50)
            return 3;
        if (signal >= 25)
            return 2;
        if (signal > 0)
            return 1;
        return 0;
    }

    Process {
        id: wifiProcess
        running: true
        command: ["bash", "-c", "nmcli radio wifi; nmcli -t -f IN-USE,SIGNAL,SSID dev wifi | grep '^\\*' || true"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");

                wifiEnabled = lines[0] === "enabled";

                if (lines.length > 1 && lines[1].startsWith("*")) {
                    const parts = lines[1].split(":");
                    signal = parseInt(parts[1]) || 0;
                    ssid = parts[2] || "";
                } else {
                    signal = 0;
                    ssid = "";
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            wifiProcess.running = !wifiProcess.running;
        }
    }
}
