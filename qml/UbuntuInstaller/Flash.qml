//QT
import QtQuick 2.0
//Ubuntu
import Ubuntu.Components 0.1
//Loacl
import ApplicationLauncher 0.1
import"utils.js" as Utils
Page {
    width: parent.width
    height: parent.height
    title:  "Flash"

    Rectangle{
        id:head
        width:     parent.width
        height: units.gu(8)
        color: UbuntuColors.warmGrey

        Row{
            id: buttonsRow
            anchors.centerIn: head
            spacing: units.gu(2)
            Button{
                id: full
                text:i18n.tr("Full")
                onClicked: {
                    runScript.appName = appScriptPath + "daulbootUbuntuAndroid.sh FULL"
                    runScript.launchScript();
                    stdOut.text = " "
                    terminalTimer.start()
                }
            }

            Button{
                id: update
                text:i18n.tr("Update")
                onClicked: {
                    runScript.appName = appScriptPath + "daulbootUbuntuAndroid.sh UPDATE"
                    runScript.launchScript();
                    stdOut.text = " "
                    terminalTimer.start()
                }
            }



            Button{
                id: installSU
                text:i18n.tr("Install SU")
                onClicked: {
                    runScript.appName = appScriptPath + "daulbootUbuntuAndroid.sh INSTALL_SU"
                    runScript.launchScript();
                    stdOut.text = " "
                    terminalTimer.start()
                }
            }

            Button{
                id: help
                text:i18n.tr("Show Help")
                onClicked: {
                    runScript.appName = appScriptPath + "daulbootUbuntuAndroid.sh HELP"
                    runScript.launchScript();
                    stdOut.text = " "
                    terminalTimer.start()
                }
            }

        }
    }

    Rectangle{
        id: fakeTerminal
        anchors{
            top: head.bottom
            right: parent.right
            bottom:  parent.bottom
            left: parent.left
        }
        width:     parent.width
        height: parent.height
        color: "#300a24"
        Text {
            id: stdOut
            color: "#fff"
            font.family: "Ubuntu Mono"
            font.pixelSize: 14
        }

        AppLauncher{
            id: runScript
            appName: appScriptPath + "daulbootUbuntuAndroid.sh HELP"
        }

        Timer {
            id:terminalTimer
            interval: 100; running: true; repeat: false
            onTriggered: {
                stdOut.text = runScript.getSTD();
            }
        }


    }
    Component.onCompleted: { runScript.launchScript(); }
}
