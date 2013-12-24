#include <QtGui/QGuiApplication>
#include "applicationlauncher.h"
#include "qtquick2applicationviewer.h"
#include <QtQuick>
#include <QUrl>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    qmlRegisterType<ApplicationLauncher>("ApplicationLauncher",0,1,"AppLauncher");

    QUrl appPath(QString("%1").arg(app.applicationDirPath()));
    viewer.rootContext()->setContextProperty("appPath", appPath);

    QUrl appQmlPath(QString("%1").arg(app.applicationDirPath())+(QString("/qml/UbuntuInstaller/")));
    viewer.rootContext()->setContextProperty("appQmlPath", appQmlPath);

    QUrl appScriptPath(QString("%1").arg(app.applicationDirPath())+(QString("/script/")));
    viewer.rootContext()->setContextProperty("appScriptPath", appScriptPath);

    viewer.setMainQmlFile(QStringLiteral("qml/UbuntuInstaller/main.qml"));
    viewer.showMaximized();
    return app.exec();
}
