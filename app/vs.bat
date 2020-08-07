@echo off

SET "VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"

echo Building a 64 bit executable using MSVC
echo Will use the standard install location for Visual Studio 2015
echo %VS_PATH%

echo Running vcvarsall...

call "%VS_PATH%" amd64

echo done.