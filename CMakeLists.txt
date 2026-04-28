cmake_minimum_required(VERSION 3.21)
project(qmonstatek LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Qt6 modules
find_package(Qt6 REQUIRED COMPONENTS
    Core Gui Quick QuickControls2 SerialPort Network
)
qt_policy(SET QTP0004 NEW)

option(BUILD_TESTS "Build unit tests" OFF)

include(cmake/app_info.cmake)
add_subdirectory(src)

if(BUILD_TESTS)
    enable_testing()
    find_package(Qt6 COMPONENTS Test)
    if(Qt6Test_FOUND)
        add_subdirectory(tests)
    endif()
endif()

# Deploy and Sign
if(APPLE)
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/deploy_mac.cmake.in" "${CMAKE_CURRENT_BINARY_DIR}/deploy_mac.cmake" @ONLY)
    install(SCRIPT "${CMAKE_CURRENT_BINARY_DIR}/deploy_mac.cmake")
endif()
