@echo off
SETLOCAL enabledelayedexpansion
Set "FILE_PATH=%~1"
for %%A in ("%FILE_PATH%") do (
	set "Size=%%~zA"
	echo The file "!FILE_PATH!" has a size of !size! bytes
)