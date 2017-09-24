// Need G4P library
import g4p_controls.*;

PImage img_arm, img_xy, img_xz;

public void setup(){
  size(1024, 720, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
  fileStatus = ERROR_NO_FILE_LOADED;
  setStatus(THIS_STAND_BY);
  
  x = _x = 190.0;
  y = _y = 0.0;
  z = _z = 40.0;
  
  angles[0] = 90;
  angles[1] = 90;
  angles[2] = 90;
  angles[3] = 90;
  angles[4] = 90;
  
  names[0] = 'A';
  names[1] = 'B';
  names[2] = 'C';
  names[3] = 'D';
  names[4] = 'E';

  calibration[0] = 300;
  calibration[1] = 300;
  calibration[2] = 300;
  calibration[3] = 300;
  calibration[4] = 300;
  calibration[5] = 300;
  
  img_arm = loadImage("braccio_label.png");
  img_xy = loadImage("xy.png");
  img_xz = loadImage("xz.png");
  
  thread("checkConnection");
}

int centerXZ[] = {700+150, 80+150};
int centerXY[] = {700+150, 400+150};

public void draw(){  
  background(0);
  //fill(255, 0, 0, 100);
  //rect(700, 80, 300, 300);
  lGoalPosition.setText("[ Goal ]  X:" + nfs(x,3,1) + " Y:" + nfs(y,3,1) + " Z:" + nfs(z,3,1));
  lCurrentPosition.setText("[Current] X:" + nfs(_x,3,1) + " Y:" + nfs(_y,3,1) + " Z:" + nfs(_z,3,1));
  
  // Coordinates BG Images
  image(img_xz, 700, 80, 300, 300);
  image(img_xy, 700, 400, 300, 300);
  
  // Current Position Crosshair
  fill(255, 0, 0);
  ellipse(centerXY[0] + map(_x, -400, 400, -145, 145), centerXY[1] - map(_y, -400, 400, -145, 145), 10, 10);
  ellipse(centerXZ[0] + map(_x, -400, 400, -145, 145), centerXZ[1] - map(_z, -200, 400, -145, 145), 10, 10);
  
  // Braccio Image
  image(img_arm, 20, 200, 500, 500);
  if (!isConnected) {
    fill(0, 200);
    rect(0, 0, width, height);
  }
  
  // Move on the X Y Z plane with the keyboard
  if (kb.isPressed('w')) {
    y += 1.0;
    slider2dXY.setValueY(y);
    //send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('s')) {
    y -= 1.0;
    slider2dXY.setValueY(y);
    //send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('a')) {
    x -= 1.0;
    slider2dXY.setValueX(x);
    //slider2dXZ.setValueX(x);
    //send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('d')) {
    x += 1.0;
    slider2dXY.setValueX(x);
    //slider2dXZ.setValueX(x);
    //send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('r')) {
    z += 1.0;
    slider2dXZ.setValueY(z);
    //send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }
  if (kb.isPressed('f')) {
    z -= 1.0;
    slider2dXZ.setValueY(z);
    //send("G01 X" + x + " Y" + y + " Z" + z + " F100");
  }

  // Open and close the grip
  if (kb.pushedOnce('q')) {
    open = !open;
    if (open) {
      send("M101");
    } else {
      send("M100");
    }
  }

  // Enable / Disable calibration mode
  if (kb.pushedOnce('y')) {
    calibrationMode = !calibrationMode;
    if (calibrationMode) {
      send("M103");
      println("Calibration Mode Enabled");
    } else {
      send("M104");
      println("Calibration Mode Disabled");
    }
  }

  // Move each motor individually
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
    if (calibrationMode) {
      calibration[joint] -= 1.0;
      send("G54 " + names[joint] + "" + calibration[joint]);
    } else {
      angles[joint] -= 1.0;
      send("G53 " + names[joint] + "" + angles[joint]);
    }
  }
  if (kb.isPressed('n')) {
    if (calibrationMode) {
      calibration[joint] += 1.0;
      send("G54 " + names[joint] + "" + calibration[joint]);
    } else {
      angles[joint] += 1.0;
      send("G53 " + names[joint] + "" + angles[joint]);
    }
  }

  /* TODO: decide if stays or not
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
  */

}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  dlPorts.setItems(Serial.list(), 0);
  
  x = 190;
  y = 0;
  z = 40;
  
  lCurrentPosition.setFont(FontManager.getFont("Consolas", 1, 30));
  lGoalPosition.setFont(FontManager.getFont("Consolas", 0, 30));
  lAttack.setText("Attack Angle: " + nfs(-kAttack.getValueF(), 2, 1));
  
  slider2dXZ.setValueX(x);
  slider2dXZ.setValueY(z);
  slider2dXY.setValueX(x);
  slider2dXY.setValueY(y);
  
  kBase.setValue(90);
  kShoulder.setValue(90);
  kElbow.setValue(90);
  kWrist.setValue(90);
  kHand.setValue(90);
  kAttack.setValue(-45);
  attackAngle = -45;
  
  kBase.setEnabled(false);
  kShoulder.setEnabled(false);
  kElbow.setEnabled(false);
  kWrist.setEnabled(false);
  
  tConsole.setTextEditEnabled(false);
  tConsole.setVisible(false); //
  
  deactivateControls();
  
  bSend.setAlpha(50);
  
  b90Send.setAlpha(50);
  b0Send.setAlpha(50);
}