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
Key | Description | Gcode
:---: | ----------- | ----
W | Move 1mm on the +Y | `G1 Ynn.n F100`
A | Move 1mm on the -X | `G1 Xnn.n F100`
S | Move 1mm on the +X | `G1 Xnn.n F100`
D | Move 1mm on the -Y | `G1 Ynn.n F100`
R | Move 1mm on the +Z | `G1 Znn.n F100`
F | Move 1mm on the -Z | `G1 Znn.n F100`
### Rotation
Key | Description | Gcode
:---: | ----------- | ----
0~5 | Select servo 0..5 | `A..F`
M | Substract 1 degree to the angle of the selected servo | `G53 [A..F]nn.n`
N | Add 1 degree to the angle of the selected servo | `G53 [A..F]nn.n`
### Grip Control
Key | Description | Gcode
:---: | ----------- | ----
Q | Open/Close grip | `M101` / `M100`
### Calibration Mode
Key | Description | Gcode
:---: | ----------- | ----
Y | Enable/Disable calibration mode | `M103` / `M104`
0~5 | Select servo 0..5 | `A..F`
M | *[While calibration mode enabled]* Substract 1ms to the pulse width of the selected servo | `G54 [A..F]nn`
N | *[While calibration mode enabled]* Add 1ms to the pulse width of the selected servo | `G54 [A..F]nn`
