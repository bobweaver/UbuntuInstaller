#!/usr/bin/env bash

ACTION=$1
SCRIPT_NAME=dualboot.sh
# Used version of CWM recovery
URL_CMW_PATH_MAKO="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-mako.img"
URL_CMW_PATH_HAMMERHEAD="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.5-hammerhead.img"
URL_CMW_PATH_GROUPER="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-grouper.img"
URL_CMW_PATH_MAGURO="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-maguro.img"
URL_CMW_PATH_MANTA="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-manta.img"
URL_SUPERU_1_86="http://download.chainfire.eu/372/SuperSU/UPDATE-SuperSU-v1.86.zip?retrieve_file=1"
URL_U_INSTALLER_PACKAGE="http://humpolec.ubuntu.com/UPDATE-UbuntuInstaller.zip"
CACHE_RECOVERY=/cache/recovery
TEMP_FOLDER=humpTemp
RECOVERY_IMAGE=recovery.img
SU_PACKAGE=UPDATE-SuperSU-v1.86.zip
UBUNTU_INSTALLER_PACKAGE=UPDATE-UbuntuInstaller.zip
RECOVERY_URL=
DEVICE=
CM_DEVICE=

# get device model
detect_device() {
#  echo "Connect device to install Ubuntu installer to."
  DEVICE=$(adb wait-for-device shell getprop ro.product.device)
  CM_DEVICE=$(adb wait-for-device shell getprop ro.cm.device)

  if [[ "$DEVICE" == mako* ]]; then
    echo "Detected connected Nexus 4"
    RECOVERY_URL=$URL_CMW_PATH_MAKO
  else if [[ "$DEVICE" == maguro* ]]; then
    echo "Detected connected Galaxy Nexus"
    RECOVERY_URL=$URL_CMW_PATH_MAGURO
  else if [[ "$DEVICE" == grouper* ]]; then
    echo "Detected connected Nexus 7"
    RECOVERY_URL=$URL_CMW_PATH_GROUPER
  else if [[ "$DEVICE" == manta* ]]; then
    echo "Detected connected Nexus 10"
    RECOVERY_URL=$URL_CMW_PATH_MANTA
  else if [[ "$DEVICE" == hammerhead* ]]; then
    echo "Detected connected Nexus 5"
    RECOVERY_URL=$URL_CMW_PATH_HAMMERHEAD
  else 
    echo "Connected device is not supported"
    exit 0
  fi
  fi
  fi
  fi
  fi
}


print_usage() {
  echo "Welcome to Humpolec. This is Ubuntu-Android dualboot enabler"
  echo " "
  echo "Action"
  echo " "
  echo "  actions:"
  echo "    HELP: Prints this help"
  echo "    FULL: Full installation: this will install SuperUser package as well Ubuntu dualboot installer."
  echo "         Use this if you don't have SuperUser package installed on your device."
  echo "         Typical first time choice for unmodified factory images clean AOSP builds"
  echo "         Installation will reboot twice into the recovery, if prompterd **** when exiting recovery, answer NO"
  echo "    UPDATE: Updates application: this will install Ubuntu dualboot installer. It assumes there is alresdy Super User installed"
  echo "         Typical option for for CyanogenMod or other similar builds."
  echo "         Use this option if you already have Ubuntu dualboot installer installed and are only upgrading"
  echo "         Installation will reboot twice into the recovery, if prompterd when existing recovery, answer NO"
  echo "    INSTALL_SU: Installs Superuser"
}

wait_for_adb() {
  MODE=$1
  echo "Waiting for $MODE to boot"
  RECOVERY_STATE=$(adb devices)
  while ! [[ "$RECOVERY_STATE" == *$MODE ]]
  do
    sleep 1
    RECOVERY_STATE=$(adb devices)
  done
}

print_ask_help() {
  echo "For more information refer to HELP"
}

create_temp_dir() {
  mkdir $TEMP_FOLDER
  cd $TEMP_FOLDER
}

delete_temp_dir() {
  cd ..
  rm -rf $TEMP_FOLDER
}

