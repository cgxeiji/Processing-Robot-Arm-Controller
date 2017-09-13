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
  ellipse(centerXY[0] + map(_x, -400, 400, -150, 150), centerXY[1] - map(_y, -400, 400, -150, 150), 10, 10);
  ellipse(centerXZ[0] + map(_x, -400, 400, -150, 150), centerXZ[1] - map(_z, -200, 400, -150, 150), 10, 10);
  
  // Braccio Image
  image(img_arm, 20, 200, 500, 500);
  if (!isConnected) {
    fill(0, 200);
    rect(0, 0, width, height);
  }
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