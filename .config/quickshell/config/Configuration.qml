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

        onFileChanged: {
            reload();
        }

        onLoaded: {
            try {
                JSON.parse(text());
            } catch (e) {
                console.error("failed to save config")
            }
        }
        onLoadFailed: err => {
            if (err !== FileViewError.FileNotFound)
                console.error("failed to save config")
        }
        onSaveFailed: err => console.error("failed to save config")
        JsonAdapter {
            id: adapter

            property bool battery: false
        }
    }
}
