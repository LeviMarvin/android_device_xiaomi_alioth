# Inherit common products
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configurations
$(call inherit-product, device/xiaomi/alioth/device.mk)

# Inherit common ArrowOS configurations
$(call inherit-product, vendor/arrow/config/common.mk)

# No sdcard support
PRODUCT_CHARACTERISTICS := nosdcard

PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := alioth
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := M2012K11AC
PRODUCT_NAME := Redmi K40

# GMS Client ID
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi