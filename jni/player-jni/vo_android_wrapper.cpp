
#include <pthread.h>
#include <jni.h>
#if PLATFORM < 8
#include <ui/Surface.h>
#elif PLATFORM == 8
#include <surfaceflinger/Surface.h>
#else
#error "?"
#endif
#include "utility.h"

using namespace android;

static pthread_mutex_t mutex;
static int locked = 0;
static Surface* surface = 0;
static char dummy[sizeof(Surface::SurfaceInfo)];
static Surface::SurfaceInfo* info = (Surface::SurfaceInfo*) dummy;

extern "C" {

void createSurfaceLock() {
    pthread_mutex_init(&mutex, 0);
    locked = 0;
}

void destroySurfaceLock() {
    pthread_mutex_lock(&mutex);
    surface = 0;
    locked = 0;
    pthread_mutex_unlock(&mutex);
    pthread_mutex_destroy(&mutex);
}

void lockSurface() {
    pthread_mutex_lock(&mutex);
    if (surface) {
        surface->lock(info);
        locked = -1;
    }
}

void unlockSurface() {
    if (surface) {
        surface->unlockAndPost();
        locked = 0;
    }
    pthread_mutex_unlock(&mutex);
}

void getSurfaceInfo(int* w , int* h, int* s, void** p) {
    if (!locked)
        return;
    if (w)
        *w = info->w;
    if (h)
        *h = info->h;
#if PLATFORM < 8
    if (s)
        *s = info->bpr;
    if (p)
        *p = (reinterpret_cast<int>(info->bits) < 0x0200) ? info->base : info->bits;
#elif PLATFORM == 8
    if (s)
        *s = info->s;
    if (p)
        *p = info->bits;
#else
#error ?
#endif
}

jint attach(JNIEnv* env, jobject thiz, jobject surf) {
    jclass cls = env->GetObjectClass(surf);
    jfieldID fid = env->GetFieldID(cls, "mSurface", "I");
    Surface* ptr = (Surface*)env->GetIntField(surf, fid);
    if (ptr) {
        pthread_mutex_lock(&mutex);
        surface = ptr;
        locked = 0;
        pthread_mutex_unlock(&mutex);
        return 0;
    }
    return -1;
}

void detach(JNIEnv* env, jobject thiz) {
    if (surface) {
        pthread_mutex_lock(&mutex);
        surface = 0;
        locked = 0;
        pthread_mutex_unlock(&mutex);
    }
}

}
