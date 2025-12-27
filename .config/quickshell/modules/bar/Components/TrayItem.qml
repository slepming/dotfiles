import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

Rectangle {
    id: root
    color.a: 0

    required property SystemTrayItem modelData

    width: 10
    height: 30

    IconImage {
        id: image
        source: root.modelData.icon
        implicitSize: 25
        asynchronous: true
    }
}
