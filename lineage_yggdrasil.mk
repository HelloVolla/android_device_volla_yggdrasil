#
#
# Copyright (C) 2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/halium.mk)

# Inherit from Volla Phone (yggdrasil) device
$(call inherit-product, device/volla/yggdrasil/device.mk)

# Inherit some common lineage stuff.
# $(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := lineage_yggdrasil
PRODUCT_DEVICE := yggdrasil
PRODUCT_BRAND := Volla
PRODUCT_MODEL := Phone
PRODUCT_MANUFACTURER := Volla

# Product characteristics
PRODUCT_AAPT_CONFIG := xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080
