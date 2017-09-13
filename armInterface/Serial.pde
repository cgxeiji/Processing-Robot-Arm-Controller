import processing.serial.*;

Serial arm;
String deviceOutput = "";

void initSerial() {
  printArray(Serial.list());
  arm = new Serial(this, Serial.list()[1], 115200);
  arm.bufferUntil(10);
}

void serialEvent(Serial p) {
  String s =  p.readString();
  
  if (arm_isCmd(s, "$0")) {
    angles[0] = arm_getValue(s, "A");
    angles[1] = arm_getValue(s, "B");
    angles[2] = arm_getValue(s, "C");
    angles[3] = arm_getValue(s, "D");
    angles[4] = arm_getValue(s, "E");
    //angles[5] = arm_getValue(s, "F");
    return;
  }
  if (arm_isCmd(s, "$1")) {
    _x = arm_getValue(s, "X");
    _y = arm_getValue(s, "Y");
    _z = arm_getValue(s, "Z");
    return;
  }
  
  if (s.indexOf("DONE") == -1) {
    debugger = s;
    tb.add(debugger);
  } else {
    setStatus(ARM_STAND_BY);
    debugger += " ...done!";
    tb.stitch(" ...done!");
    isDone = true;
  }
}