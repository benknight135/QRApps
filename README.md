# QR Apps
Store a small application or game on a QR code!  
This project aims to embed all the binary data of an exe into a QR code. The repostiory has some example programs with scripts for making sure the builds are small. Remember a QR can only be so big! Also included are programs for generating and reading the QR codes.  
Inspired by MattKC's snakeqr [snakeqr](https://itsmattkc.com/etc/snakeqr/)

## Apps
### SmlGame (by Ben Knight)
![Alt text](https://github.com/benknight135/QRApps/blob/master/apps/smlgame/releases/smlgame-v0.0.2/smlgame-v0.0.2-qr.png?raw=true "QR for SmlGame v0.0.2")

### [SnakeQR](https://itsmattkc.com/etc/snakeqr/) (by MattKC)
![Alt text](https://github.com/benknight135/QRApps/blob/master/apps/snakeqr/snakeqr.png?raw=true "QR for SnakeQR by MattKC")

## How to read QR code
Read a QR code from your computer webcam.  
Download latest detector application from [here](https://github.com/benknight135/QRApps/releases/latest/download/detectQR.zip).  
Extract detectQR.zip to your PC.  
A script is provided to take the QR code and format it from the binary to a runnable exe.  
Double click ‘detectqr.bat’ to launch the detection.  
Hold the QR code up to the camera and wait for the camera to read it. Once read the application should automatically start.  

![Alt text](https://github.com/benknight135/QRApps/blob/master/docs/github/smlgame-demo-small.gif?raw=true "Demo QR reading of smlgame app")

If you have more than one camera on your PC you may need to adjust which camera should be used. This can be set on the command line with the option –camera-index:
```
detectqr --camera-index 1
``` 

## Compatibility
All code in this repository will assume you are running Windows 10 x64 and have the following installed:
 - Visual Studio 2015 (will work with other compilers but this is the one I used)

## Build examples
Scripts are provided for quick building of the applications in this repository.  
Either run the 'build-*NAMEOFAPP*.bat' file or run 'build-all.bat' to build all the apps.  
These scripts will use crinkler compressor as this gave the best results. 

## Generate QR
Using an applications exe we can generate a QR code.  
This can be done using the qrencode application provided in this repository.  
To generate a QR code of the smlgame application use 'createqr.bat'.  
Will use smlgame application by default but you can use this on your own exe:
```
cd PATH_TO_REPO
createqr --input apps\smlgame\smlgame.exe apps\smlgame\qr.png
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  

Or do it all manually:
```
cd PATH_TO_REPO
qr\console-qrencode\qrencode\Windows64\waqrencode.exe -i apps\smlgame\smlgame.exe -o apps\smlgame\qr.png
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  
This will output the QR code to a PNG image file. Print this off or save it onto your phone.  
If this folder is missing make sure to pull submodules for this repository:
```
git submodule update --init
```

## Building small applications
Using msvc's 'cl' and 'link', an app can be compiled and built. 
Here is an example of building 'smlgame' using msvc. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
link /nologo /NODEFAULTLIB /ENTRY:WinMain /ALIGN:16 /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*

To build this same app compressed, you can directly replace the linker with crinkler. Make sure to build inside an **x86** VS2015 shell otherwise crinkler will fail:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
PATH_TO_REPO\crinkler /nologo /NODEFAULTLIB /ENTRY:WinMain /ALIGN:16 /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*

### MSVC options
To give the app the best chance at being as small as possible options should be set for the linker and the compiler.  
#### Compiler
**/O1**: Creates small code.

**/Os**: Favors small code.

**/GS-**: Remove buffer overrun detection.

#### Linker
**/nologo**: Supress the startup banner.  

**/NODEFAULTLIB**: Ignores all (or the specified) default libraries when external references are resolved. This means you have to link all the libraries yourself however cuts down on file size by only including the libraries actually being used.  

**/ALIGN:16**: The **/ALIGN** option specifies the alignment of each section within the linear address space of the program. Programs normall have a lot of empty space as do not fill the data chunks. This reduces the size of each data chunk.     
*Warning: If using UPX or Petite this option cannot be used*

*Note: If using Crinkler all these same options can be used however /nologo and /algin will be ignored. Crinkler does this automatically.*

### Compressors
#### Comparision
A comparision was done using the smlgame application:

| Compressor | Size (Bytes) |
|------------|--------------|
| Off        | 2240         |
| Crinkler   | 937          |
| UPX        | 3584         |
| MPRESS     | 2560         |
| Petite     | 3396         |

This shows Crinkler gives the best compression. This is mostly due to the other compressors being able to process custom alignment. Crinkler replaces the linker so was expected to before well. Of the compressors that run on the exe, MPRESS performed best due to being able to process custom alignment however ends up with a bigger file than the original.
The comparision can be run within this repository using the 'compare-compressors.bat' script. 
#### Crinkler
This compresser is a direct replacement for the linker.  
Here is an example of using this compressor while building. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
PATH_TO_REPO\compressors\crinkler23\Win64\crinkler /nologo /NODEFAULTLIB /ENTRY:WinMain /ALIGN:16 /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*

#### MPRESS
This compressor is run on an exe or dll and tries to make it smaller. While testing this gave the best results of this type.
Here is an example of using this compressor after building. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
link /nologo /NODEFAULTLIB /ENTRY:WinMain /ALIGN:16 /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
PATH_TO_REPO\compressors\mpress\mpress -s -x smlgame.exe
```
In this example the application is already smaller than mpress can improve on. 
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  

#### UPX
This compressor is run on an exe or dll and tries to make it smaller. While testing this gave the largest results as it does not allow the use of the custom allignment. This made the code 4x larger before compressing and was only able to compress a small amount.
Here is an example of using this compressor after building. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
link /nologo /NODEFAULTLIB /ENTRY:WinMain /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
PATH_TO_REPO\compressors\upx-3.96-win64\upx smlgame.exe
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  

#### Petite
This compressor is run on an exe or dll and tries to make it smaller. 
Here is an example of using this compressor after building. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
link /nologo /NODEFAULTLIB /ENTRY:WinMain /ALIGN:16 /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
PATH_TO_REPO\compressors\petite24\petite smlgame.exe
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  

## Zbarcam
Zbarcam is used for the qrcode detection. Zbar is currently maintained by mchehab [here](https://github.com/mchehab/zbar). This repository is included as a submodule of this repository for easy updating of the zbarcam application.  
### Build
Building of zbarcam for Windows x64 was not straight forward as the instructions on the github weren't quite right. See the README.md in the 'qr' folder of this repository for updated instructions.  
#### Automatic
To make this quick and easy, a build script is provided in the 'scripts' folder. Run 'build-zbarcam.bat' to install all the required packages and build zbarcam. *WARNING: This will overwrite the current zbarcam version in the 'zbarcam' folder*   
This will install chocolatey with msys2, make and mingw. Then build zbar using msys2's bash. 
You will get some errors like:
```
cannot stat './doc/man/zbarcam.1': No such file or director
```
However these can be ignored as this is only for documentation
#### Manual
Install chocolatey in an admin command prompt via powershell:
```
powershell -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
```
Restart the shell to reload environment varaibles.  
Install msys2, make and mingw:
```
choco install -r --no-progress -y msys2 make mingw
```
Start a msys2 bash
```
msys2
```
In the msys2 bash terminal install required packages:
```
pacman -Syu --noconfirm autoconf libtool automake make \
	autoconf-archive pkg-config gettext-devel
```
Add mingw to path (in msys2)
```
export PATH=$PATH:/c/ProgramData/chocolatey/lib/mingw/tools/install/mingw64/bin
```
Configure the zbar build (in msys2)
```
autoreconf -vfi

./configure \
--host=x86_64-w64-mingw32 --prefix=`pwd`/../zbarcam \
--without-gtk --without-python --without-qt --without-java \
--without-imagemagick --enable-pthread \
    --with-directshow --disable-dependency-tracking
```
Build and install zbar (in msys2)
```
make install
```
This will build and install zbarcam to the zbarcam folder of this repository. This generates other files for using it as a library which can be removed.
```
cd PATH_TO_REPO
xcopy /e /v /Y qr\zbarcam\bin qr\zbarcam
rmdir /s /q qr\zbarcam\bin
rmdir /s /q qr\zbarcam\include
rmdir /s /q qr\zbarcam\lib
rmdir /s /q qr\zbarcam\share
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  