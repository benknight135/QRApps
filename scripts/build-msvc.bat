@echo off

SET "SOURCE_FILES=$1"
SET "SOURCE_DIR=$2"

cd "%SOURCE_DIR%"

SET "VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"

echo Building a 32 bit executable using MSVC
echo Will use the standard install location for Visual Studio 2015
echo %VS_PATH%

echo Running vcvarsall...

:: call "%VS_PATH%" amd64
call "%VS_PATH%" x86

echo building...

cl /c /W4 /O1 /Os /GS- %SOURCE_FILES%

echo linking...

link /nologo /ENTRY:main /NODEFAULTLIB /SUBSYSTEM:CONSOLE sml.obj ucrt.lib

echo cleaning...

del *.obj

echo running...

sml.exe

echo done.

pause