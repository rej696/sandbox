
set(target libhello)
message(STATUS "Building ${CMAKE_PROJECT_NAME}/${target}")
add_library(${target} STATIC)

target_sources(${target}
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/helloworld.c
    # PUBLIC
    #     FILESET HEADERS
    #     BASE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/inc
    #     FILES
    #         helloworld.h
)

message(STATUS "libhello src dir is ${CMAKE_CURRENT_SOURCE_DIR}")

target_include_directories(${target}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)
