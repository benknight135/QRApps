@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

SET SOURCE_FILES=%~1
SET ENTRY=%~2
SET LIB_FILES=%~3
SET SOURCE_DIR=%~4
SET OUTPUT_EXE=%~5
SET SUBSYSTEM=%~6

SET "VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
SET "MPRESS_PATH=%scriptpath:~0,-1%\..\compressors\mpress\mpress.exe"

echo Building a 32 bit executable using MSVC
echo Will use the standard install location for Visual Studio 2015
echo %VS_PATH%

:: setup visual studio environment variables
echo Running vcvarsall...
:: call "%VS_PATH%" amd64
call "%VS_PATH%" x86

:: set working directory to source directory
cd %SOURCE_DIR%

:: compile
echo building...
cl /c /W4 /O1 /Os /GS- %SOURCE_FILES%

:: build exe
echo linking...
link /nologo /NODEFAULTLIB /ENTRY:%ENTRY% /ALIGN:16 /SUBSYSTEM:%SUBSYSTEM% /OUT:%OUTPUT_EXE% %LIB_FILES%

:: clean object files
echo cleaning...
del *.obj

:: compress exe using mpress
echo compressing...
%MPRESS_PATH% -s -x %OUTPUT_EXE%

:: reset working directory to script path
cd %scriptpath:~0,-1%
:: print filesize of exe
call filesize.bat "%SOURCE_DIR%\%OUTPUT_EXE%"

:: reset working directory to source directory
cd "%SOURCE_DIR%"
:: run exe
echo running...
%OUTPUT_EXE%

echo done.

:: reset working directory
cd %initcwd%