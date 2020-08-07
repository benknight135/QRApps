# SML
Hello. This is sml. v sml.

# Required
 - Visual Studio 2015 (will work with other compilers but this is the one I used)

# Build
Use msvc command prompt to make sure environment is setup correctly:
```
cl /c /O1 /GS- sml.c
link /nologo /ENTRY:main /NODEFAULTLIB /SUBSYSTEM:CONSOLE sml.obj ucrt.lib
```

# Build compressed
## Get crinkler
Download crinkler from [here](https://github.com/runestubbe/Crinkler/releases/tag/v2.3)  
A copy is provided in this repository (v2.3) for ease.

## Replace linker
Copy the Crinkler.exe into the build location (in this case PATH_TO_REPO/app).  

## Build with Crinkler
Crinkler is now used as the default linker, you can run the same code as before.  
Use msvc command prompt to make sure environment is setup correctly:
```
cl /c /O1 /GS- sml.c
crinkler /ENTRY:main /NODEFAULTLIB /SUBSYSTEM:CONSOLE /OUT:sml.exe sml.obj ucrt.lib
```

# Examples
See [here](https://github.com/Beluki/4k-Example.git) for another example