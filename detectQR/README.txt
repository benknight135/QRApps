Read a QR code from your computer webcam.  
A script is provided to take the QR code and format it from the binary to a runnable exe.  
Double click ‘detectqr.bat’ to launch the detection.  
Hold the QR code up to the camera and wait for the camera to read it. Once read the application should automatically start.  
If you have more than one camera on your PC you may need to adjust which camera should be used. This can be set on the command line with the option –camera-index:
```
detectqr --camera-index 1
```