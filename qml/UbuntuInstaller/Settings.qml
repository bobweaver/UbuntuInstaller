import QtQuick 2.0
import QtQuick 2.0
//Ubuntu
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
//Loacl
import ApplicationLauncher 0.1
import"utils.js" as Utils

Page {
    width: parent.width
    height: parent.height
    title:  i18n.tr("Settings")
    tools: ToolbarItems{
        ToolbarButton{
          action: Action{
           text: i18n.tr("back")
           onTriggered:{
            //stop the timers and start the setting
               pageLoader.source = "PageOne.qml"
               timer.start();
           }
          }
      }
    }

    Column{
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        ThinDivider{}
        Label{
        text: i18n.tr("Select the Theme that you would like to use")
        fontSize: "x-large"
        anchors.horizontalCenter: parent.horizontalCenter
        ThinDivider{}


        }

        Row{
            spacing: units.gu(5)
 anchors.centerIn: parent
            Button{
              text: "Suru Gradient"
              onClicked: {
                  Theme.name  = "Ubuntu.Components.Themes.SuruGradient"
              }
          }
          Button{
              text: "Ambiance"
              onClicked: {
                  Theme.name  = "Ubuntu.Components.Themes.Ambiance"
              }
          }
          Button{
              text: "Suru Dark"
              onClicked: {
                  Theme.name  = "Ubuntu.Components.Themes.SuruDark"
              }
          }
        }
    }
}
