/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void slider2dXY_change1(GSlider2D source, GEvent event) { //_CODE_:slider2dXY:587720:
  x = source.getValueXF();
  y = source.getValueYF();
  
  slider2dXZ.setValueX(x);
  
  if (!sendingGcode)
    send("G01 X" + x + " Y" + y + " Z" + z + " W" + attackAngle + " F100");
} //_CODE_:slider2dXY:587720:

public void slider2dXZ_change1(GSlider2D source, GEvent event) { //_CODE_:slider2dXZ:951220:
  x = source.getValueXF();
  z = source.getValueYF();
  
  slider2dXY.setValueX(x);
  
  if (!sendingGcode)
    send("G01 X" + x + " Y" + y + " Z" + z + " W" + attackAngle + " F100");
} //_CODE_:slider2dXZ:951220:

public void dlPorts_click1(GDropList source, GEvent event) { //_CODE_:dlPorts:522580:
  println("dlPorts - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dlPorts:522580:

public void bConnect_click1(GButton source, GEvent event) { //_CODE_:bConnect:427343:
if (!isConnected) {
    serialConnect();
  } else {
    serialDisconnect();
  }
} //_CODE_:bConnect:427343:

public void kAttack_turn1(GKnob source, GEvent event) { //_CODE_:kAttack:927495:
  attackAngle = kAttack.getValueF();
  lAttack.setText("Attack Angle: " + nfs(attackAngle, 2, 1));
  send("G01 X" + x + " Y" + y + " Z" + z + " W" + attackAngle + " F100");
} //_CODE_:kAttack:927495:

public void cbAttack_clicked1(GCheckbox source, GEvent event) { //_CODE_:cbAttack:710322:
  if (cbAttack.isSelected()) {
    cbAttack.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    kAttack.setLocalColorScheme(GCScheme.RED_SCHEME);
    lAttack.setLocalColorScheme(GCScheme.RED_SCHEME);
    kAttack.setEnabled(false);
    lAttack.setEnabled(false);
    attackAngle = 999.9;
    send("G01 X" + x + " Y" + y + " Z" + z + " W" + attackAngle + " F100");
  } else {
    cbAttack.setLocalColorScheme(GCScheme.RED_SCHEME);
    kAttack.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    lAttack.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    kAttack.setEnabled(true);
    lAttack.setEnabled(true);
    attackAngle = kAttack.getValueF();
    send("G01 X" + x + " Y" + y + " Z" + z + " W" + attackAngle + " F100");
  }
} //_CODE_:cbAttack:710322:

public void kBase_turn1(GKnob source, GEvent event) { //_CODE_:kBase:713256:
  lBase.setText("Base " + nf(kBase.getValueF(), 3, 2));
} //_CODE_:kBase:713256:

public void b90_click1(GButton source, GEvent event) { //_CODE_:b90:200019:
  angles[0] = 90;
  angles[1] = 90;
  angles[2] = 90;
  angles[3] = 90;
  angles[4] = 90;
  send("M105");
  calibrationMode = true;
  b0Send.setAlpha(50);
  b90Send.setAlpha(255);
} //_CODE_:b90:200019:

public void kWrist_turn1(GKnob source, GEvent event) { //_CODE_:kWrist:376624:
  lWrist.setText("Wrist " + nf(kWrist.getValueF(), 3, 2));
} //_CODE_:kWrist:376624:

public void kElbow_turn1(GKnob source, GEvent event) { //_CODE_:kElbow:971784:
  lElbow.setText("Elbow " + nf(kElbow.getValueF(), 3, 2));
} //_CODE_:kElbow:971784:

public void kShoulder_turn1(GKnob source, GEvent event) { //_CODE_:kShoulder:598142:
  lShoulder.setText("Shoulder " + nf(kShoulder.getValueF(), 3, 2));
} //_CODE_:kShoulder:598142:

public void kHand_turn1(GKnob source, GEvent event) { //_CODE_:kHand:608494:
  lHand.setText("Hand " + nf(kHand.getValueF(), 3, 2));
  angles[4] = kHand.getValueF();
  send("G53 E" + angles[4]);
} //_CODE_:kHand:608494:

public void bGrip_click1(GButton source, GEvent event) { //_CODE_:bGrip:769454:
  if (bGrip.getText() == "OPEN") {
    send("M101");
    bGrip.setText("CLOSE");
    bGrip.setLocalColorScheme(GCScheme.RED_SCHEME);
  } else {
    send("M100");
    bGrip.setText("OPEN");
    bGrip.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  }
} //_CODE_:bGrip:769454:

public void tConsole_change1(GTextArea source, GEvent event) { //_CODE_:tConsole:639074:
  String[] log = tConsole.getTextAsArray();
  tConsole.moveCaretTo(log.length - 1, 0);
} //_CODE_:tConsole:639074:

public void bLoad_click1(GButton source, GEvent event) { //_CODE_:bLoad:604636:
  setStatus(THIS_FILE_REQUESTED);
  selectInput("Select gcode file:", "parseFile");
} //_CODE_:bLoad:604636:

public void bSend_click1(GButton source, GEvent event) { //_CODE_:bSend:720434:
  setStatus(THIS_SENDER_START_REQUESTED);
  if (fileStatus == THIS_FILE_LOADED) {
    setStatus(ARM_STAND_BY);
    thread("sender_start");
  } else {
    setStatus(ERROR_NO_FILE_LOADED);
    setStatus(ARM_STAND_BY);
  }
} //_CODE_:bSend:720434:

public void b0_click1(GButton source, GEvent event) { //_CODE_:b0:427289:
  angles[0] = 180;
  angles[1] = 45;
  angles[2] = 180;
  angles[3] = 0;
  angles[4] = 0;
  send("M107");
  calibrationMode = true;
  b90Send.setAlpha(50);
  b0Send.setAlpha(255);
} //_CODE_:b0:427289:

public void b0Send_click1(GButton source, GEvent event) { //_CODE_:b0Send:359807:
  send("M108 A" + angles[0] + " B" + angles[1] + " C" + angles[2] + " D" + angles[3] + " E" + angles[4]);
  angles[0] = 180;
  angles[1] = 45;
  angles[2] = 180;
  angles[3] = 0;
  angles[4] = 0;
  calibrationMode = false;
  b0Send.setAlpha(50);
} //_CODE_:b0Send:359807:

public void b90Send_click1(GButton source, GEvent event) { //_CODE_:b90Send:430743:
  send("M106 A" + angles[0] + " B" + angles[1] + " C" + angles[2] + " D" + angles[3] + " E" + angles[4]);
  angles[0] = 90;
  angles[1] = 90;
  angles[2] = 90;
  angles[3] = 90;
  angles[4] = 90;
  calibrationMode = false;
  b90Send.setAlpha(50);
} //_CODE_:b90Send:430743:

public void bHome_click1(GButton source, GEvent event) { //_CODE_:bHome:330187:
  send("G28");
  home();
  calibrationMode = false;
  b0Send.setAlpha(50);
  b90Send.setAlpha(50);
} //_CODE_:bHome:330187:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.GREEN_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Arm Controller");
  slider2dXY = new GSlider2D(this, 700, 400, 300, 300);
  slider2dXY.setLimitsX(190.0, -400.0, 400.0);
  slider2dXY.setLimitsY(400.0, 400.0, -400.0);
  slider2dXY.setNumberFormat(G4P.DECIMAL, 2);
  slider2dXY.setOpaque(false);
  slider2dXY.addEventHandler(this, "slider2dXY_change1");
  slider2dXZ = new GSlider2D(this, 700, 80, 300, 300);
  slider2dXZ.setLimitsX(1.0, -400.0, 400.0);
  slider2dXZ.setLimitsY(40.0, 400.0, -200.0);
  slider2dXZ.setNumberFormat(G4P.DECIMAL, 2);
  slider2dXZ.setOpaque(false);
  slider2dXZ.addEventHandler(this, "slider2dXZ_change1");
  lCurrentPosition = new GLabel(this, 10, 10, 670, 40);
  lCurrentPosition.setTextAlign(GAlign.LEFT, GAlign.TOP);
  lCurrentPosition.setText("[Current]");
  lCurrentPosition.setTextBold();
  lCurrentPosition.setOpaque(false);
  dlPorts = new GDropList(this, 700, 10, 90, 80, 3);
  dlPorts.setItems(loadStrings("list_522580"), 0);
  dlPorts.addEventHandler(this, "dlPorts_click1");
  bConnect = new GButton(this, 820, 10, 80, 20);
  bConnect.setText("Connect");
  bConnect.setTextBold();
  bConnect.addEventHandler(this, "bConnect_click1");
  lGoalPosition = new GLabel(this, 10, 50, 670, 40);
  lGoalPosition.setTextAlign(GAlign.LEFT, GAlign.TOP);
  lGoalPosition.setText("[Goal]");
  lGoalPosition.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  lGoalPosition.setOpaque(false);
  kAttack = new GKnob(this, 10, 120, 100, 100, 0.8);
  kAttack.setTurnRange(270, 90);
  kAttack.setTurnMode(GKnob.CTRL_ANGULAR);
  kAttack.setShowArcOnly(false);
  kAttack.setOverArcOnly(false);
  kAttack.setIncludeOverBezel(false);
  kAttack.setShowTrack(false);
  kAttack.setLimits(-45.0, 90.0, -90.0);
  kAttack.setNbrTicks(38);
  kAttack.setShowTicks(true);
  kAttack.setOpaque(false);
  kAttack.addEventHandler(this, "kAttack_turn1");
  lAttack = new GLabel(this, 10, 220, 156, 20);
  lAttack.setText("Attack Angle:");
  lAttack.setOpaque(false);
  cbAttack = new GCheckbox(this, 10, 240, 155, 20);
  cbAttack.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  cbAttack.setText("Free Attack Angle?");
  cbAttack.setTextBold();
  cbAttack.setLocalColorScheme(GCScheme.RED_SCHEME);
  cbAttack.setOpaque(false);
  cbAttack.addEventHandler(this, "cbAttack_clicked1");
  kBase = new GKnob(this, 415, 610, 60, 60, 0.8);
  kBase.setTurnRange(180, 0);
  kBase.setTurnMode(GKnob.CTRL_HORIZONTAL);
  kBase.setSensitivity(1);
  kBase.setShowArcOnly(true);
  kBase.setOverArcOnly(false);
  kBase.setIncludeOverBezel(false);
  kBase.setShowTrack(false);
  kBase.setLimits(90.0, 180.0, 0.0);
  kBase.setNbrTicks(20);
  kBase.setShowTicks(true);
  kBase.setLocalColorScheme(GCScheme.RED_SCHEME);
  kBase.setOpaque(false);
  kBase.addEventHandler(this, "kBase_turn1");
  lBase = new GLabel(this, 415, 640, 60, 40);
  lBase.setTextAlign(GAlign.CENTER, GAlign.TOP);
  lBase.setText("Base");
  lBase.setLocalColorScheme(GCScheme.RED_SCHEME);
  lBase.setOpaque(false);
  b90 = new GButton(this, 580, 660, 80, 30);
  b90.setText("Calibrate [_]");
  b90.setTextBold();
  b90.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  b90.addEventHandler(this, "b90_click1");
  kWrist = new GKnob(this, 414, 233, 60, 60, 0.8);
  kWrist.setTurnRange(180, 0);
  kWrist.setTurnMode(GKnob.CTRL_HORIZONTAL);
  kWrist.setSensitivity(1);
  kWrist.setShowArcOnly(true);
  kWrist.setOverArcOnly(false);
  kWrist.setIncludeOverBezel(false);
  kWrist.setShowTrack(false);
  kWrist.setLimits(90.0, 180.0, 0.0);
  kWrist.setNbrTicks(20);
  kWrist.setShowTicks(true);
  kWrist.setLocalColorScheme(GCScheme.RED_SCHEME);
  kWrist.setOpaque(false);
  kWrist.addEventHandler(this, "kWrist_turn1");
  kElbow = new GKnob(this, 415, 343, 60, 60, 0.8);
  kElbow.setTurnRange(180, 0);
  kElbow.setTurnMode(GKnob.CTRL_HORIZONTAL);
  kElbow.setSensitivity(1);
  kElbow.setShowArcOnly(true);
  kElbow.setOverArcOnly(false);
  kElbow.setIncludeOverBezel(false);
  kElbow.setShowTrack(false);
  kElbow.setLimits(90.0, 180.0, 0.0);
  kElbow.setNbrTicks(20);
  kElbow.setShowTicks(true);
  kElbow.setLocalColorScheme(GCScheme.RED_SCHEME);
  kElbow.setOpaque(false);
  kElbow.addEventHandler(this, "kElbow_turn1");
  kShoulder = new GKnob(this, 415, 505, 60, 60, 0.8);
  kShoulder.setTurnRange(195, 345);
  kShoulder.setTurnMode(GKnob.CTRL_HORIZONTAL);
  kShoulder.setSensitivity(1);
  kShoulder.setShowArcOnly(true);
  kShoulder.setOverArcOnly(false);
  kShoulder.setIncludeOverBezel(false);
  kShoulder.setShowTrack(false);
  kShoulder.setLimits(90.0, 165.0, 15.0);
  kShoulder.setNbrTicks(20);
  kShoulder.setShowTicks(true);
  kShoulder.setLocalColorScheme(GCScheme.RED_SCHEME);
  kShoulder.setOpaque(false);
  kShoulder.addEventHandler(this, "kShoulder_turn1");
  kHand = new GKnob(this, 62, 368, 60, 60, 0.8);
  kHand.setTurnRange(180, 0);
  kHand.setTurnMode(GKnob.CTRL_HORIZONTAL);
  kHand.setSensitivity(1);
  kHand.setShowArcOnly(true);
  kHand.setOverArcOnly(false);
  kHand.setIncludeOverBezel(false);
  kHand.setShowTrack(false);
  kHand.setLimits(90.0, 180.0, 0.0);
  kHand.setNbrTicks(20);
  kHand.setShowTicks(true);
  kHand.setOpaque(false);
  kHand.addEventHandler(this, "kHand_turn1");
  bGrip = new GButton(this, 68, 588, 50, 50);
  bGrip.setText("OPEN");
  bGrip.addEventHandler(this, "bGrip_click1");
  lShoulder = new GLabel(this, 415, 535, 60, 40);
  lShoulder.setTextAlign(GAlign.CENTER, GAlign.TOP);
  lShoulder.setText("Shoulder");
  lShoulder.setLocalColorScheme(GCScheme.RED_SCHEME);
  lShoulder.setOpaque(false);
  lElbow = new GLabel(this, 415, 373, 60, 40);
  lElbow.setTextAlign(GAlign.CENTER, GAlign.TOP);
  lElbow.setText("Elbow");
  lElbow.setLocalColorScheme(GCScheme.RED_SCHEME);
  lElbow.setOpaque(false);
  lWrist = new GLabel(this, 415, 263, 60, 40);
  lWrist.setTextAlign(GAlign.CENTER, GAlign.TOP);
  lWrist.setText("Wrist");
  lWrist.setLocalColorScheme(GCScheme.RED_SCHEME);
  lWrist.setOpaque(false);
  lHand = new GLabel(this, 62, 398, 60, 40);
  lHand.setTextAlign(GAlign.CENTER, GAlign.TOP);
  lHand.setText("Hand");
  lHand.setOpaque(false);
  tConsole = new GTextArea(this, 138, 94, 542, 108, G4P.SCROLLBARS_VERTICAL_ONLY | G4P.SCROLLBARS_AUTOHIDE);
  tConsole.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  tConsole.setOpaque(false);
  tConsole.addEventHandler(this, "tConsole_change1");
  label1 = new GLabel(this, 689, 380, 80, 20);
  label1.setText("XY");
  label1.setTextBold();
  label1.setOpaque(false);
  label2 = new GLabel(this, 689, 60, 80, 20);
  label2.setText("XZ");
  label2.setTextBold();
  label2.setOpaque(false);
  bLoad = new GButton(this, 920, 40, 80, 20);
  bLoad.setText("Load file");
  bLoad.setTextBold();
  bLoad.addEventHandler(this, "bLoad_click1");
  lFile = new GLabel(this, 700, 40, 214, 20);
  lFile.setText("File:");
  lFile.setOpaque(true);
  bSend = new GButton(this, 920, 10, 80, 20);
  bSend.setText("Send Gcode");
  bSend.setTextBold();
  bSend.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  bSend.addEventHandler(this, "bSend_click1");
  b0 = new GButton(this, 580, 620, 80, 30);
  b0.setText("Calibrate /\\");
  b0.setTextBold();
  b0.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  b0.addEventHandler(this, "b0_click1");
  b0Send = new GButton(this, 665, 620, 30, 30);
  b0Send.setText("/\\");
  b0Send.setTextBold();
  b0Send.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  b0Send.addEventHandler(this, "b0Send_click1");
  b90Send = new GButton(this, 665, 660, 30, 30);
  b90Send.setText("[_]");
  b90Send.setTextBold();
  b90Send.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  b90Send.addEventHandler(this, "b90Send_click1");
  bHome = new GButton(this, 580, 560, 115, 30);
  bHome.setText("HOME");
  bHome.setTextBold();
  bHome.addEventHandler(this, "bHome_click1");
}

// Variable declarations 
// autogenerated do not edit
GSlider2D slider2dXY; 
GSlider2D slider2dXZ; 
GLabel lCurrentPosition; 
GDropList dlPorts; 
GButton bConnect; 
GLabel lGoalPosition; 
GKnob kAttack; 
GLabel lAttack; 
GCheckbox cbAttack; 
GKnob kBase; 
GLabel lBase; 
GButton b90; 
GKnob kWrist; 
GKnob kElbow; 
GKnob kShoulder; 
GKnob kHand; 
GButton bGrip; 
GLabel lShoulder; 
GLabel lElbow; 
GLabel lWrist; 
GLabel lHand; 
GTextArea tConsole; 
GLabel label1; 
GLabel label2; 
GButton bLoad; 
GLabel lFile; 
GButton bSend; 
GButton b0; 
GButton b0Send; 
GButton b90Send; 
GButton bHome; 