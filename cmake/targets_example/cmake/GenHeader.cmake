if(NOT CMAKE_SCRIPT_MODE_FILE)
    add_custom_target(genheader
        COMMAND
            "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_LIST_FILE}"
        BYPRODUCTS
            genheader.h
    )
else()
    execute_process(
        COMMAND date
        OUTPUT_VARIABLE DATE
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    message(STATUS "Writing genheader.h file")
    file(WRITE genheader.h "#define DATE \"${DATE}\"")
endif()
