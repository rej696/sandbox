cmake_minimum_required(VERSION 3.14)

set(target helloworld)
project(${target} C)
message(STATUS "Building ${CMAKE_PROJECT_NAME}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wpedantic -Wall")

list(APPEND SRC main.c)

# add the CMakeLists for the libhello library
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libhello)

add_executable(${target} ${SRC})

target_link_libraries(${target} libhello)

add_custom_target(stamp
    COMMAND sh -c "date '+%s' > .stamp"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    VERBATIM)

add_dependencies(${target} stamp)

install(TARGETS ${target} RUNTIME)

