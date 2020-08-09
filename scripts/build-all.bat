@echo off

setlocal EnableDelayedExpansion

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set "option_compressor=crinkler"

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    Set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--compressor" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_compressor=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --compressor
            exit /b 1
        )
    )
    if "!arg!"=="--help" (
        call :help
        EXIT /B 0
    )
)

call build-smlprint --compressor %option_compressor%
call build-smlwin --compressor %option_compressor%
call build-smlgame --compressor %option_compressor%

:: reset working directory
cd %initcwd%

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --compressor: compressor to use ('crinkler'/'mpress'/'upx'/'petite')
EXIT /B 0

:BREAK
EXIT /B 2