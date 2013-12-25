function removeWhite(dd) {
    var q = dd.replace(/\s/g, "")
    return q
}
// Used version of CWM recovery
var URL_CMW_PATH_MAKO="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-mako.img"
var URL_CMW_PATH_HAMMERHEAD="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.5-hammerhead.img"
var URL_CMW_PATH_GROUPER="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-grouper.img"
var URL_CMW_PATH_MAGURO="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-maguro.img"
var URL_CMW_PATH_MANTA="http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.4.3-manta.img"
var URL_SUPERU_1_86="http://download.chainfire.eu/372/SuperSU/UPDATE-SuperSU-v1.86.zip?retrieve_file=1"
var URL_U_INSTALLER_PACKAGE ="http://humpolec.ubuntu.com/UPDATE-UbuntuInstaller.zip"
var CACHE_RECOVERY = "/cache/recovery"
var TEMP_FOLDER = "humpTemp"
var RECOVERY_IMAGE ="recovery.img"
var SU_PACKAGE = "UPDATE-SuperSU-v1.86.zip"
var UBUNTU_INSTALLER_PACKAGE ="UPDATE-UbuntuInstaller.zip"
var RECOVERY_URL = ""
var DEVICE = ""
var CM_DEVICE = ""

var DEVICE = "$(adb shell getprop ro.product.device)"
var CM_DEVICE = "$(adb shell getprop ro.cm.device)"

function detect_device(input){
    var q = input.replace(/\s/g, "")
    var x =""
    switch (q){
      case "mako" :
        x="mako";
        break;
      case "maguro":
        x="maguro";
        break;
      case "grouper":
        x="grouper";
        break;
      case "manta":
        x="manta";
        break;
      case "hammerhead":
        x="hammerhead";
        break;
      }
    return x
}



//if [[ "$DEVICE" == mako* ]]; then
//  echo "Detected connected Nexus 4"
//  RECOVERY_URL=$URL_CMW_PATH_MAKO
//else if [[ "$DEVICE" == maguro* ]]; then
//  echo "Detected connected Galaxy Nexus"
//  RECOVERY_URL=$URL_CMW_PATH_MAGURO
//else if [[ "$DEVICE" == grouper* ]]; then
//  echo "Detected connected Nexus 7"
//  RECOVERY_URL=$URL_CMW_PATH_GROUPER
//else if [[ "$DEVICE" == manta* ]]; then
//  echo "Detected connected Nexus 10"
//  RECOVERY_URL=$URL_CMW_PATH_MANTA
//else if [[ "$DEVICE" == hammerhead* ]]; then
//  echo "Detected connected Nexus 5"
//  RECOVERY_URL=$URL_CMW_PATH_HAMMERHEAD
//else
//  echo "Connected device is not supported"
//  exit 0
