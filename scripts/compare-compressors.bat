@echo off

setlocal EnableDelayedExpansion

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set "option_size_record_path=%scriptpath:~0,-1%\..\compressors\compare.txt"

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    Set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--output" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_size_record_path=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --size-record-path
            exit /b 1
        )
    )
    if "!arg!"=="--help" (
        call :help
        EXIT /B 0
    )
)

if "%option_size_record_path%" NEQ "false" (
    :: clear text file
    del %option_size_record_path%
)
:: build smlgame with each compressor
call build-smlgame --compressor off --size-record-path %option_size_record_path%
call build-smlgame --compressor crinkler --size-record-path %option_size_record_path%
call build-smlgame --compressor upx --size-record-path %option_size_record_path%
call build-smlgame --compressor mpress --size-record-path %option_size_record_path%
call build-smlgame --compressor petite --size-record-path %option_size_record_path%

:: reset working directory
cd %initcwd%

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --output: path to text file to save application sizes
EXIT /B 0

:BREAK
EXIT /B 2