@echo off

SET initcwd=%cd%
SET scriptpath=%~dp0
cd %scriptpath:~0,-1%

:: get zbar path from script location
set ZBAR_PATH=%scriptpath:~0,-1%\..\qr\zbar

:: check qrencode folder exists
IF NOT EXIST %ZBAR_PATH% (
    echo zbar not found
    echo getting submodules...
    call git submodule update --init
    echo submodules received
)

:: install chocolatey
powershell -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

:: refresh path varaible
call refresh-path
:: install msys2, make and mingw
choco install -r --no-progress -y msys2 make mingw
:: refresh path
call refresh-path

:: find msys2 install location
FOR /F "tokens=* USEBACKQ" %%F IN (`where msys2`) DO (
SET MSYS_PATH=%%F
)
FOR %%i IN ("%MSYS_PATH%") DO (
    set MSYS_DRIVE=%%~di
    set MSYS_FOLDER=%%~pi
)

:: find bash location from msys2 path
set BASH_PATH=%MSYS_DRIVE%%MSYS_FOLDER%usr\bin\bash.exe

:: define unix commands
:: unix command to install packages
set "CMD_PACMAN=pacman -Syu --noconfirm autoconf libtool automake make autoconf-archive pkg-config gettext-devel"
:: unix command to add mingw to path
:: TODO get mingw64 path automatically
set "CMD_EXPORT=export PATH=$PATH:/c/ProgramData/chocolatey/lib/mingw/tools/install/mingw64/bin"
:: unix command to set current directory to zbar path
set "ZBAR_PATH=%ZBAR_PATH:\=/%"
set "CMD_CD=cd %ZBAR_PATH%"
:: unix command to setup zbar config
set "CMD_RECONF=autoreconf -vfi"
:: unix command to run zbar config
set "CMD_CONFIG=./configure --host=x86_64-w64-mingw32 --prefix=`pwd`/../zbarcam --without-gtk --without-python --without-qt --without-java --without-imagemagick --enable-pthread --with-directshow --disable-dependency-tracking"
:: unix command to make and install zbar
set "CMD_MAKE=make install"

:: join unix commands to run in the same msys shell
set "COMMAND=%CMD_PACMAN% && %CMD_EXPORT% && %CMD_CD% && %CMD_RECONF% && %CMD_CONFIG% && %CMD_MAKE%"

:: run msys unix commands to build zbar
%BASH_PATH% -l -c "%COMMAND%"

xcopy /e /v /Y %scriptpath:~0,-1%\..\qr\zbarcam\bin %scriptpath:~0,-1%\..\qr\zbarcam

:: remove uneeded library folders from zbarcam folder
rmdir /s /q %scriptpath:~0,-1%\..\qr\zbarcam\bin
rmdir /s /q %scriptpath:~0,-1%\..\qr\zbarcam\include
rmdir /s /q %scriptpath:~0,-1%\..\qr\zbarcam\lib
rmdir /s /q %scriptpath:~0,-1%\..\qr\zbarcam\share

:: reset working directory
cd %initcwd%

echo done.

EXIT /B 0