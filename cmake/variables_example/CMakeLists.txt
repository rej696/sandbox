cmake_minimum_required(VERSION 3.14)

project(helloworld C)
message("Building ${CMAKE_PROJECT_NAME}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wpedantic -Wall")

list(APPEND SRC helloworld.c)

add_executable(helloworld ${SRC})
