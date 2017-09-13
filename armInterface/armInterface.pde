File gcodeFile;
int status;
int fileStatus;

int ERROR_NOT_GCODE_FILE = 91;
int THIS_FILE_LOADED = 92;
int THIS_FILE_REQUESTED = 93;
int ERROR_NO_FILE_LOADED = 94;

int ERROR_TIMEOUT = 81;
int ARM_ACK = 82;
int ARM_STAND_BY = 83;
int ARM_SENT = 84;

int THIS_SENDER_START_REQUESTED = 71;

int THIS_STAND_BY = 11;

String debugger = "";

float angles[] = new float[6];
char names[] = new char[6];
float calibration[] = new float[6];

TextBox tb = new TextBox(20, 150, 10);

void setup() {
  size(800, 800);
  
  fileStatus = ERROR_NO_FILE_LOADED;
  setStatus(THIS_STAND_BY);
  
  
  initSerial();
  
  x = _x = 190.0;
  y = _y = 0.0;
  z = _z = 40.0;
  
  angles[0] = 90;
  angles[1] = 90;
  angles[2] = 90;
  angles[3] = 90;
  angles[4] = 90;
  angles[5] = 10;
  
  names[0] = 'A';
  names[1] = 'B';
  names[2] = 'C';
  names[3] = 'D';
  names[4] = 'E';
  names[5] = 'F';
  
  calibration[0] = 300;
  calibration[1] = 300;
  calibration[2] = 300;
  calibration[3] = 300;
  calibration[4] = 300;
  calibration[5] = 300;
}

float x, y, z, _x, _y, _z;
boolean open = true, calibMode = false;

void draw() {
  background(0);
  //text(status, 20, 20);
  //text(debugger, 20, 50);
  tb.draw();
  textSize(40);
  text("X" + _x + " Y" + _y + " Z" + _z, 20, 40);
  text("A" + angles[0] + " B" + angles[1] + " C" + angles[2] + " D" + angles[3] + " E" + angles[4] + " F" + angles[5], 20, 85);
  
  if (kb.pushedOnce('l')) {
    setStatus(THIS_FILE_REQUESTED);
    selectInput("Select gcode file:", "parseFile");
  }
  
  if (kb.pushedOnce('p')) {
    setStatus(THIS_SENDER_START_REQUESTED);
    if (fileStatus == THIS_FILE_LOADED) {
      thread("sender_start");
    } else {
      setStatus(ERROR_NO_FILE_LOADED);
    }
  }
  
  if (kb.isPressed('w')) {
    y += 1.0;
    send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('s')) {
    y -= 1.0;
    send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('a')) {
    x -= 1.0;
    send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('d')) {
    x += 1.0;
    send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('r')) {
    z += 1.0;
    send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('f')) {
    z -= 1.0;
    send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('z')) {
    send("G01 X" + x + " Y" + y + " Z" + z + " W999.9 F100");
  }
  if (kb.isPressed('x')) {
    send("G01 X" + x + " Y" + y + " Z" + z + " W0 F100");
  }
  if (kb.isPressed('c')) {
    send("G01 X" + x + " Y" + y + " Z" + z + " W-45 F100");
  }
  if (kb.isPressed('v')) {
    send("G01 X" + x + " Y" + y + " Z" + z + " W-90 F100");
  }
  
  
  if (kb.pushedOnce('q')) {
    open = !open;
    if (open) {
      send("M101");
    } else {
      send("M100");
    }
  }
  
  if (kb.pushedOnce('y')) {
    calibMode = !calibMode;
    if (calibMode) {
      send("M103");
      println("Calibration Mode Enabled");
    } else {
      send("M104");
      println("Calibration Mode Disabled");
    }
  }
  
  if (kb.pushedOnce('u')) {
    angles[0] = 90;
    angles[1] = 90;
    angles[2] = 90;
    angles[3] = 90;
    angles[4] = 90;
    angles[5] = 10;
    send("M105");
    calibration[0] = 300;
    calibration[1] = 300;
    calibration[2] = 300;
    calibration[3] = 300;
    calibration[4] = 300;
    calibration[5] = 300;
  }
  if (kb.pushedOnce('i')) {
    angles[0] = 180;
    angles[1] = 45;
    angles[2] = 180;
    angles[3] = 0;
    angles[4] = 0;
    angles[5] = 73;
    send("M107");
    calibration[0] = 300;
    calibration[1] = 300;
    calibration[2] = 300;
    calibration[3] = 300;
    calibration[4] = 300;
    calibration[5] = 300;
  }
  if (kb.pushedOnce('j')) {
    send("M106 A" + calibration[0] + " B" + calibration[1] + " C" + calibration[2] + " D" + calibration[3] + " E" + calibration[4] + " F" + calibration[5]);
    angles[0] = 90;
    angles[1] = 90;
    angles[2] = 90;
    angles[3] = 90;
    angles[4] = 90;
    angles[5] = 10;
  }
  if (kb.pushedOnce('k')) {
    send("M108 A" + calibration[0] + " B" + calibration[1] + " C" + calibration[2] + " D" + calibration[3] + " E" + calibration[4] + " F" + calibration[5]);
    angles[0] = 180;
    angles[1] = 45;
    angles[2] = 180;
    angles[3] = 0;
    angles[4] = 0;
    angles[5] = 73;
  }
  
  
  if (kb.pushedOnce('0')) {
    joint = 0;
  }
  if (kb.pushedOnce('1')) {
    joint = 1;
  }
  if (kb.pushedOnce('2')) {
    joint = 2;
  }
  if (kb.pushedOnce('3')) {
    joint = 3;
  }
  if (kb.pushedOnce('4')) {
    joint = 4;
  }
  if (kb.pushedOnce('5')) {
    joint = 5;
  }
  if (kb.isPressed('m')) {
    if (calibMode) {
      calibration[joint] -= 1.0;
      send("G54 " + names[joint] + "" + calibration[joint]);
    } else {
      angles[joint] -= 1.0;
      send("G53 " + names[joint] + "" + angles[joint]);
    }
  }
  if (kb.isPressed('n')) {
    if (calibMode) {
      calibration[joint] += 1.0;
      send("G54 " + names[joint] + "" + calibration[joint]);
    } else {
      angles[joint] += 1.0;
      send("G53 " + names[joint] + "" + angles[joint]);
    }
  }
  
}

int joint = 0;

void parseFile(File selected) {
  if (selected == null) {
    setStatus(ERROR_NOT_GCODE_FILE);
  } else {
    if (isGcode(selected)) {
      setStatus(THIS_FILE_LOADED);
      fileStatus = THIS_FILE_LOADED;
      gcodeFile = selected;
    } else {
      setStatus(ERROR_NOT_GCODE_FILE);
    }
  }
}

void setStatus(int code) {
  status = code;
}

boolean isGcode(File file) {
  if (file.getAbsolutePath().toLowerCase().endsWith(".gcode")) {
    return true;
  }
  return false;
}