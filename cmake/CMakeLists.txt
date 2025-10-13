cmake_minimum_required(VERSION 3.14)
project(test)

###### Variables ######
message(STATUS "---VARIABLES---")

# Set and unset variables
set(TEST "42")
message(STATUS "TEST value is ${TEST}")
unset(TEST)


# Scope:
# - "include" module doesn't create a scope
# - "add_subdirectory" creates new scope
# - Variables are scoped by function
# - Scope can be extended with "PARENT_SCOPE"
function(test)
    set(TEST "365")
    set(TEST_EXTENDED "25" PARENT_SCOPE)
endfunction()

test()
message(STATUS "undefined: ${TEST}")
message(STATUS "defined: ${TEST_EXTENDED}")
unset(TEST_EXTENDED)



# Cache:
# - global cache can make variables persitent and global, e.g. for options
# - located in ${CMAKE_BINARY_DIR}/CMakeCache.txt
# - `ccmake` and `make edit_cache` edit the cache variables
# - Use FORCE to overide the entry if they already exist.
# - require type and docstring
set(TEST_CACHE_FORCE "42" CACHE STRING "Test Variable" FORCE)
set(TEST_CACHE "42" CACHE STRING "Test Variable")
message(STATUS "TEST_CACHE value is: ${TEST_CACHE}")
message(STATUS "TEST_CACHE_FORCE value is: ${TEST_CACHE_FORCE}")


# Lists:
# - Variables are also lists
# - separated with ';' in a string
set(TEST_LIST "42" "44")

# Append
list(APPEND TEST_LIST "45")

# Loop over list
foreach(iter IN LISTS TEST_LIST)
    message(STATUS "item in TEST_LIST: ${iter} in ${TEST_LIST}")
endforeach()

unset(TEST_LIST)


# Environment Variables
message(STATUS "Got this from env: $ENV{SHELL}")

# Recursive variable expansion
set(OPT_arm "arm specific value")
set(ARCH "arm")
message(STATUS "Your opt is ${OPT_${ARCH}}")


###### Conditionals and Loops ######

# Constant Literals:
# - falsy: 0, OFF, NO, FALSE, N, IGNORE, NOTFOUND, <string>-NOTFOUND
# - truthy: 1, ON, YES, TRUE, Y, <any non-zero number>
# Everything else is variable name

# Conditional Keywords:
# - logical: NOT, AND, OR
# - strings: STREQUAL, STRGREATER...
# - numbers: EQUAL, GREATER...
# - versions: VERSION_EQUAL...

# Extra Keywords:
# - COMMAND <name>: true if name is a command, function or macro
# - POLICY <name>: true if the policy exists
# - TARGET <name>: true if the target exists
# - DEFINED <name>: true if the variable is defined
# - EXISTS, IS_DIRECTORY, IS_SYMLINK, IS_ABSOLUTE: path/filesystem checks

# Variables are automatically expanded and tested
# Strings don't have to be quoted
message(STATUS "---CONDITIONALS---")
set(TEST_1 True)
set(TEST_2 False)
set(TEST_3 "my value")
unset(TEST_4)

if(TEST_1 AND TEST_3)
    message(STATUS "this is true")
endif()

if(NOT TEST_2 AND NOT TEST_4)
    message(STATUS "this is not false")
endif()

unset(TEST_1)
unset(TEST_2)
unset(TEST_3)
unset(TEST_4)


message(STATUS "---VERSIONS---")
set(VERSION "1.3.4")

if(VERSION VERSION_LESS "1.5")
    message(STATUS "Version ${VERSION} is less than 1.5")
endif()

if(VERSION STREQUAL "1.3.4")
    message(STATUS "Version ${VERSION} is 1.3.4")
endif()
unset(VERSION)


message(STATUS "---LOOPS---")
message(STATUS "items:")
foreach(arg val1 val2 val3)
    message(STATUS "  - arg: ${arg}")
endforeach()

message(STATUS "in items:")
foreach(arg IN ITEMS val1 val2 val3)
    message(STATUS "  - arg: ${arg}")
endforeach()

message(STATUS "in lists:")
set(MY_LIST val1 val2 val3)
foreach(arg IN LISTS MY_LIST)
    message(STATUS "  - arg: ${arg}")
endforeach()
unset(MY_LIST)



