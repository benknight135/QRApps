@echo off
zbarcam -1 -Sbinary --raw /dev/video1 > %temp%\qrapp.exe && %temp%\qrapp.exe
