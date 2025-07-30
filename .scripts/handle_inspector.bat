@echo off
setlocal enabledelayedexpansion

set "APP_DIR=%~dp0"
set "HANDLE_EXE=%APP_DIR%handle.exe"
set "TMP_OUTPUT=%APP_DIR%handle_output.tmp"
set "TMP_FILTERED=%APP_DIR%handle_filtered.tmp"

if "%~1"=="" (
    echo ERROR: No file or folder path provided.
    pause
    exit /b 1
)
set "INPUT_LINE=%~1"

if not exist "%HANDLE_EXE%" (
    echo ERROR: handle.exe not found in app folder.
    pause
    exit /b 1
)

set PREFIX=!INPUT_LINE:~0,6!

if /i "%PREFIX%"=="FOLDER" (
    set "FOLDER_PATH=!INPUT_LINE:~6!"

    if not exist "!FOLDER_PATH!" (
        echo ERROR: Folder path not found: !FOLDER_PATH!
        pause
        exit /b 1
    )

    "%HANDLE_EXE%" -accepteula > "%TMP_OUTPUT%"
    
    findstr /i /c:"!FOLDER_PATH!" "%TMP_OUTPUT%" > "%TMP_FILTERED%"

    if not exist "%TMP_FILTERED%" (
        echo No handles found for folder.
        pause
        exit /b 0
    )

    echo Info:
    set "ECHO_COUNT=0"
    for /f "tokens=4,* delims= " %%L in (%TMP_FILTERED%) do (
        set "FILE_PATH=%%L"
        if not "%%M"=="" set "FILE_PATH=!FILE_PATH! %%M"
        set "FILE_PATH=!FILE_PATH:"=!"

        if exist "!FILE_PATH!" (
            set "ECHO_COUNT=1"
            echo ---------------------------------
            echo File: !FILE_PATH!

            for /f "skip=4 delims=" %%R in ('%HANDLE_EXE% -accepteula "!FILE_PATH!"') do (
                for /f "tokens=1" %%P in ("%%R") do (
                    set "PROCESS_NAME=%%P"
                    set "PROCESS_NAME=!PROCESS_NAME:"=!"

                    set "FLAG=0"
                    for /f "tokens=*" %%A in ('wmic process where "name='!PROCESS_NAME!'" get ProcessId^,ExecutablePath /format:value 2^>nul') do (
                        for /f "tokens=1,2 delims==" %%B in ("%%A") do (
                            if /i "%%B"=="ExecutablePath" if "!FLAG!"=="0" (
                                set "PROCESS_PATH=%%C"
                            )
                            if /i "%%B"=="ProcessId" if "!FLAG!"=="0" (
                                set "PROCESS_PID=%%C"
                            )
                            if defined PROCESS_PATH if defined PROCESS_PID if "!FLAG!"=="0" (
                                echo     Process: !PROCESS_NAME!
                                echo         Path: !PROCESS_PATH!
                                echo         PID: !PROCESS_PID!
                                set "FLAG=1"
                            )
                        )
                    )
                )
            )
            echo.
        )
    )
    if "!ECHO_COUNT!"=="0" (
        echo There are no active processes using these files
    )

    del "%TMP_OUTPUT%" >nul 2>&1
    del "%TMP_FILTERED%" >nul 2>&1

) else (
    if not exist "%INPUT_LINE%" (
        echo ERROR: File not found: %INPUT_LINE%
        pause
        exit /b 1
    )

    echo.
    echo Nthandle v5.0 - Handle viewer
    echo Copyright ^(C^) 1997-2022 Mark Russinovich
    echo Sysinternals - www.sysinternals.com
    echo.

    echo Info:
    echo ---------------------------------
    echo File: %INPUT_LINE%
    set "ECHO_COUNT=0"
    for /f "skip=4 delims=" %%R in ('%HANDLE_EXE% -accepteula "%INPUT_LINE%"') do (
        for /f "tokens=1" %%P in ("%%R") do (
            set "PROCESS_NAME=%%P"
            set "PROCESS_NAME=!PROCESS_NAME:"=!"

            set "FLAG=0"
            for /f "tokens=*" %%A in ('wmic process where "name='!PROCESS_NAME!'" get ProcessId^,ExecutablePath /format:value 2^>nul') do (
                for /f "tokens=1,2 delims==" %%B in ("%%A") do (
                    if /i "%%B"=="ExecutablePath" if "!FLAG!"=="0" (
                        set "PROCESS_PATH=%%C"
                    )
                    if /i "%%B"=="ProcessId" if "!FLAG!"=="0" (
                        set "PROCESS_PID=%%C"
                    )
                    if defined PROCESS_PATH if defined PROCESS_PID if "!FLAG!"=="0" (
                        set "ECHO_COUNT=1"
                        echo     Process: !PROCESS_NAME!
                        echo         Path: !PROCESS_PATH!
                        echo         PID: !PROCESS_PID!
                        set "FLAG=1"
                    )
                )
            )
        )
    )
    if "!ECHO_COUNT!"=="0" (
        echo There are no active processes using this file
    )
    echo.
)

pause