//QT
import QtQuick 2.0
//Ubuntu
import Ubuntu.Components 0.1
//Local
import ApplicationLauncher 0.1
import"utils.js" as Utils
Page {
    id: pageOne
    title: i18n.tr("Ubuntu Installer ")
    tools: ToolbarItems {
        id:toolBar
        ToolbarButton {
            action: Action {
                iconSource:"/usr/share/unity/icons/launcher_bfb.png"
                text: "Settings"
                onTriggered:{
                    //stop the timers and start the setting
                    pageLoader.source = "Settings.qml"
                }
            }
        }
    }
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
        id:welcomTXT
        text: i18n.tr("Welcome to the Ubuntu Daul Boot Installer")
        fontSize: "x-large" // and in charge
        anchors{
            top: parent.top
            topMargin: units.gu(2)
            horizontalCenter: parent.horizontalCenter
        }
    }
    Image {
        id: phoneImg
        width: units.gu(32);height: width *1.2
        source:  "images/phone-symbolic.png"
        anchors{
            top: parent.top
            topMargin: units.gu(20)
            horizontalCenter: parent.horizontalCenter
        }
        opacity: Utils.removeWhite(phoneModel.text) ===  "mako"
                 ||  Utils.removeWhite(phoneModel.text) === "grouper"
                 ? 1: 0
    }
    Label{
        id: mainTxt
        fontSize: "x-large" // and in charge :)
        opacity:Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text) === "grouper" ? 1 : 0
        text:  Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text) ===  "grouper" ?
                   i18n.tr( "Your Phone is Suppported and Ready to Flash \n" )
                 : i18n.tr("you Phone is not Supported \n Please take a look at the Docs page to find out more")
        anchors{
            top: phoneImg.bottom
            horizontalCenter:  parent.horizontalCenter
        }
    }
    Label{
        text: "Phone Model: " + phoneModel.text
        opacity:Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text) === "grouper" ? 1 : 0
        anchors{
            top: mainTxt.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }
    Button{
        width:  units.gu(22)
        opacity: Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text)  === "grouper" ? 1 : 0
        anchors{
            bottom: parent.bottom
            bottomMargin: units.gu(4)
            horizontalCenter: parent.horizontalCenter
        }
        text:{
            if(Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text)  === "grouper" )
                return i18n.tr("Flash")
            else
                return i18n.tr("ReLoad")
        }
        onClicked:{
            if(Utils.removeWhite(phoneModel.text) ===  "mako" || Utils.removeWhite(phoneModel.text)  === "grouper") {
                pageLoader.source = appQmlPath + "Flash.qml"
                timer.stop()
            }
            else{
                timer.start()
            }
        }
    }
    Label{
        id: phoneModel
        opacity: 0
    }
    Timer{
        id: timer
        interval: 1500;
        running: true
        repeat: true
        onTriggered:{
            scripts.launchScript();
            if (Utils.removeWhite(scripts.getSTD()) === "error:devicenotfound")
                phoneModel.text = "error:devicenotfound"
            else
                phoneModel.text = scripts.getSTD()
        }
    }
}
