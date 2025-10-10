cmake_minimum_required(VERSION 3.14)

project(helloworld C)
message(STATUS "Building ${CMAKE_PROJECT_NAME}")

if(IS_DIRECTORY "${CMAKE_SOURCE_DIR}/.git")
    message(STATUS "This is a git repository")
endif()

if(DEFINED ENV{TEST})
    message(STATUS "Test variable defined as: $ENV{TEST}")
endif()

# Uses the special cases from the Path Comparisons section of `cmake --help-command if` to identify the OS
if(IS_ABSOLUTE "~/")
    message(STATUS "Unix based system")
elseif(IS_ABSOLUTE "C:\\")
    message(STATUS "Windows based system")
else()
    message(STATUS "Who knows what OS this is")
endif()

# alternatively
if(UNIX)
    message(STATUS "UNIX 4 Eva <3")
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wpedantic -Wall")

list(APPEND SRC helloworld.c)

add_executable(helloworld ${SRC})
