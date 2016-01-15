LOCAL_PATH := $(call my-dir)

###################################
#  algorithm component
###################################
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../common/include \
					$(LOCAL_PATH)/../algorithm/include \
					$(LOCAL_PATH)/include \
					$(LOCAL_PATH)/../include \
                    $(LOCAL_PATH)/../../manager/include

LOCAL_SRC_FILES := 	 src/ErrorHandlerComponent.c \
					 src/ErrorHandlerApi_priv.c


LOCAL_MODULE    := errorhandler
LOCAL_STATIC_LIBRARIES := libcommon libcommon2 libalgorithm
#LOCAL_LDLIBS := -llog

ifeq ($(SG_SDK_RELEASE), true)
	LOCAL_CFLAGS += $(SG_SDK_CFLAGS)
	LOCAL_CFLAGS += $(SG_OLLVM_STR_OBS)
else
	#LOCAL_CFLAGS += -DDEBUG
endif

include $(BUILD_STATIC_LIBRARY)
