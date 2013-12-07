IF(CMAKE_HOST_WIN32) #true for win64 also
    IF(USE_MINGW_W64)
        SET(MINGW_RUNTIME_DLL_SIMPLE_FILENAME "libgcc_s_seh-1.dll")
    ELSE()
        SET(MINGW_RUNTIME_DLL_SIMPLE_FILENAME "mingwm10.dll")
    ENDIF()

    MESSAGE("-- Looking for ${MINGW_RUNTIME_DLL_SIMPLE_FILENAME}")

    GET_FILENAME_COMPONENT(COMPILER_BIN_DIR "${CMAKE_CXX_COMPILER}" PATH)

    FIND_FILE(MINGW_RUNTIME_DLL_FILENAME "${MINGW_RUNTIME_DLL_SIMPLE_FILENAME}" "$ENV{PATH}" "${COMPILER_BIN_DIR}")
    MARK_AS_ADVANCED(MINGW_RUNTIME_DLL_FILENAME)

    IF(MINGW_RUNTIME_DLL_FILENAME)
        MESSAGE("-- Looking for ${MINGW_RUNTIME_DLL_SIMPLE_FILENAME} - found: ${MINGW_RUNTIME_DLL_FILENAME}")
    ELSE()
        MESSAGE(FATAL_ERROR "${MINGW_RUNTIME_DLL_SIMPLE_FILENAME} not found. Please point cmake to ${MINGW_RUNTIME_DLL_SIMPLE_FILENAME} using GUI or -DMINGW_RUNTIME_DLL_FILENAME=<path-to-dll> option.")
    ENDIF()

    IF (CYGWIN)
        # CygWin
        FIND_PROGRAM(CYGPATH_EXE_FILENAME "cygpath.exe" $ENV{PATH})
        IF(CYGPATH_EXE_FILENAME)
            MESSAGE("-- Looking for cygpath.exe - found: ${CYGPATH_EXE_FILENAME}")
        ELSE()
            MESSAGE(FATAL_ERROR "cygpath.exe not found. Please point cmake to mingwm10.dll using GUI or -DCYGPATH_EXE_FILENAME=<path-to-exe> option.")
        ENDIF()

        MARK_AS_ADVANCED(CYGPATH_EXE_FILENAME)
    ENDIF()

ENDIF(CMAKE_HOST_WIN32)
