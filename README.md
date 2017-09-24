# Processing-Robot-Arm-Controller
Keyboard and GUI Controller for sending Gcode to a robotic arm

## How to use?
1. Make sure you have installed the Processing IDE on your computer.
    1. If not, you can get it from [here](https://processing.org/download/).
1. Open Processing IDE.
1. Check if you have the G4P library installed on Processing.
    1. If not, go to `Sketch->Import Library...->Add Library...`
    1. Inside the `Libraries` tab, search for `G4P`.
    1. Select `G4P`.
    1. Click `Install`.
1. Download this repository.
1. Open the `armInterfaceGUI.pde` file on the Processing IDE.
1. Click on `Run`.
1. Done!

There is a `test.gcode` file included to test the interface for loading/executing .gcode files.

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
