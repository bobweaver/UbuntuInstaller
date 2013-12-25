//QT
import QtQuick 2.0
//Ubuntu
import Ubuntu.Components 0.1
//Loacl
import ApplicationLauncher 0.1
import"utils.js" as Utils

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer..UbuntuInstaller"
    anchorToKeyboard: true
    automaticOrientation: true
    width: units.gu(100)
    height: units.gu(75)
    Page {
        id: pageOne
        title: i18n.tr("Ubuntu Installer ")
        Rectangle{
        anchors.fill: parent
        color:  act.running ?  "#88000000" : "transparent"
        Label{
            text:{
                return   "Could Not Find Any Phones Connected to this Computer \n If Not Pluged in Please do so Now"
            }
            anchors.centerIn:  parent
            fontSize:  "x-large"
            visible:  Utils.removeWhite(phoneModel.text) === "error:devicenotfound"  ? true : false
        }

        Label{
            text:{
                  "Scanning For A Phone \nIf Not Pluged in Please do so Now"
            }
            anchors.centerIn:  parent
            fontSize:  "x-large"
            visible:  phoneModel.text === "" ? true : false
        }

        ActivityIndicator{
            id: act
            running: phoneModel.text === "" ? true : false
            anchors.centerIn: parent
        }
        }
        Label{
            text: i18n.tr("Welcome to the Ubuntu Daul Boot Installer")
            fontSize: "x-large" // and in charge
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Image {
            id: phoneImg
            width: units.gu(22);height: width
            source:  "images/phone-symbolic.png"
            anchors.centerIn: parent
            opacity: Utils.removeWhite(phoneModel.text) ===  "mako"
                     ||  Utils.removeWhite(phoneModel.text) === "grouper"
                     ? true : false
        }

        Label{
            id: mainTxt
            fontSize: "large" // and in charge :)
            opacity:Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text) === "grouper" ? 1 : 0
            text:  Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text) ===  "grouper" ?
                       i18n.tr( "Your Phone is Suppported and Ready to Flash \n" + "Phone Model: \t" + phoneModel.text)
                      : i18n.tr("you Phone is not Supported \n Please take a look at the Docs page to find out more")
            anchors{
                top:    phoneImg.bottom
                horizontalCenter:  parent.horizontalCenter
            }
        }

        Button{
            width:  units.gu(22)
            opacity: Utils.removeWhite(phoneModel.text) ===  "mako"
                     || Utils.removeWhite(phoneModel.text)  === "grouper"
                     ? 1 : 0
            anchors{
                top: mainTxt.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: units.gu(2)
            }
            text: i18n.tr("Flash")
        onClicked:{
           pageLoader.source = appQmlPath + "Flash.qml"
            pageLoader.y = 0
            pageLoader.opacity = 1
        }
        }

        Button{
            width:  units.gu(22)
            opacity: Utils.removeWhite(phoneModel.text) === "error:devicenotfound"  ? 1 : 0
            y: Utils.removeWhite(phoneModel.text) === "error:devicenotfound"  ?   null : parent.height
             anchors{
                horizontalCenter: parent.horizontalCenter
            }
            text: i18n.tr("ReScan")
            onClicked: timer.start()
        }
        Label{
            id: phoneModel
            opacity: 1
        }
        Timer{
            id: timer
            interval: 500; running: true; repeat: false
            onTriggered:{
                scripts.launchScript();
                if (Utils.removeWhite(scripts.getSTD()) === "error:devicenotfound")
                    phoneModel.text = "error:devicenotfound"
               else
                    phoneModel.text = scripts.getSTD()
        }
    }
    }
    AppLauncher{
        id:scripts;
        appName: "adb  shell getprop ro.product.device"
    }


    Loader{
     id: pageLoader
     width: parent.width
     height: pageOne.height
     anchors.bottom: parent.bottom
     y: parent.y
     opacity: 0
    }
    Component.onCompleted: {
//                        Theme.name = "Ubuntu.Components.Themes.SuruGradient"
    }
}
