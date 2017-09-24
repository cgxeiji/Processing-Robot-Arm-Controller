# Processing-Robot-Arm-Controller
Keyboard and GUI Controller for sending Gcode to a robotic arm

## Keyboard Layout
Key | Description
:---: | -----------
|
||***Movement***
|
W | Move 1mm on the +Y
A | Move 1mm on the -X
S | Move 1mm on the +X
D | Move 1mm on the -Y
R | Move 1mm on the +Z
F | Move 1mm on the -Z
|
0~5 | Select servo 0..5
M | Substract 1 degree to the angle of the selected servo -> `G53 A..Fnn.n`
N | Add 1 degree to the angle of the selected servo -> `G53 A..Fnn.n`
|
||***Grip Controll***
|
Q | Open/Close grip
|
||***Calibration Mode***
|
Y | Enable/Disable calibration mode
||*[While calibration mode enabled]*
0~5 | Select servo 0..5
M | Substract 1ms to the pulse width of the selected servo -> `G54 A..Fnn`
N | Add 1ms to the pulse width of the selected servo -> `G54 A..Fnn`
