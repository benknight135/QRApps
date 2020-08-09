# SmlApp QR
Store a small application or game on a QR code!  
This repostiory has some example programs with scripts for making sure the builds are small. Remember a QR can only be so big!  
Also included in this repository are programs for generating and reading the QR codes.  
This project was inspired by MattKC's snakeqr [snakeqr](https://itsmattkc.com/etc/snakeqr/)

## Apps
### SmlGame (by Ben Knight)
![Alt text](/apps/smlgame/releases/smlgame-v0.0.2/smlgame-v0.0.2-qr.png?raw=true "QR for SmlGame v0.0.2")

### [SnakeQR](https://itsmattkc.com/etc/snakeqr/) (by MattKC)
![Alt text](/apps/snakeqr/snakeqr.png?raw=true "QR for SnakeQR by MattKC")

## Compatibility
All code in this repository will assume you are running Windows 10 x64 and have the following installed:
 - Visual Studio 2015 (will work with other compilers but this is the one I used)

## Build (and compress)
Scripts are provided for quick building of the applications in this repository.  
Either run the 'build-*NAMEOFAPP*.bat' file or run 'build-all.bat' to build all the apps.  
These scripts will use crinkler compressor as this gave the best results.  

## Generate QR
Using an applications exe we can generate a QR code.  
This can be done using the qrencode application provided in this repository.  
To generate a QR code of the smlgame application use 'createqr.bat' in the scripts folder.  
Or do it manually:
```
cd PATH_TO_REPO
qr\console-qrencode\Windows64\waqrencode.exe -i apps\smlgame\smlgame.exe -o apps\smlgame\qr.png
```
*Note: Make sure to replace PATH_TO_REPO with the path to this repository*  
This will output the QR code to a PNG image file. Print this off or save it onto your phone. 

## Read QR
Read a QR code from your computer webcam using the application provided in this repository 'zbarcam'.  
A script is provided to take the QR code and format it from the binary to a runnable exe.
Double click 'Read App From QR.bat' inside the folder 'qr\zbarcam' to run it.  
*Note: If you have more than one camera on your PC you may need to adjust which camera should be used. To do this edit the script and change '/dev/video0' to '/dev/video1' or whichever video source is required.*
Hold the QR code up to the camera and wait for the camera to read it. Once read the application should automatically start. 

![Alt text](/docs/github/smlgame-demo-small.gif?raw=true "Demo QR reading of smlgame app")

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

#### UPX
This compressor is run on an exe or dll and tries to make it smaller. While testing this gave the largest results as it does not allow the use of the custom allignment. This made the code 4x larger before compressing and was only able to compress a small amount.
Here is an example of using this compressor after building. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
link /nologo /NODEFAULTLIB /ENTRY:WinMain /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
PATH_TO_REPO\compressors\upx-3.96-win64\upx smlgame.exe
```

#### Petite
This compressor is run on an exe or dll and tries to make it smaller. 
Here is an example of using this compressor after building. This should be run inside a *VS2015 x86 Native Tools Command Prompt*:
```
cd PATH_TO_REPO\smlgame
cl /c /W4 /O1 /Os /GS- smlgame.c
link /nologo /NODEFAULTLIB /ENTRY:WinMain /ALIGN:16 /SUBSYSTEM:windows /OUT:smlgame.exe smlgame.obj kernel32.lib user32.lib gdi32.lib
PATH_TO_REPO\compressors\petite24\petite smlgame.exe
```