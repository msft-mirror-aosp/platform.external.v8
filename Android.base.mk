LOCAL_PATH := $(call my-dir)

v8_base_common_src := \
	src/base/accounting-allocator.cc \
	src/base/atomicops_internals_x86_gcc.cc \
	src/base/bits.cc \
	src/base/cpu.cc \
	src/base/debug/stack_trace.cc \
	src/base/division-by-constant.cc \
	src/base/file-utils.cc \
	src/base/functional.cc \
	src/base/ieee754.cc \
	src/base/logging.cc \
	src/base/once.cc \
	src/base/debug/stack_trace_android.cc \
	src/base/platform/condition-variable.cc \
	src/base/platform/mutex.cc \
	src/base/platform/platform-posix.cc \
	src/base/platform/semaphore.cc \
	src/base/platform/time.cc \
	src/base/sys-info.cc \
	src/base/utils/random-number-generator.cc

include $(CLEAR_VARS)

include $(LOCAL_PATH)/Android.v8common.mk

# Set up the target identity
LOCAL_MODULE := libv8base
LOCAL_MODULE_CLASS := STATIC_LIBRARIES

# Target is always linux.
LOCAL_SRC_FILES := \
	$(v8_base_common_src) \
	src/base/platform/platform-linux.cc \

LOCAL_SRC_FILES_x86 += src/base/atomicops_internals_x86_gcc.cc
LOCAL_SRC_FILES_x86_64 += src/base/atomicops_internals_x86_gcc.cc

LOCAL_C_INCLUDES := $(LOCAL_PATH)/src

include $(BUILD_STATIC_LIBRARY)

# ====================================
include $(CLEAR_VARS)

include $(LOCAL_PATH)/Android.v8common.mk

# Set up the target identity
LOCAL_MODULE := libv8base
LOCAL_MODULE_CLASS := STATIC_LIBRARIES

LOCAL_SRC_FILES := $(v8_base_common_src)

# Host may be linux or darwin.
ifeq ($(HOST_OS),linux)
LOCAL_SRC_FILES += src/base/platform/platform-linux.cc
endif
ifeq ($(HOST_OS),darwin)
LOCAL_SRC_FILES += src/base/platform/platform-macos.cc
endif

ifeq ($(HOST_ARCH),x86)
LOCAL_SRC_FILES += src/base/atomicops_internals_x86_gcc.cc
endif
ifeq ($(HOST_ARCH),x86_64)
LOCAL_SRC_FILES += src/base/atomicops_internals_x86_gcc.cc
endif

LOCAL_C_INCLUDES := $(LOCAL_PATH)/src

include $(BUILD_HOST_STATIC_LIBRARY)

v8_base_common_src :=
