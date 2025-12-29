pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias battery: adapter.battery

    FileView {
        id: configFile
        path: Nav.config
        watchChanges: true

        JsonAdapter {
            id: adapter

            property bool battery: false
        }
    }
}
