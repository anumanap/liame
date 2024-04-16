#!/usr/bin/env bash
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

FDEVICE="lancelot"
#set -o xtrace

fox_get_target_device() {
	local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
	if [ -n "$chkdev" ]; then
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

# Dirty Fix: Only declare orangefox vars when needed
if [ -f "$(gettop)/bootable/recovery/orangefox.cpp" ]; then
 echo -e "\x1b[96m[INFO]: Setting up OrangeFox build vars for lancelot...\x1b[m"
 if [ "$1" = "$FDEVICE" ] || [  "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	  	
# Version / Maintainer infos
export OF_MAINTAINER="Tapin Recovery Instraller"
export FOX_VERSION=R12.1_1
export FOX_BUILD_TYPE="Unofficial"
export TARGET_DEVICE_ALT="lancelot"
export FOX_TARGET_DEVICES="lancelot,shiva"

export TW_DEFAULT_LANGUAGE="en"
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export OF_QUICK_BACKUP_LIST="/boot;/data;"
export FOX_BUGGED_AOSP_ARB_WORKAROUND="1588606644"
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/recovery"

# Magiskboot
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_NO_MIUI_PATCH_WARNING=1

# OTA
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
export OF_NO_MIUI_PATCH_WARNING=1
export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1

# Binaries
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_GREP_BINARY=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_ZIP_BINARY=1
export FOX_USE_BRX_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_REPLACE_TOOLBOX_GETPROP=1
export FOX_USE_XZ_UTILS=1
export FOX_REPLACE_BUSYBOX_PS=1
export OF_ENABLE_LPTOOLS=1

# Ensure that /sdcard is bind-unmounted before f2fs data repair or format
export OF_UNBIND_SDCARD_F2FS=1

# Metadata encription
export OF_FBE_METADATA_MOUNT_IGNORE=1

# Display / Leds
export OF_SCREEN_H=2340
export OF_STATUS_H=100
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_HIDE_NOTCH=1
export OF_CLOCK_POS=1 # left and right clock positions available
export OF_USE_GREEN_LED=0
export OF_FLASHLIGHT_ENABLE=0

# Removes the loop block errors after flashing ZIPs (Workaround) 
export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

# Run a Process After Formatting Data to Work-Around MTP Issues
export OF_RUN_POST_FORMAT_PROCESS=1

# Other OrangeFox configs
export FOX_DELETE_AROMAFM=1
export FOX_DELETE_INITD_ADDON=1
export OF_PATCH_AVB20=1
export FOX_REPLACE_BUSYBOX_PS="1"
export FOX_DELETE_INITD_ADDON=1
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export OF_SKIP_ORANGEFOX_PROCESS=1

  # let's see what are our build VARs
   if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
	export | grep "FOX" >> $FOX_BUILD_LOG_FILE
	export | grep "OF_" >> $FOX_BUILD_LOG_FILE
	export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
	export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi    
 fi
fi
