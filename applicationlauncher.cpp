#include "applicationlauncher.h"
#include    <QProcess>
#include <QDebug>
ApplicationLauncher::ApplicationLauncher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
}
QString ApplicationLauncher::appName() const
{
    return m_AppName;
}
void ApplicationLauncher::setAppName(const QString &appName)
{
    m_AppName = appName;
}
QString ApplicationLauncher::arguments() const
{
    return m_Arguments;
}
void ApplicationLauncher::setArguments(const QString &arguments)
{
    m_Arguments = arguments;
}
void ApplicationLauncher::launchScript()
{
    QProcess sd;
    sd.setProcessChannelMode(QProcess::MergedChannels);
    sd.start(m_AppName);
    if( !sd.waitForFinished()){
        m_Out = sd.errorString();
    }else {
       m_Out  =  sd.readAll();
    }
    qDebug() << m_Out  ;
}

QString ApplicationLauncher::getSTD()
{
    return m_Out ;
}
