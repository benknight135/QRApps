@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set "option_input=%scriptpath:~0,-1%\apps\smlgame\smlgame.exe"
set "option_output=%scriptpath:~0,-1%\apps\smlgame\qr.png"

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    Set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--input" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_input=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --input
            exit /b 1
        )
    )
    if "!arg!"=="--output" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_output=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --output
            exit /b 1
        )
    )
    if "!arg!"=="--help" (
        call :help
        EXIT /B 0
    )
)

SET "QRENCODE_PATH=%scriptpath:~0,-1%\qr\console-qrencode\qrencode\Windows64\waqrencode.exe"

:: check qrencode folder exists
IF NOT EXIST %QRENCODE_PATH% (
    echo qrencode not found
    echo getting submodules...
    call git submodule update --init
    echo submodules received
)

echo generating qr code...
%QRENCODE_PATH% -i %option_input% -o %option_output% -m 5 -s 5

:: reset working directory
cd %initcwd%
echo done.

EXIT /B 0

:Help
echo Required arguments
echo.
echo --input: path of exe to be converted (e.g. path/to/app.exe)
echo --output: filepath of qr code to output (e.g. path/to/file.png)
EXIT /B 0

:BREAK
EXIT /B 2