# Processing-Robot-Arm-Controller
Keyboard and GUI Controller for sending Gcode to a robotic arm

## How to use?
There are two ways you can use this interface:
1. **Sketch Version**: Download the Processing sketch to compile and run using the Processing IDE.
1. **Compiled Version**: Download the executable file (for Windows only). For 32-bit systems, it needs Java 8.0 to be installed.

## Keyboard Layout

### Movement
Key | Description
:---: | -----------
W | Move 1mm on the +Y
A | Move 1mm on the -X
S | Move 1mm on the +X
D | Move 1mm on the -Y
R | Move 1mm on the +Z
F | Move 1mm on the -Z
### Rotation
Key | Description
:---: | -----------
0~5 | Select servo 0..5
M | Substract 1 degree to the angle of the selected servo -> `G53 A..Fnn.n`
N | Add 1 degree to the angle of the selected servo -> `G53 A..Fnn.n`
### Grip Control
Key | Description
:---: | -----------
Q | Open/Close grip
### Calibration Mode
Key | Description
:---: | -----------
Y | Enable/Disable calibration mode
0~5 | Select servo 0..5
M | *[While calibration mode enabled]* Substract 1ms to the pulse width of the selected servo -> `G54 A..Fnn`
N | *[While calibration mode enabled]* Add 1ms to the pulse width of the selected servo -> `G54 A..Fnn`
