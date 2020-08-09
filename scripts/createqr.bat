@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

SET "QRENCODE_PATH=%scriptpath:~0,-1%\..\qr\console-qrencode\qrencode\Windows64\waqrencode.exe"
SET "APP_PATH=%scriptpath:~0,-1%\..\apps\smlgame\smlgame.exe"
SET "OUTPUT_PATH=%scriptpath:~0,-1%\..\apps\smlgame\qr.png"

:: check qrencode folder exists
IF EXIST QRENCODE_PATH (
    echo qrencode found
) ELSE (
    echo qrencode not found
    echo getting submodules...
    call git submodule update --init
    echo submodules received
)

echo generating qr code...
%QRENCODE_PATH% -i %APP_PATH% -o %OUTPUT_PATH%

:: reset working directory
cd %initcwd%

echo done.