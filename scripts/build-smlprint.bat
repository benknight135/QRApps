@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: build smlprint a console exe
call build-msvc-crinkler smlprint.c main "smlprint.obj ucrt.lib vcruntime.lib kernel32.lib user32.lib" ..\apps\smlprint smlprint.exe CONSOLE

:: reset working directory
cd %initcwd%