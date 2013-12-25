//QT
import QtQuick 2.0
//Ubuntu
import Ubuntu.Components 0.1
//Loacl
import ApplicationLauncher 0.1
import"utils.js" as Utils

MainView {
    id:mainViewer
    objectName: "mainView"
    applicationName: "Ubuntu Installer"
    anchorToKeyboard: true
//    automaticOrientation: true
    width: units.gu(100)
    height: units.gu(75)
    property string theme: "Ubuntu.Components.Themes.SuruGradient"

//    Rectangle{
//        id:mainBky
//        anchors.fill: parent
//        color: "green"
//    }

    AppLauncher{
        id:scripts;
        appName: "adb  shell getprop ro.product.device"
    }
    Loader{
     id: pageLoader
     width: parent.width
     height: parent.height - mainViewer.header.height
     anchors.bottom: parent.bottom
     source: "PageOne.qml"
    }
    Component.onCompleted: {
                        Theme.name = theme
    }
}
