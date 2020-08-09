@echo off
SETLOCAL enabledelayedexpansion
Set "FILE_PATH=%~1"
Set FILE_SIZE=0
for %%A in ("%FILE_PATH%") do (
	set "FILE_SIZE=%%~zA"
	echo The file "!FILE_PATH!" has a size of !FILE_SIZE! bytes
)

ENDLOCAL&SET %~2=%FILE_SIZE%