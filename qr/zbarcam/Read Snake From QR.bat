@echo off
zbarcam -1 -Sbinary --raw /dev/video1 > %temp%\qrsnake.exe && %temp%\qrsnake.exe
