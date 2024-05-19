# KnedelCube
KnedelCube is an LED cube that displays random animation from the Divoom community.

[![](http://img.youtube.com/vi/IrJWMx3r_K0/0.jpg)](http://www.youtube.com/watch?v=IrJWMx3r_K0 "knedelcube")

## install

### install rpi-rgb-led-matrix
Working with RGB LED matrices requires to install a base driver software. I use  the incredibly versatile rpi-rgb-led-matrix. 
 https://github.com/hzeller/rpi-rgb-led-matrix/

### install KnedelCube
Please edit gif-viewer.py and change your settings
```
$ apt-get install ffmpeg
wget knedel
unzip master.zip
cd knedel-cube
cp /home/cube/install/rpi-rgb-led-matrix-master/bindings/python/samples/gif-viewer.py .
```

### Cronjob
This cronjob can be used to change the animation by interval
```
*/5 * * * * /home/cube/knedelcube/merge-one-gif
@reboot /home/cube/knedelcube/merge-one-gif
```
