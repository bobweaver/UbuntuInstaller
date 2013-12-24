# Add more folders to ship with the application, here
folder_01.source = qml/UbuntuInstaller
folder_02.source = script
folder_01.target = qml
folder_02.target =

DEPLOYMENTFOLDERS =  \
                    folder_01 \
                    folder_02

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    applicationlauncher.cpp

# Installation path
# target.path =

OTHER_FILES += \
    script/daulbootUbuntuAndroid.sh

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    applicationlauncher.h
