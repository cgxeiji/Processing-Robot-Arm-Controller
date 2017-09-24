import processing.serial.*;

Serial arm;

boolean serialEnable(String port) {
  arm = new Serial(this, port, 115200);
  arm.bufferUntil(10);
  
  return arm != null;
}

boolean serialDisable() {
  if (arm == null) return true;
  
  arm.clear();
  arm.stop();
  arm = null;
  return true;
}

void checkConnection() {
  while(true) {
    if (isConnected) {
      if (arm == null) {
        serialDisconnect();
      }
    }
  }
}

void serialEvent(Serial p) {
  String s =  p.readString();
  isReceiving = true;
  
  if (arm_isCmd(s, "$0")) {
    angles[0] = arm_getValue(s, "A");
    angles[1] = arm_getValue(s, "B");
    angles[2] = arm_getValue(s, "C");
    angles[3] = arm_getValue(s, "D");
    angles[4] = arm_getValue(s, "E");
    
    kBase.setValue(angles[0]);
    kShoulder.setValue(angles[1]);
    kElbow.setValue(angles[2]);
    kWrist.setValue(angles[3]);
    
    return;
  }
  if (arm_isCmd(s, "$1")) {
    _x = arm_getValue(s, "X");
    _y = arm_getValue(s, "Y");
    _z = arm_getValue(s, "Z");

    slider2dXY.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    slider2dXZ.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    return;
  }
  
  if (s.indexOf("ok") == -1) {
    debugger = s;
    if (s.indexOf("Invalid") != -1) {
      slider2dXY.setLocalColorScheme(GCScheme.RED_SCHEME);
      slider2dXZ.setLocalColorScheme(GCScheme.RED_SCHEME);
    }
  } else {
    setStatus(ARM_STAND_BY);
    debugger += "   ...done!\n";
    println(debugger);
    isDone = true;
    lockup();
  }
}

boolean isConnected = false;

void serialConnect() {
  if (!serialEnable(dlPorts.getSelectedText())) return;
  
  bConnect.setText("Disconnect");
  bConnect.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  activateControls();
  
  setStatus(ARM_STAND_BY);
  
  isConnected = true;
}

void serialDisconnect() {
  serialDisable();
  
  bConnect.setText("Connect");
  bConnect.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  
  deactivateControls();
  
  isConnected = false;
}