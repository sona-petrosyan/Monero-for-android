# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

add_library( # Sets the name of the library.
             native-lib

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             src/main/cpp/native-lib.cpp )

# configure import libs
set(monero_DIR ${CMAKE_SOURCE_DIR}/../../monero/)
set(libs_DIR ${CMAKE_SOURCE_DIR}/../../libs/)
add_library(lib_wallet SHARED IMPORTED)
set_target_properties(lib_wallet PROPERTIES IMPORTED_LOCATION
    ${monero_DIR}/build/release.${ANDROID_ABI}/src/wallet/libwallet.so)

add_library(lib_easylogging SHARED IMPORTED)
set_target_properties(lib_easylogging PROPERTIES IMPORTED_LOCATION
    ${monero_DIR}/build/release.${ANDROID_ABI}/external/easylogging++/libeasylogging.so)

add_library(lib_cryptonote_basic SHARED IMPORTED)
set_target_properties(lib_cryptonote_basic PROPERTIES IMPORTED_LOCATION
    ${monero_DIR}/build/release.${ANDROID_ABI}/src/cryptonote_basic/libcryptonote_basic.so)

#### BOOST ####

add_library(boost_chrono STATIC IMPORTED)
set_target_properties(boost_chrono PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_chrono.a)

add_library(boost_date_time STATIC IMPORTED)
set_target_properties(boost_date_time PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_date_time.a)

add_library(boost_filesystem STATIC IMPORTED)
set_target_properties(boost_filesystem PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_filesystem.a)

add_library(boost_program_options STATIC IMPORTED)
set_target_properties(boost_program_options PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_program_options.a)

add_library(boost_regex STATIC IMPORTED)
set_target_properties(boost_regex PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_regex.a)

add_library(boost_serialization STATIC IMPORTED)
set_target_properties(boost_serialization PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_serialization.a)

add_library(boost_system STATIC IMPORTED)
set_target_properties(boost_system PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_system.a)

add_library(boost_thread STATIC IMPORTED)
set_target_properties(boost_thread PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_thread.a)

add_library(boost_wserialization STATIC IMPORTED)
set_target_properties(boost_wserialization PROPERTIES IMPORTED_LOCATION
    ${libs_DIR}/${ANDROID_ABI}/boost/lib/libboost_wserialization.a)

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

find_library( # Sets the name of the path variable.
              log-lib

              # Specifies the name of the NDK library that
              # you want CMake to locate.
              log )

target_include_directories(
                           native-lib PRIVATE
                           ${monero_DIR}/src
                           ${monero_DIR}/contrib/epee/include
                           ${monero_DIR}/external/easylogging++
                           ${monero_DIR}/external/
                           ${monero_DIR}/../include)


# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries( # Specifies the target library.
                       native-lib

                       #monero lib
                       lib_wallet
                       lib_easylogging
                       lib_cryptonote_basic

                       #boost libraries
                       boost_chrono
                       boost_date_time
                       boost_filesystem
                       boost_program_options
                       boost_regex
                       boost_serialization
                       boost_system
                       boost_thread
                       boost_wserialization


                       # Links the target library to the log library
                       # included in the NDK.
                       ${log-lib} )