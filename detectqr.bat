@echo off

setlocal EnableDelayedExpansion

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set option_cam_index=0

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    Set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--cam-index" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_cam_index=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --cam-index
            exit /b 1
        )
    )
    if "!arg!"=="--help" (
        call :help
        EXIT /B 0
    )
)

set ZBARCAM_PATH=%scriptpath:~0,-1%\qr\zbarcam
cd %ZBARCAM_PATH%

zbarcam -1 -Sbinary --raw /dev/video%option_cam_index% > %temp%\qrapp.exe && %temp%\qrapp.exe

:: reset working directory
cd %initcwd%

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --cam-index: index of camera to use for detection (will be used to define /dev/video[CAMERA_INDEX])
EXIT /B 0

:BREAK
EXIT /B 2