@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

call build-smlprint.bat
call build-smlwin.bat
call build-smlgame.bat

:: reset working directory
cd %initcwd%