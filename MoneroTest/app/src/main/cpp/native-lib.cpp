#include <jni.h>
#include <string>
#include <wallet/wallet2.h>



extern "C"
JNIEXPORT jstring JNICALL
Java_com_monero_android_monerotest_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    tools::wallet2 w;
    int i = w.balance();
    std::string hello = std::to_string(i);
    return env->NewStringUTF(hello.c_str());
}
