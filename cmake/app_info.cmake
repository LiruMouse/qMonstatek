set(APP_VER "v0.0.0-tagless")
find_package(Git REQUIRED)
if(GIT_FOUND)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --tags --always --dirty
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE APP_VER
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
endif()
string(REGEX REPLACE "^v" "" APP_VER "${APP_VER}")

string(CONFIGURE [[
#pragma once

namespace app_info {
    inline constexpr auto version = "@APP_VER@";
}
]] APP_INFO_GEN @ONLY)
file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/src/gen/app_info.h" "${APP_INFO_GEN}")
