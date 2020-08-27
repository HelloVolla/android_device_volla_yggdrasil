#
# Copyright (C) 2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Get non-open-source specific aspects
#$(call inherit-product-if-exists, vendor/volla/yggdrasil/yggdrasil-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# A/B
AB_OTA_UPDATER := false

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    libaacwrapper

# Camera
#PRODUCT_PACKAGES += \
#    Snap

# Init cripts
PRODUCT_PACKAGES += \
    init.mt6763.rc \
    fstab.mt6763

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
    $(LOCAL_PATH)/idc/mtk-pad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-pad.idc \
    $(LOCAL_PATH)/keylayout/ACCDET.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ACCDET.kl \
    $(LOCAL_PATH)/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

# Overlay
# PRODUCT_PACKAGES += \
#    DummyOverlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml

# Ubuntu Touch overlay
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/halium-overlay/lib/udev/rules.d/70-android.rules:$(TARGET_COPY_OUT_SYSTEM)/halium/lib/udev/rules.d/70-android.rules \
    $(LOCAL_PATH)/halium-overlay/usr/share/apparmor/hardware/graphics.d/apparmor-easyprof-ubuntu_android9:$(TARGET_COPY_OUT_SYSTEM)/halium/usr/share/apparmor/hardware/graphics.d/apparmor-easyprof-ubuntu_android9 \
    $(LOCAL_PATH)/halium-overlay/usr/share/upstart/sessions/audiosystem-passthrough.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/usr/share/upstart/sessions/audiosystem-passthrough.conf \
    $(LOCAL_PATH)/halium-overlay/usr/sbin/mount-android.sh:$(TARGET_COPY_OUT_SYSTEM)/halium/usr/sbin/mount-android.sh \
    $(LOCAL_PATH)/halium-overlay/etc/init/bluebinder.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/bluebinder.conf \
    $(LOCAL_PATH)/halium-overlay/etc/init/lxc-android-config.override:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/lxc-android-config.override \
    $(LOCAL_PATH)/halium-overlay/etc/init/mount-android.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/mount-android.conf \
    $(LOCAL_PATH)/halium-overlay/etc/init/mtp-state.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/mtp-state.conf \
    $(LOCAL_PATH)/halium-overlay/etc/init/ssh.override:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/ssh.override \
    $(LOCAL_PATH)/halium-overlay/etc/init/urfkill.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/urfkill.conf \
    $(LOCAL_PATH)/halium-overlay/etc/init/usb-tethering.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/init/usb-tethering.conf \
    $(LOCAL_PATH)/halium-overlay/etc/ofono/main.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/ofono/main.conf \
    $(LOCAL_PATH)/halium-overlay/etc/ofono/ril_subscription.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/ofono/ril_subscription.conf \
    $(LOCAL_PATH)/halium-overlay/etc/pulse/touch-android9.pa:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/pulse/touch-android9.pa \
    $(LOCAL_PATH)/halium-overlay/etc/ubuntu-touch-session.d/android.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/etc/ubuntu-touch-session.d/android.conf \
    $(LOCAL_PATH)/halium-overlay/usr/share/upstart/sessions/mtp-server.conf:$(TARGET_COPY_OUT_SYSTEM)/halium/usr/share/upstart/sessions/mtp-server.conf \
    $(LOCAL_PATH)/halium-overlay/usr/share/usbinit/setupusb:$(TARGET_COPY_OUT_SYSTEM)/halium/usr/share/usbinit/setupusb

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/halium-overlay/system/lib64/libtinyalsa.so:$(TARGET_COPY_OUT_SYSTEM)/halium/system/lib64/libtinyalsa.so \
    $(LOCAL_PATH)/halium-overlay/vendor/lib/hw/audio.primary.mt6763.so:$(TARGET_COPY_OUT_SYSTEM)/halium/vendor/lib/hw/audio.primary.mt6763.so \
    $(LOCAL_PATH)/halium-overlay/vendor/lib64/hw/audio.primary.mt6763.so:$(TARGET_COPY_OUT_SYSTEM)/halium/vendor/lib64/hw/audio.primary.mt6763.so \
    $(LOCAL_PATH)/halium-overlay/vendor/lib64/libcam.halsensor.so:$(TARGET_COPY_OUT_SYSTEM)/halium/vendor/lib64/libcam.halsensor.so \
    $(LOCAL_PATH)/halium-overlay/vendor/lib64/libcameracustom.so:$(TARGET_COPY_OUT_SYSTEM)/halium/vendor/lib64/libcameracustom.so \
    $(LOCAL_PATH)/halium-overlay/vendor/lib64/libmtk-ril.so:$(TARGET_COPY_OUT_SYSTEM)/halium/vendor/lib64/libmtk-ril.so \
    $(LOCAL_PATH)/halium-overlay/vendor/lib64/libmtkcam_metastore.so:$(TARGET_COPY_OUT_SYSTEM)/halium/vendor/lib64/libmtkcam_metastore.so
