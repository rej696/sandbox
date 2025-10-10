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
    message(STATUS "- arg: ${arg}")
endforeach()

message(STATUS "in lists:")
set(MY_LIST val1 val2 val3)
foreach(arg IN LISTS MY_LIST)
    message(STATUS "- arg: ${arg}")
endforeach()
unset(MY_LIST)



