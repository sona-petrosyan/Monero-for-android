# Monero-for-android

This project provides scripts for compiling the latest monero for Android. The scripts download and compile openssl and boost libraries.
The usage of the project is the following:
  - MoneroTest Android application and tools folder should be located <b>next</b> to the monero project.
  - Change directory to tools
  - Execute "$ ./android-build NDK_PATH ARCH" (where ARCH can be arm64 or arm).
  - After compiling is complete, open Android Studio
  - Open MoneroTest application
  - Run
  
The script will compile OpenSSL, BOOST and monero and copy all necessary libraries to MoneroTest Android application. The versions of OpenSSL and BOOST libraries can be modified from the tools/android-build. If there is no need to build OpenSSL or Boost, the flags BUILD_SSL or BUILD_BOOST can be set to false in tools/android-build.

Currently there is an issue with compiling for arm architecture.
