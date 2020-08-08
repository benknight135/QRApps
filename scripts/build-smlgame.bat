@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: build smlgame a windows exe game
call build-msvc-crinkler "smlgame.c" WinMain "smlgame.obj kernel32.lib user32.lib gdi32.lib" ..\apps\smlgame smlgame.exe WINDOWS

:: reset working directory
cd %initcwd%