message(STATUS "---FUNCTIONS---")
# - Functions create new scope, macros don't
# - Both use named or positional arguments
#   - ARGC is the
#   - ARGN is the positional unnamed args
#   - ARGV is all the positional arguments (access with ARGV0, ARGV1, ...)
#   - see `cmake --help-command function | less`
#   - if you want to get specific unnamed arguments, you have to use list commands to retrieve them from ARGN into variables:
#       - `list(GET ARGN 0 first_argument)`
# - macro arguments are not real variables (there are specific rules)

function(print message)
    message(STATUS "called print function with [${ARGV}]")
    # use named argument
    message(STATUS "  message: ${message}")

    list(GET ARGN 0 first_unnamed_arg)

    message(STATUS "  first unnamed arg: ${first_unnamed_arg}")

    # loop over positional arguments
    foreach(arg IN LISTS ARGN)
        message(STATUS "  arg: ${arg}")
    endforeach()
endfunction()

print("test" "33")

print("test 2" "34" "27")


# - Built in cmake function for parsing arguments: `cmake_parse_arguments`
# - This is often used for optional keyword <args..> type arguments (like SOURCES <source list> HEADERS <header list>) etc.
function(sample)
    cmake_parse_arguments(local "BOOLOPT" "ONEVAL" "MULTI" ${ARGN})

    if(local_BOOLOPT)
        message(STATUS "BOOLOPT is enabled")
    endif()
    message(STATUS "ONEVAL: ${local_ONEVAL}")

    foreach(arg IN LISTS local_MULTI)
        message(STATUS "MULTI arg: ${arg}")
    endforeach()
endfunction()

sample(ONEVAL "val" MULTI "mval1" "mval2" BOOLOPT)

# Builtin commands (functions and macros include):
# - project: declare your project
# - set, unset, list: manipulate variables
# - if, endif, foreach: control macros
# - add_library, add_executable: create a library or exectuable target
# - include_directories, link_libraries: use dependecies
# - install: install rules for files/targets/directories
# - execute_process: run external command

function(get_date var_name)
    execute_process(COMMAND date OUTPUT_VARIABLE "${var_name}" OUTPUT_STRIP_TRAILING_WHITESPACE)
    set("${var_name}" "${${var_name}}" PARENT_SCOPE)
endfunction()

get_date(my_date)
message(STATUS "Date from function get_date: ${my_date}")

execute_process(COMMAND ${CMAKE_COMMAND} -E sleep 1s)

macro(get_date_macro var_name)
    execute_process(COMMAND date OUTPUT_VARIABLE "${var_name}" OUTPUT_STRIP_TRAILING_WHITESPACE)
endmacro()

get_date_macro(my_date)
message(STATUS "Date from macro get_date_macro: ${my_date}")
unset(my_date)


message(STATUS "----TARGETS----")

# add_executable, add_library and add_custom_target all create targets:

# add_executable(test test.c)
# add_library(testlib STATIC lib.c)
# add_library(testlib SHARED lib.c)
# add_library(testlib lib.c) # (BUILD_SHARED_LIBS option determines if library is static (default) or shared)

# link libraries with target:
# target_link_libraries(testlib z pthread otherlib)

# includes:
# target_include_directories(testlib PRIVATE ${CMAKE_SOURCE_DIR}/inc)

# external/system includes:
# target_include_directories(testlib SYSTEM PRIVATE ${MYDEP_INCLUDE_DIRS})

# public includes (i.e. any targets using this library as dependency get access to these directories)
# target_include_directories(testlib PUBLIC ${CMAKE_SOURCE_DIR}/inc)

# these can be used without specifying "target_" and the target name, but we shouldn't do this

# can create custom targets

# add_custom_target(rpm-package
#     COMMAND "${CPACK_COMMAND}" -G RPM
#     COMMENT "Build an rpm package")

add_custom_target(git_check ALL DEPENDS .git_version)
add_custom_command(
    OUTPUT .git_version
    COMMAND sh -c "git log --pretty=format:'' | wc -l | tr -d ' ' > .git_version"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    DEPENDS "${CMAKE_SOURCE_DIR}/.git" VERBATIM)

# install command used to provide files to be packaged with the target
# install(TARGETS testlib
#     LIBRARY DESTINATION "lib" COMPONENT Runtime
#     ARCHIVE DESTINATION "lib" COMPONENT Devel)
# install(FILES test.h DESTINATION include COMPONENT Devel)


