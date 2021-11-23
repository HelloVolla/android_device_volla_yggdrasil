#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),yggdrasil)

# Make a symlink so that our built-from-source /system/lib/modules
# overrides /vendor/lib/modules. Recipe thanks to Android's init.
$(TARGET_OUT)/halium/vendor/lib/modules: $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> /system/lib/modules"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/lib/modules $@
ALL_DEFAULT_INSTALLED_MODULES += $(TARGET_OUT)/halium/vendor/lib/modules

include $(call all-makefiles-under,$(LOCAL_PATH))
endif
