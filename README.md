# QR sml boi
Store a small application or game on a QR code!  
This repostiory has some example programs with scripts for making sure the builds are small. Remember a QR can only be so big!  
Also included in this repository are programs for generating and reading the QR codes. 

## Required
 - Visual Studio 2015 (will work with other compilers but this is the one I used)

## Build (and compress)
### Automatic
Scripts are provided for quick building of the applications in this repository.  
Either run the build-*NAMEOFAPP*.bat file or run build-all.bat to build all the apps.  
These scripts will be crinkle compressor as this gave the best results. 

### Manual


### Compressors
Crinkler gave the best results when building the example apps however in this repository are a number of other compressors that were experimented with.   
#### Crinkler
This compresser is a direct replacement for the linker.  
Here is an example for using this compressor.
```
cd 
cl /c /W4 /O1 /Os /GS- smlgame.c
PATH_TO_REPO/crinkler /nologo /NODEFAULTLIB /ENTRY:main /ALIGN:16 /SUBSYSTEM:windows /OUT:%OUTPUT_EXE% %LIB_FILES%
```

## Examples
