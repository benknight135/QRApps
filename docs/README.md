# QR Apps
Store a small application or game on a QR code!  
This project aims to embed all the binary data of an exe into a QR code.   
This project was inspired by MattKC's snakeqr [snakeqr](https://itsmattkc.com/etc/snakeqr/)

## Apps
### SmlGame (by Ben Knight)
![Alt text](https://github.com/benknight135/QRApps/blob/master/apps/smlgame/releases/smlgame-v0.0.2/smlgame-v0.0.2-qr.png?raw=true "QR for SmlGame v0.0.2")

### [SnakeQR](https://itsmattkc.com/etc/snakeqr/) (by MattKC)
![Alt text](https://github.com/benknight135/QRApps/blob/master/apps/snakeqr/snakeqr.png?raw=true "QR for SnakeQR by MattKC")

## How to read QR code
Read a QR code from your computer webcam.  
As these use dense QR codes, phone screens will likely not be big enough to display the QR code for the detector to read it. I'd advise printing it off or using a tablet.  
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

## More info
Have a look at the GitHub repository [here](https://github.com/benknight135/QRApps) for information on creating your own QR Apps and tips for creating small exe's  