#ifndef APPLICATIONLAUNCHER_H
#define APPLICATIONLAUNCHER_H
#include <QObject>
#include <QProcess>
class ApplicationLauncher : public QObject
{
    Q_OBJECT

public:
    explicit ApplicationLauncher(QObject *parent = 0);
    Q_PROPERTY( QString         appName                 READ appName                 WRITE setAppName                 )
    Q_PROPERTY( QString         arguments                 READ arguments                 WRITE setArguments                 )
//    Q_PROPERTY()


    QString appName() const;
    void setAppName(const QString &appName);
    QString arguments() const;
    void setArguments(const QString &arguments);
    Q_INVOKABLE void launchScript();
    Q_INVOKABLE void launchwaitScript();
    Q_INVOKABLE QString  getSTD();
private:
    QProcess *m_process;
    QString m_AppName;
    QString m_Arguments;
    QString m_Out;
    QString   m_State;

};
#endif //APPLICATIONLAUNCHER_H
