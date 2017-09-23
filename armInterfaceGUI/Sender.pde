boolean isDone = true, sendingGcode = false, isReceiving = false;

void sender_start() {
  if (isConnected) {
    sendingGcode = true;
    String[] codes = loadStrings(gcodeFile);
    
    for (String line : codes) {
      if (arm_isCmd(line, "G01") || arm_isCmd(line, "G00")) {
        x = arm_getValue(line, "X");
        y = arm_getValue(line, "Y");
        z = arm_getValue(line, "Z");
      }
      if (arm_isCmd(line, "G28")) {
        x = 195;
        y = 0;
        z = 50;
      }
      
      slider2dXY.setValueX(x);
      slider2dXY.setValueY(y);
      slider2dXZ.setValueY(z);
      
      send(line);
      
      while(!isDone) {
        if (!sendingGcode) return;
        delay(100);
      }
    }
    sendingGcode = false;
  }
}

void home() {
  x = 195;
  y = 0;
  z = 50;
  slider2dXY.setValueX(x);
  slider2dXY.setValueY(y);
  slider2dXZ.setValueY(z);
}

void send(String line) {
  if (isConnected) {
    if (isDone) {
      lockdown();
      isDone = false;
      arm.write(line + '\n');
      debugger = line + '\n';
      println(debugger);
      setStatus(ARM_SENT);
      thread("timeoutTimer");
    }
  }
}

void timeoutTimer() {
  int counter = 0;
  while(!isDone) {
    if (isReceiving) {
      counter = 0;
      isReceiving = false;
    }
    delay(100);
    counter += 100;
    if (counter >= 5000) {
      setStatus(ERROR_TIMEOUT);
      isDone = true;
      lockup();
    }
  }
}