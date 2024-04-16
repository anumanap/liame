#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)


# Inherit some common Omni stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from lancelot device
$(call inherit-product, device/xiaomi/lancelot/device.mk)

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root)


# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_DEVICE := lancelot
PRODUCT_NAME := twrp_lancelot
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi 9
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="lancelot-user 11 RP1A.200720.011 V12.5.6.0.RJCMIXM release-keys"

BUILD_FINGERPRINT := Redmi/lancelot_global/lancelot:11/RP1A.200720.011/V12.5.6.0.RJCMIXM:user/release-keys
