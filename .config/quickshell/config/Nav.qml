pragma Singleton
import Quickshell

Singleton {
    readonly property string home: Quickshell.env("HOME")
    readonly property string config: `${Quickshell.env("XDG_CONFIG_HOME") || `${home}/.config`}/quickshell/config.json`
}
