@echo off

SET "VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
SET "CR_PATH=..\crinkler23\Win64\Crinkler.exe"

echo Building a 64 bit executable using MSVC and crinkler
echo Will use the standard install location for Visual Studio 2015
echo %VS_PATH%

echo Running vcvarsall...

call "%VS_PATH%" amd64

echo building...

cl /c /W4 /O1 /Os /GS- sml.c

echo linking...

%CR_PATH% /ENTRY:main /NODEFAULTLIB /SUBSYSTEM:CONSOLE /OUT:sml.exe sml.obj ucrt.lib

echo cleaning...

del *.obj

echo running...

sml.exe

echo done.