download_su_package() {
  echo "Downloading SU package"
  # check downloaded file size, this often fails, so retry. Expected size is 1184318
  download_file $URL_SUPERU_1_86 $SU_PACKAGE 1184000
}

download_app_update() {
  echo "Downloading Ubuntu Installer application package"
  # check downloaded file size, this often fails, so retry. Expected size is 2309120
  download_file $URL_U_INSTALLER_PACKAGE $UBUNTU_INSTALLER_PACKAGE 2309000
}

download_recovery() {
  echo "Downloading recovery for $DEVICE"
  # check downloaded file size, this often fails, so retry. any recovery should be more than 5M
  download_file $RECOVERY_URL $RECOVERY_IMAGE 5000000
}

download_file() {
    DOWNLOAD_URL=$1
    FILENAME=$2
    TARGET_SIZE=$3
    SIZE=1
    # check downloaded file size, this often fails, so retry. Expected size is TARGET_SIZE
    while [[ $TARGET_SIZE -ge $SIZE ]]
    do
        curl $DOWNLOAD_URL > $FILENAME
        SIZE=$(ls -la $FILENAME | awk '{ print $5}')
        echo "Downloaded file has size: $SIZE"
    done
}

install_su() {
    echo "Rebooting to bootloader"
    adb reboot bootloader
    sleep 2
    fastboot boot $RECOVERY_IMAGE
    wait_for_adb recovery
    echo "Creating update command"
    adb shell rm -rf $CACHE_RECOVERY
    adb shell mkdir $CACHE_RECOVERY
    adb shell "echo -e '--sideload' > $CACHE_RECOVERY/command"
    echo "Booting back to bootloader"
    adb reboot bootloader
    sleep 2
    fastboot boot $RECOVERY_IMAGE
    wait_for_adb sideload
    adb sideload $SU_PACKAGE
    echo "Wait for installation of package to complete"
}

install_ubuntu_installer() {
    echo "Rebooting to bootloader"
    adb reboot bootloader
    sleep 2
    fastboot boot $RECOVERY_IMAGE
    wait_for_adb recovery
    echo "Creating update command"
    adb shell rm -rf $CACHE_RECOVERY
    adb shell mkdir $CACHE_RECOVERY
    adb shell "echo -e '--sideload' > $CACHE_RECOVERY/command"
    echo "Booting back to bootloader"
    adb reboot bootloader
    sleep 2
    fastboot boot $RECOVERY_IMAGE
    wait_for_adb sideload
    adb sideload $UBUNTU_INSTALLER_PACKAGE
    echo "Install Compleate"
#    echo "Wait for installation of package to complete"
#    echo "If you are asked to preserve possibly lost root access"
#    echo "Or if device should be rooted"
#    echo "This is false warning and yuou can answer either yes or no"
}

check_build_for_su_update() {
    if [[ "$CM_DEVICE" == "$DEVICE" ]]; then
        echo "!!! This seems to be CyanogenMod build, you already have SuperUser as part of the system"
        echo "Go to Settings->SuperUser->Settings and make sure it is enabled for applications"
        echo "For installation, use: UPDATE"
        print_ask_help
        exit 0;
    fi
}

if [[ "$ACTION" == HELP ]]; then
    echo "HELP" 
    print_usage
else if [[ "$ACTION" == FULL ]]; then
    detect_device
    check_build_for_su_update
    echo "FULL install"
    create_temp_dir
    download_su_package
    download_app_update
    download_recovery
    install_ubuntu_installer
    install_su
    
    delete_temp_dir
else if [[ "$ACTION" == INSTALL_SU ]]; then
    detect_device
    check_build_for_su_update
    echo "INSTALL_SU"
    create_temp_dir
    download_su_package
    download_recovery
    install_su
    delete_temp_dir
else if [[ "$ACTION" == UPDATE ]]; then
    detect_device
    create_temp_dir
    echo "UPDATE install"
    download_app_update
    download_recovery
    install_ubuntu_installer
    delete_temp_dir
else 
    echo "Unknow action"
    print_ask_help
fi
fi
fi
fi
