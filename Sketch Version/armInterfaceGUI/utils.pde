File gcodeFile;
String status;
String fileStatus;

String ERROR_NOT_GCODE_FILE = "File is not gcode";
String THIS_FILE_LOADED = "File successfully loaded";
String THIS_FILE_REQUESTED = "File has been requested";
String ERROR_NO_FILE_LOADED = "No file has been loaded";

String ERROR_TIMEOUT = "Timeout Error";
String ARM_ACK = "Received acknowledge from arm";
String ARM_STAND_BY = "Arm standing by";
String ARM_SENT = "Command sent to arm";

String THIS_SENDER_START_REQUESTED = "Start of gcode requested";

String THIS_STAND_BY = "Controller standing by";

String debugger = "";

float angles[] = new float[5];
char names[] = new char[5];
float calibration[] = new float[6];

float x, y, z, _x, _y, _z;
boolean open = true;
boolean calibrationMode = false;

float attackAngle;

int joint = 0;

void parseFile(File selected) {
  if (selected == null) {
    setStatus(ERROR_NOT_GCODE_FILE);
    setStatus(ARM_STAND_BY);
  } else {
    if (isGcode(selected)) {
      setStatus(THIS_FILE_LOADED);
      fileStatus = THIS_FILE_LOADED;
      gcodeFile = selected;
      lFile.setText("File: " + gcodeFile.getName());
      bSend.setAlpha(255);
      setStatus(ARM_STAND_BY);
    } else {
      setStatus(ERROR_NOT_GCODE_FILE);
      setStatus(ARM_STAND_BY);
    }
  }
}

void setStatus(String code) {
  status = code;
  println(status);
}

boolean isGcode(File file) {
  if (file.getAbsolutePath().toLowerCase().endsWith(".gcode")) {
    return true;
  }
  return false;
}

void setControls(int alpha) {
  kAttack.setAlpha(alpha);
  lAttack.setAlpha(alpha);
  cbAttack.setAlpha(alpha);
  
  kBase.setAlpha(alpha);
  kShoulder.setAlpha(alpha);
  kElbow.setAlpha(alpha);
  kWrist.setAlpha(alpha);
  kHand.setAlpha(alpha);
  
  lBase.setAlpha(alpha);
  lShoulder.setAlpha(alpha);
  lElbow.setAlpha(alpha);
  lWrist.setAlpha(alpha);
  lHand.setAlpha(alpha);
  
  bGrip.setAlpha(alpha);
  
  b90.setAlpha(alpha);
  b0.setAlpha(alpha);
  
  bHome.setAlpha(alpha);
  
  slider2dXY.setAlpha(alpha);
  slider2dXZ.setAlpha(alpha);
}

void deactivateControls() {
  setControls(50);
  b90Send.setAlpha(50);
  b0Send.setAlpha(50);
  calibrationMode = false;
  sendingGcode = false;
}

void activateControls() {
  setControls(255);
}

void lockdown() {
  setControls(100);
}

void lockup() {
  setControls(255);
}