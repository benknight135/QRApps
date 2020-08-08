@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: build smlwin a windows exe
call build-msvc-mpress smlwin.c WinMain "smlwin.obj kernel32.lib user32.lib" ..\apps\smlwin smlwin.exe WINDOWS

:: reset working directory
cd %initcwd%