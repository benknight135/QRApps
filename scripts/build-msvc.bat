@echo off

setlocal EnableDelayedExpansion

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: set default option values
set option_source_files=""
set "option_entry=main"
set "option_subsystem=CONSOLE"
set option_libs=""
set option_output=""
set option_vcvarsall=false
set option_32bit=false
set "option_working_dir=%initcwd%"
set "option_compressor=crinkler"
set option_run=false
SET "option_crinkler_path=%scriptpath:~0,-1%\..\compressors\crinkler23\Win64\Crinkler.exe"
SET "option_mpress_path=%scriptpath:~0,-1%\..\compressors\mpress\mpress.exe"
SET "option_petite_path=%scriptpath:~0,-1%\..\compressors\petite24\petite.exe"
SET "option_upx_path=%scriptpath:~0,-1%\..\compressors\upx-3.96-win64\upx.exe"
set option_size_record_path=false

:: find options in arguments
set /a arg_count=0
FOR %%a IN (%*) DO (
    Set /a arg_count+=1
    set arg=%%a
    if "!arg!"=="--32" (
        set option_32bit=true
    )
    if "!arg!"=="--run" (
        set option_run=true
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
    if "!arg!"=="--crinkler-path" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_crinkler_path=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --crinkler-path
            exit /b 1
        )
    )
    if "!arg!"=="--mpress-path" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_mpress_path=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --mpress-path
            exit /b 1
        )
    )
    if "!arg!"=="--petite-path" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_petite_path=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--upx-path" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_upx_path=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--working-dir" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_working_dir=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--src" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_source_files=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--entry" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_entry=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--subsystem" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_subsystem=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--libs" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_libs=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
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
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--vcvarsall" (
        set /a search_arg_num=!arg_count!+1
        set /a arg_count_b=0
        set option_var_found=false
        FOR %%b IN (%*) DO (
            Set /a arg_count_b+=1
            if !arg_count_b!==!search_arg_num! (
                set option_vcvarsall=%%b
                set option_var_found=true
                call :break
            )
        )
        if "%option_var_found%"=="false" (
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
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
            echo variable missing after option --petite-path
            exit /b 1
        )
    )
    if "!arg!"=="--help" (
        call :help
        EXIT /B 0
    )
)

:: TODO check required options have been set

:: dequote
CALL :dequote option_libs
CALL :dequote option_working_dir

if "%option_vcvarsall%" NEQ "false" (
    :: setup visual studio environment variables
    if "%option_32bit%"=="true" (
        echo Setting environment variables for 32bit MSVC build...
        call "%option_vcvarsall%" x86
    ) else (
        echo Setting environment variables for 64bit MSVC build...
        call "%option_vcvarsall%" amd64
    )
)

:: set working directory to source directory
cd "%option_working_dir%"

:: compile
echo Compiling...
cl /c /W4 /O1 /Os /GS- %option_source_files%

:: link
echo Linking...
if "%option_compressor%"=="crinkler" (
    :: crinkler replaces linker
    %option_crinkler_path% /nologo /ENTRY:%option_entry% /NODEFAULTLIB /ALIGN:16 /SUBSYSTEM:%option_subsystem% /OUT:%option_output% %option_libs%
) else (
    :: compress
    if "%option_compressor%"=="mpress" (
        link /nologo /ENTRY:%option_entry% /NODEFAULTLIB /ALIGN:16 /SUBSYSTEM:%option_subsystem% /OUT:%option_output% %option_libs%
        echo Compressing...
        %option_mpress_path% -s -x -i %option_output%
    ) else (
        if "%option_compressor%"=="upx" (
            :: upx cannot use /ALIGN:16
            link /nologo /ENTRY:%option_entry% /NODEFAULTLIB /SUBSYSTEM:%option_subsystem% /OUT:%option_output% %option_libs%
            echo Compressing...
            %option_upx_path% %option_output%
        ) else (
            if "%option_compressor%"=="petite" (
                :: petite cannot use /ALIGN:16
                link /nologo /ENTRY:%option_entry% /NODEFAULTLIB /SUBSYSTEM:%option_subsystem% /OUT:%option_output% %option_libs%
                echo Compressing...
                %option_petite_path% %option_output% -9 -e2 -y
            ) else (
                :: no compressor
                link /nologo /ENTRY:%option_entry% /NODEFAULTLIB /ALIGN:16 /SUBSYSTEM:%option_subsystem% /OUT:%option_output% %option_libs%
            )
        )
    )
)

:: clean object files
echo Cleaning...
del *.obj

:: reset working directory to script path
cd %scriptpath:~0,-1%
:: print filesize of exe
call filesize.bat "%option_working_dir%\%option_output%" out_file_size

:: append filesize of exe to text file
if "%option_size_record_path%" NEQ "false" (
    echo %option_size_record_path%
    ECHO %option_compressor% !out_file_size!>>"%option_size_record_path%"
)

if "%option_run%"=="true" (
    :: reset working directory to source directory
    cd "%option_working_dir%"
    :: run exe
    echo Running...
    %option_output%
)

echo Done.

:: reset working directory
cd %initcwd%

EXIT /B 0

:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A
EXIT /B 0

:Help
echo Required arguments
echo --src: list source files for build (e.g. 'smlgame.c')
echo --libs: list of library files for build including obj files (e.g. 'smlgame.obj kernel32.lib user32.lib gdi32.lib')
echo --output: output exe filepath (e.g. 'app.exe')
echo --working-dir: working directory for build (source files are found relative to this directory)
echo.
echo Optional arguments
echo --entry: entry point in program (usually 'main' or 'winmain')
echo --subsystem: subsystem for build (usually 'CONSOLE' or 'WINDOWS')
echo --size-record-path: path to text file to save size of final application (useful for comparing compressors)
echo --vcvarsall: path to msvc varsall batch script (if empty assumes you have already setup msvc variables or running in an MSVC command prompt)
echo --32: build a 32 bit application (omit to build 64bit)
echo --compressor: compressor to use ('crinkler'/'mpress'/'upx'/'petite')
echo --run: run the application after build (omit to not run)
echo --crinkler-path: path to crinkler application
echo --mpress-path: path to mpress application
echo --petite-path: path to petite application
echo --upx-path: path to upx application
echo.
echo Examples
echo.
echo Build smlgame windows application
echo build-msvc.bat --src smlgame.c --libs "smlgame.obj kernel32.lib user32.lib gdi32.lib" --output smlgame.exe --working-dir "C:\Code\sml\apps\smlgame" --entry WinMain --subsystem WINDOWS --32 --compressor off
echo.
echo Build smlgame windows application with crinkler compression
echo build-msvc.bat --src smlgame.c --libs "smlgame.obj kernel32.lib user32.lib gdi32.lib" --output smlgame.exe --working-dir "C:\Code\sml\apps\smlgame" --entry WinMain --subsystem WINDOWS --32 --compressor crinkler
echo.
echo Build smlprint console application with mpress compression
echo build-msvc.bat --src smlprint.c --libs "smlprint.obj ucrt.lib vcruntime.lib kernel32.lib user32.lib" --output smlprint.exe --working-dir "C:\Code\sml\apps\smlprint" --entry main --subsystem CONSOLE --32 --compressor mpress
echo.
EXIT /B 0

:BREAK
EXIT /B 2