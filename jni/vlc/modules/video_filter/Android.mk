
LOCAL_PATH := $(call my-dir)

# libblend_plugin.so

include $(CLEAR_VARS)

LOCAL_MODULE := blend_plugin

LOCAL_CFLAGS += \
    -std=c99 \
    -D__THROW= \
    -DHAVE_CONFIG_H \
    -DNDEBUG \
    -D__PLUGIN__ \
    -DMODULE_STRING=\"blend\"

LOCAL_C_INCLUDES += \
    $(VLCROOT)/compat \
    $(VLCROOT) \
    $(VLCROOT)/include \
    $(VLCROOT)/src

LOCAL_SRC_FILES := \
    blend.c

LOCAL_SHARED_LIBRARIES += vlccore

include $(BUILD_SHARED_LIBRARY)

# libswscale_plugin-6.so

include $(CLEAR_VARS)

LOCAL_MODULE := swscale_plugin-6

LOCAL_CFLAGS += \
    -std=c99 \
    -D__THROW= \
    -DHAVE_CONFIG_H \
    -DNDEBUG \
    -D__PLUGIN__ \
    -DMODULE_STRING=\"swscale\"

LOCAL_C_INCLUDES += \
    $(VLCROOT)/compat \
    $(VLCROOT) \
    $(VLCROOT)/include \
    $(VLCROOT)/src \
    $(EXTROOT)/ffmpeg \
    $(VLCROOT)/modules/codec/avcodec

LOCAL_SRC_FILES := \
    chroma.c \
    swscale.c

LOCAL_SHARED_LIBRARIES += vlccore ffmpeg-6

include $(BUILD_SHARED_LIBRARY)

# libswscale_plugin-7.so

include $(CLEAR_VARS)

LOCAL_MODULE := swscale_plugin-7

LOCAL_CFLAGS += \
    -std=c99 \
    -D__THROW= \
    -DHAVE_CONFIG_H \
    -DNDEBUG \
    -D__PLUGIN__ \
    -DMODULE_STRING=\"swscale\"

LOCAL_C_INCLUDES += \
    $(VLCROOT)/compat \
    $(VLCROOT) \
    $(VLCROOT)/include \
    $(VLCROOT)/src \
    $(EXTROOT)/ffmpeg \
    $(VLCROOT)/modules/codec/avcodec

LOCAL_SRC_FILES := \
    chroma.c \
    swscale.c

LOCAL_SHARED_LIBRARIES += vlccore ffmpeg-7

include $(BUILD_SHARED_LIBRARY)

# libvideo_filter_wrapper_plugin.so

include $(CLEAR_VARS)

LOCAL_MODULE := video_filter_wrapper_plugin

LOCAL_CFLAGS += \
    -std=c99 \
    -D__THROW= \
    -DHAVE_CONFIG_H \
    -DNDEBUG \
    -D__PLUGIN__ \
    -DMODULE_STRING=\"video_filter_wrapper\"

LOCAL_C_INCLUDES += \
    $(VLCROOT)/compat \
    $(VLCROOT) \
    $(VLCROOT)/include \
    $(VLCROOT)/src

LOCAL_SRC_FILES := \
    wrapper.c

LOCAL_SHARED_LIBRARIES += vlccore

include $(BUILD_SHARED_LIBRARY)
