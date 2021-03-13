# cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(app_library)
add_library(app_library SHARED hello.cpp hello.def)

set_target_properties(app_library PROPERTIES
    PUBLIC_HEADER hello.h
    # SOVERSION 1
    OUTPUT_NAME "hello"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
