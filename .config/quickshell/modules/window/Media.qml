import Quickshell

PopupWindow {
    id: window
    anchor.window: bar
    anchor.rect.x: anchor.window.implicitWidth
    anchor.rect.y: anchor.window.implicitHeight
    implicitWidth: 500
    implicitHeight: 500
    visible: false
    anchor.adjustment: SlideY
}
