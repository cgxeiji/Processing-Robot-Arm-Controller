boolean isDone = false;

void sender_start() {
  String[] codes = loadStrings(gcodeFile);
  
  for (String line : codes) {
    send(line);
    isDone = false;
    while(!isDone) delay(100);
  }
}

void send(String line) {
  arm.write(line + '\n');
  debugger = line;
  tb.add(debugger);
  setStatus(ARM_SENT);
}