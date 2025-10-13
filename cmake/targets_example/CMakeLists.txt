cmake_minimum_required(VERSION 3.14)

set(target helloworld)
project(${target} C)
message(STATUS "Building ${CMAKE_PROJECT_NAME}")

# add cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(GenHeader)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wpedantic -Wall")

include(CheckCCompilerFlag)
set(arch-native "-march=native")
check_c_compiler_flag(${arch-native} arch-native-supported)
if(arch_native-supported)
    message(STATUS "C Compiler supports ${arch-native} flag")
    # add_compile_options(${arch-native})
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${arch-native}")
else()
    message(STATUS "C Compiler does not support ${arch-native} flag")
endif()

list(APPEND SRC main.c)

# add the CMakeLists for the libhello library
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libhello)

add_executable(${target} ${SRC})

target_link_libraries(${target} libhello)

target_include_directories(${target}
    PRIVATE
        "${CMAKE_CURRENT_BINARY_DIR}")

add_custom_target(stamp
    COMMAND sh -c "date '+%s' > .stamp"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    VERBATIM)

add_dependencies(${target} stamp genheader)

install(TARGETS ${target} RUNTIME)




get_target_property(compile-opts ${target} COMPILE_OPTIONS)
get_target_property(c-standard ${target} C_STANDARD)
get_target_property(include-dirs ${target} INCLUDE_DIRECTORIES)
get_target_property(link-libraries ${target} LINK_LIBRARIES)

message(STATUS "${target} has properties of\n\t- compile options: ${compile-opts}\n\t- c standard ${c-standard}\n\t- include-dirs ${include-dirs}\n\t- link-libraries ${link-libraries}")
