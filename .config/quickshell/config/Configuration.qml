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
                if (adapter.utilities.toasts.configLoaded)
                    Toaster.toast(qsTr("Config loaded"), qsTr("Config loaded in %1ms").arg(timer.elapsedMs()), "rule_settings");
            } catch (e) {
                Toaster.toast(qsTr("Failed to load config"), e.message, "settings_alert", Toast.Error);
            }
        }
        onLoadFailed: err => {
            if (err !== FileViewError.FileNotFound)
                Toaster.toast(qsTr("Failed to read config file"), FileViewError.toString(err), "settings_alert", Toast.Warning);
        }
        onSaveFailed: err => Toaster.toast(qsTr("Failed to save config"), FileViewError.toString(err), "settings_alert", Toast.Error)

        JsonAdapter {
            id: adapter

            property bool battery: false
        }
    }
}
