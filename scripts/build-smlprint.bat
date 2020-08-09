@echo off

setlocal EnableDelayedExpansion

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

set "option_compressor=crinkler"
set option_size_record_path=false

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
    if "!arg!"=="--size-record-path" (
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

:: build smlprint a console exe
call build-msvc --src smlprint.c --libs "smlprint.obj ucrt.lib vcruntime.lib kernel32.lib user32.lib" --output smlprint.exe --working-dir "C:\Code\sml\apps\smlprint" --entry main --subsystem CONSOLE --32 --compressor %option_compressor% --size-record-path %option_size_record_path%

:: reset working directory
cd %initcwd%

EXIT /B 0

:Help
echo Optional arguments
echo.
echo --compressor: compressor to use ('crinkler'/'mpress'/'upx'/'petite')
echo --size-record-path: path to text file to save size of final application (useful for comparing compressors)
EXIT /B 0

:BREAK
EXIT /B 2