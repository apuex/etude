# Desktop Settings

## Rotating Desktop

### Rotating screen in Ubuntu and Linux Mint

```
$ xrandr -q
Screen 0: minimum 8 x 8, current 1680 x 1050, maximum 32767 x 32767
DP1 disconnected (normal left inverted right x axis y axis)
DP2 disconnected (normal left inverted right x axis y axis)
HDMI1 disconnected (normal left inverted right x axis y axis)
HDMI2 disconnected (normal left inverted right x axis y axis)
VGA1 connected primary 1680x1050+0+0 (normal left inverted right x axis y axis) 473mm x 296mm
   1680x1050     59.95*+
   1280x1024     75.02    60.02  
   1152x864      75.00  
   1024x768      75.08    60.00  
   800x600       75.00    60.32  
   640x480       75.00    60.00  
   720x400       70.08  
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
$ xrandr --output LVDS1 --rotate right
$ xrandr --output LVDS1 --rotate left
$ xrandr --output LVDS1 --rotate inverted
$ xrandr --output LVDS1 --rotate normal
```

See [Rotating screen in Ubuntu and Linux Mint](https://www.faqforge.com/linux/rotating-screen-in-ubuntu-and-linux-mint/) for reference.
