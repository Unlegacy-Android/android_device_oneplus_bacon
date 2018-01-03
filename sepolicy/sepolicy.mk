# Board specific SELinux policy variable definitions

PLATFORM_SEPOLICY_PATH := device/oneplus/bacon/sepolicy

BOARD_SEPOLICY_DIRS := \
       $(BOARD_SEPOLICY_DIRS) \
       $(PLATFORM_SEPOLICY_PATH) \
       $(PLATFORM_SEPOLICY_PATH)/common \
       $(PLATFORM_SEPOLICY_PATH)/ssg \
       $(PLATFORM_SEPOLICY_PATH)/msm8974 \
       $(PLATFORM_SEPOLICY_PATH)/bacon

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
BOARD_SEPOLICY_DIRS += \
       $(PLATFORM_SEPOLICY_PATH)/test
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
       $(PLATFORM_SEPOLICY_PATH)/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
       $(PLATFORM_SEPOLICY_PATH)/private

# Add sepolicy version to support OS upgrade and backward compatibility
BOARD_SEPOLICY_VERS := $(PLATFORM_SDK_VERSION).0
