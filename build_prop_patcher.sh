#!/sbin/sh
set_prop(){
  name="$1"
  value="$2"
  file="/system/build.prop"
  if grep -q "^$name=" "$file"; then
    #echo "$name is exist in $file"
    sed -i "s#^$name=.*#$name=$value#g" "$file"
  else
    #echo "$name is not exist in $file"
    echo "$name=$value" >> "$file"
  fi
}

set_prop hw.cameras 2
set_prop ro.sys.max_cpu_on 1200000
set_prop ro.vout.dualdisplay2 false
set_prop ro.vout.dualdisplay3 true
set_prop ro.real_device "Gadmei E8-3D"

# Set default USB mode
if [ "`getprop sys.uses.datamedia`" = "1" ] ; then
  set_prop persist.sys.usb.config mtp,adb
else
  set_prop persist.sys.usb.config mass_storage,adb
fi

# For correct rotation
set_prop ro.sf.hwrotation 270
set_prop ro.sf.gsensorposition 3
set_prop ro.camera.orientation.front 0
set_prop ro.camera.orientation.back 0

set_prop rw.youtube_workaround 0 # Fixes video streaming in 3DPlayer and/or Yabazam 3D
set_prop ro.product.build.support3d true # For 3DPlayer and 3DImageView
set_prop ro.product.build.dim E83D-T380-GADMEIUS-NEO3DO_GADMEIUS-NEO3DO_V1.0.1.20131214 # For TriDef 3D Games
set_prop ro.product.manufacturer Gadmei # For Phereo photo viewer

# Localization
set_prop persist.sys.timezone Europe/Moscow
set_prop persist.sys.language ru
set_prop persist.sys.country RU

# Disable setupwizard on OmniRom
if grep -q ro.omni.device /system/build.prop ; then
  set_prop ro.setupwizard.mode DISABLED
fi
