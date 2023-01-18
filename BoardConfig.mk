DEVICE_PATH := device/xiaomi/alioth

# A/B
AB_OTA_UPDATER := true
# A/B: Partitions enabled OTA update.
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo385

# Bootloader
# Bootloader: Set bootloader name
TARGET_BOOTLOADER_BOARD_NAME := kona

# Build
#BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true
#BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
#BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true

# Kernel
# Kernel: Set the version of kernel header for supporting vendor_boot partition.
BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_BINARIES := kernel
# Kernel: Set command lines.
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0 androidboot.memcg=1
BOARD_KERNEL_CMDLINE += ramoops_memreserve=4M reboot=panic_warm
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237 earlycon=msm_geni_serial,0xa90000
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3 swiotlb=2048
BOARD_KERNEL_CMDLINE += loop.max_part=7 cgroup.memory=nokmem,nosocket
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
# Kernel: Specify kernel image filename.
BOARD_KERNEL_IMAGE_NAME := Image
# Kernel: Set the kernel page size.
BOARD_KERNEL_PAGESIZE := 4096
# Kernel: Set for separating dtbo.
BOARD_KERNEL_SEPARATED_DTBO := true
# Kernel: Set args of mkbootimg.
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
KERNEL_LD := LD=ld.lld
TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/linux-x86/dtc/dtc
# Kernel: Do NOT append DTB.
TARGET_KERNEL_APPEND_DTB := false
# Kernel: Include DTB in boot.img.
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
# Kernel: Set the kernel's arch.
TARGET_KERNEL_ARCH := arm64
# Kernel: Set the kernel header's arch.
TARGET_KERNEL_HEADER_ARCH := arm64

# Kernel: If not used prebuilt-kernel.
ifeq ($(TARGET_PREBUILT_KERNEL),)
    # Kernel: Set config file for use in compiling.
    TARGET_KERNEL_CONFIG := alioth_lmperf_defconfig
    # Kernel: Compile the kernel using Clang.
    TARGET_KERNEL_CLANG_COMPILE := true
    # Kernel: Set the source path of kernel.
    TARGET_KERNEL_SOURCE := kernel/xiaomi/alioth
endif

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_DTBOIMG_PARTITION_SIZE := 33554432
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_USERDATAIMAGE_PARTITION_SIZE := 114135379968
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

# Partitions: Set dynamic partitions.
BOARD_ALIOTH_DYNAMIC_PARTITIONS_PARTITION_LIST := product system system_ext
# Partitions: Set the size of super partition.
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := alioth_dynamic_partitions
BOARD_ALIOTH_DYNAMIC_PARTITIONS_SIZE := 4559208448

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_ALIOTH_DYNAMIC_PARTITIONS_PARTITION_LIST))
# Partitions: Set filesystem type for all partitions.
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions: Set the type of filesystem of /userdata.
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := kona

# Recovery
# Recovery: Include recovery DTBO.
BOARD_INCLUDE_RECOVERY_DTBO := true
# Recovery: Specify recovery in the boot partition.
BOARD_USES_RECOVERY_AS_BOOT := true
# Recovery: Device has not recovery partition.
TARGET_NO_RECOVERY := true
# Recovery: Specify recovery fstab file.
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
# Recovery: Set the type of filesystem of /user.
TARGET_USERIMAGES_USE_F2FS := true

# Android Verified Boot (AVB)
# AVB: Enable AVB feature.
BOARD_AVB_ENABLE := true
# AVB: Add image args.
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
# AVB: Partitions for enabling AVB.
BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
# AVB: Rollback index.
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
# AVB: Rollback index location.
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# VNDK
BOARD_VNDK_VERSION := current