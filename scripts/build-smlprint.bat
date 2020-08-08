@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: build smlprint a console exe
call build-msvc-mpress smlprint.c main "smlprint.obj ucrt.lib" ..\apps\smlprint smlprint.exe CONSOLE

:: reset working directory
cd %initcwd%