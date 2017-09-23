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

void deactivateControls() {
  kAttack.setAlpha(50);
  lAttack.setAlpha(50);
  cbAttack.setAlpha(50);
  
  kBase.setAlpha(50);
  kShoulder.setAlpha(50);
  kElbow.setAlpha(50);
  kWrist.setAlpha(50);
  kHand.setAlpha(50);
  
  lBase.setAlpha(50);
  lShoulder.setAlpha(50);
  lElbow.setAlpha(50);
  lWrist.setAlpha(50);
  lHand.setAlpha(50);
  
  bGrip.setAlpha(50);
  
  b90.setAlpha(50);
  b0.setAlpha(50);
  b90Send.setAlpha(50);
  b0Send.setAlpha(50);
  calibrationMode = false;
  sendingGcode = false;
  
  bHome.setAlpha(50);
  
  slider2dXY.setAlpha(50);
  slider2dXZ.setAlpha(50);
}

void activateControls() {
  kAttack.setAlpha(255);
  lAttack.setAlpha(255);
  cbAttack.setAlpha(255);
  
  kBase.setAlpha(255);
  kShoulder.setAlpha(255);
  kElbow.setAlpha(255);
  kWrist.setAlpha(255);
  kHand.setAlpha(255);
  
  lBase.setAlpha(255);
  lShoulder.setAlpha(255);
  lElbow.setAlpha(255);
  lWrist.setAlpha(255);
  lHand.setAlpha(255);
  
  bGrip.setAlpha(255);
  
  b90.setAlpha(255);
  b0.setAlpha(255);
  
  bHome.setAlpha(255);
  
  slider2dXY.setAlpha(255);
  slider2dXZ.setAlpha(255);
}