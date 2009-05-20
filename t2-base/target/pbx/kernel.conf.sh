# --- T2-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
# 
# T2 SDE: target/embedded/kernel.conf.sh
# Copyright (C) 2009 The T2 SDE Project
# 
# More information can be found in the files COPYING and README.
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- T2-COPYRIGHT-NOTE-END ---

echo "AskoziaPBX target..."

sed -i -e "s/CONFIG_VIDEO_DEV=./# CONFIG_VIDEO_DEV is not set/" \
       -e "s/CONFIG_DVB=./# CONFIG_DVB is not set/" \
       -e "s/CONFIG_FB=./# CONFIG_FB is not set/" \
       -e "s/CONFIG_SOUND=./# CONFIG_SOUND is not set/" \
       -e "s/CONFIG_PHONE=./# CONFIG_PHONE is not set/" \
       -e "s/CONFIG_I2O=./# CONFIG I2O is not set/" \
       -e "s/CONFIG_AGP=./# CONFIG AGP is not set/" \
       -e "s/CONFIG_DRM=./# CONFIG DRM is not set/" \
       -e "s/CONFIG_SCSI\(.*\)=./# CONFIG_SCSI\1 is not set/" \
       -e "s/CONFIG_PCMCIA\(.*\)=./# CONFIG_PCMCIA\1 is not set/" \
       -e "s/CONFIG_HISAX\(.*\)=./# CONFIG_HISAX\1 is not set/" \
       -e "s/CONFIG_JOYSTICK\(.*\)=./# CONFIG_JOYSTICK\1 is not set/" \
       -e "s/CONFIG_MOUSE\(.*\)=./# CONFIG_MOUSE\1 is not set/" \
       -e "s/CONFIG_TABLET\(.*\)=./# CONFIG_TABLET\1 is not set/" \
       -e "s/CONFIG_TOUCHSCREEN\(.*\)=./# CONFIG_TOUCHSCREEN\1 is not set/" \
       -e "s/CONFIG_MEDIA_TUNER\(.*\)=./# CONFIG_MEDIA_TUNER\1 is not set/" \
       -e "s/CONFIG_DVB\(.*\)=./# CONFIG_DVB\1 is not set/" \
       -e "s/CONFIG_USB\(.*\)=./# CONFIG_USB\1 is not set/" \
       -e "s/CONFIG_IPV6\(.*\)=./# CONFIG_IPV6\1 is not set/" \
       -e "s/CONFIG_INET6\(.*\)=./# CONFIG_INET6\1 is not set/" \
       -e "s/CONFIG_LCD\(.*\)=./# CONFIG_LCD\1 is not set/" \
       -e "s/CONFIG_BACKLIGHT\(.*\)=./# CONFIG_BACKLIGHT\1 is not set/" \
       -e "s/CONFIG_INFINIBAND\(.*\)=./# CONFIG_INFINIBAND\1 is not set/" \
       -e "s/CONFIG_EXT4\(.*\)=./# CONFIG_EXT4\1 is not set/" \
       -e "s/CONFIG_REISERFS\(.*\)=./# CONFIG_REISERFS\1 is not set/" \
       -e "s/CONFIG_XFS\(.*\)=./# CONFIG_XFS\1 is not set/" \
       -e "s/CONFIG_JFFS2\(.*\)=./# CONFIG_JFFS2\1 is not set/" \
       -e "s/CONFIG_UBIFS\(.*\)=./# CONFIG_UBIFS\1 is not set/" \
       -e "s/CONFIG_UFS\(.*\)=./# CONFIG_UFS\1 is not set/" \
       -e "s/CONFIG_CRYPTO\(.*\)=./# CONFIG_CRYPTO\1 is not set/" \
       -e "s/CONFIG_NETFILTER\(.*\)=./# CONFIG_NETFILTER\1 is not set/" \
       -e "s/CONFIG_NF_\(.*\)=./# CONFIG_NF_\1 is not set/" \
       -e "s/CONFIG_IP6_NF\(.*\)=./# CONFIG_IP6_NF\1 is not set/" \
       -e "s/CONFIG_BRIDGE_\(.*\)=./# CONFIG_BRIDGE_\1 is not set/" \
       -e "s/CONFIG_INPUT_MOUSE\(.*\)=./# CONFIG_INPUT_MOUSE\1 is not set/" \
       -e "s/CONFIG_INPUT_JOYSTICK\(.*\)=./# CONFIG_INPUT_JOYSTICK\1 is not set/" \
       -e "s/CONFIG_INPUT_TABLET\(.*\)=./# CONFIG_INPUT_TABLET\1 is not set/" \
       -e "s/CONFIG_INPUT_TOUCHSCREEN\(.*\)=./# CONFIG_INPUT_TOUCHSCREEN\1 is not set/" \
       -e "s/CONFIG_INPUT_APANEL\(.*\)=./# CONFIG_INPUT_APANEL\1 is not set/" \
       -e "s/CONFIG_INPUT_WISTRON_BTNS\(.*\)=./# CONFIG_INPUT_WISTRON_BTNS\1 is not set/" \
       -e "s/CONFIG_INPUT_ATLAS_BTNS\(.*\)=./# CONFIG_INPUT_ATLAS_BTNS\1 is not set/" \
       -e "s/CONFIG_INPUT_UINPUT\(.*\)=./# CONFIG_INPUT_UINPUT\1 is not set/" \
       -e "s/CONFIG_I2C_\(.*\)=./# CONFIG_I2C_\1 is not set/" \
       -e "s/CONFIG_SCx200_\(.*\)=./# CONFIG_SCx200_\1 is not set/" \
       -e "s/CONFIG_SENSORS_\(.*\)=./# CONFIG_SENSORS_\1 is not set/" \
       -e "s/CONFIG_SPI_\(.*\)=./# CONFIG_SPI_\1 is not set/" \
       -e "s/CONFIG_W1_MASTER_\(.*\)=./# CONFIG_W1_MASTER_\1 is not set/" \
       -e "s/CONFIG_W1_SLAVE_\(.*\)=./# CONFIG_W1_SLAVE_\1 is not set/" \
       -e "s/CONFIG_SSB\(.*\)=./# CONFIG_SSB\1 is not set/" \
       -e "s/CONFIG_MEMSTICK_\(.*\)=./# CONFIG_MEMSTICK_\1 is not set/" \
       -e "s/CONFIG_RTC_DRV_\(.*\)=./# CONFIG_RTC_DRV_\1 is not set/" \
       -e "s/CONFIG_UIO\(.*\)=./# CONFIG_UIO\1 is not set/" \
       -e "s/CONFIG_JBD\(.*\)=./# CONFIG_JBD\1 is not set/" \
       -e "s/CONFIG_JBD2\(.*\)=./# CONFIG_JBD2\1 is not set/" \
       -e "s/CONFIG_JFS_\(.*\)=./# CONFIG_JFS_\1 is not set/" \
       -e "s/CONFIG_GFS2\(.*\)=./# CONFIG_GFS2\1 is not set/" \
       -e "s/CONFIG_OCFS2\(.*\)=./# CONFIG_OCFS2\1 is not set/" \
       -e "s/CONFIG_FUSE_FS\(.*\)=./# CONFIG_FUSE_FS\1 is not set/" \
       -e "s/CONFIG_NTFS\(.*\)=./# CONFIG_NTFS\1 is not set/" \
       -e "s/CONFIG_CONFIGFS\(.*\)=./# CONFIG_CONFIGFS\1 is not set/" \
       -e "s/CONFIG_ADFS_FS\(.*\)=./# CONFIG_ADFS_FS\1 is not set/" \
       -e "s/CONFIG_AFFS_FS\(.*\)=./# CONFIG_AFFS_FS\1 is not set/" \
       -e "s/CONFIG_ECRYPT_FS\(.*\)=./# CONFIG_ECRYPT_FS\1 is not set/" \
       -e "s/CONFIG_HFS_FS\(.*\)=./# CONFIG_HFS_FS\1 is not set/" \
       -e "s/CONFIG_HFSPLUS_FS\(.*\)=./# CONFIG_HFSPLUS_FS\1 is not set/" \
       -e "s/CONFIG_BEFS_FS\(.*\)=./# CONFIG_BEFS_FS\1 is not set/" \
       -e "s/CONFIG_BFS_FS\(.*\)=./# CONFIG_BFS_FS\1 is not set/" \
       -e "s/CONFIG_EFS_FS\(.*\)=./# CONFIG_EFS_FS\1 is not set/" \
       -e "s/CONFIG_CRAMFS\(.*\)=./# CONFIG_CRAMFS\1 is not set/" \
       -e "s/CONFIG_VXFS_FS\(.*\)=./# CONFIG_VXFS_FS\1 is not set/" \
       -e "s/CONFIG_MINIX_FS\(.*\)=./# CONFIG_MINIX_FS\1 is not set/" \
       -e "s/CONFIG_OMFS_FS\(.*\)=./# CONFIG_OMFS_FS\1 is not set/" \
       -e "s/CONFIG_HPFS_FS\(.*\)=./# CONFIG_HPFS_FS\1 is not set/" \
       -e "s/CONFIG_QNX4FS_FS\(.*\)=./# CONFIG_QNX4FS_FS\1 is not set/" \
       -e "s/CONFIG_SYSV_FS\(.*\)=./# CONFIG_SYSV_FS\1 is not set/" \
       -e "s/CONFIG_NETWORK_FILESYSTEMS\(.*\)=./# CONFIG_NETWORK_FILESYSTEMS\1 is not set/" \
       -e "s/CONFIG_NFS\(.*\)=./# CONFIG_NFS\1 is not set/" \
       -e "s/CONFIG_NFSD\(.*\)=./# CONFIG_NFSD\1 is not set/" \
       -e "s/CONFIG_LOCKD\(.*\)=./# CONFIG_LOCKD\1 is not set/" \
       -e "s/CONFIG_EXPORTFS\(.*\)=./# CONFIG_EXPORTFS\1 is not set/" \
       -e "s/CONFIG_NFS_COMMON\(.*\)=./# CONFIG_NFS_COMMON\1 is not set/" \
       -e "s/CONFIG_SUNRPC\(.*\)=./# CONFIG_SUNRPC\1 is not set/" \
       -e "s/CONFIG_RPCSEC\(.*\)=./# CONFIG_RPCSEC\1 is not set/" \
       -e "s/CONFIG_SMB_FS\(.*\)=./# CONFIG_SMB_FS\1 is not set/" \
       -e "s/CONFIG_CIFS\(.*\)=./# CONFIG_CIFS\1 is not set/" \
       -e "s/CONFIG_NCP_FS\(.*\)=./# CONFIG_NCP_FS\1 is not set/" \
       -e "s/CONFIG_CODA_FS\(.*\)=./# CONFIG_CODA_FS\1 is not set/" \
       -e "s/CONFIG_AFS_FS\(.*\)=./# CONFIG_AFS_FS\1 is not set/" \
       -e "s/CONFIG_9P_FS\(.*\)=./# CONFIG_9P_FS\1 is not set/" \
       -e "s/CONFIG_PARIDE\(.*\)=./# CONFIG_PARIDE\1 is not set/" \
       -e "s/CONFIG_FIREWIRE\(.*\)=./# CONFIG_FIREWIRE\1 is not set/" \
       -e "s/CONFIG_IEEE1394\(.*\)=./# CONFIG_IEEE1394\1 is not set/" \
       -e "s/CONFIG_ARCNET\(.*\)=./# CONFIG_ARCNET\1 is not set/" \
       -e "s/CONFIG_ATM\(.*\)=./# CONFIG_ATM\1 is not set/" \
       -e "s/CONFIG_PPP\(.*\)=./# CONFIG_PPP\1 is not set/" \
       -e "s/CONFIG_ISDN\(.*\)=./# CONFIG_ISDN\1 is not set/" \
       -e "s/CONFIG_MISDN\(.*\)=./# CONFIG_MISDN\1 is not set/" \
       -e "s/CONFIG_CAPI\(.*\)=./# CONFIG_CAPI\1 is not set/" \
       -e "s/CONFIG_\(.*\)GAMEPORT=./# CONFIG_\1GAMEPORT is not set/" $1