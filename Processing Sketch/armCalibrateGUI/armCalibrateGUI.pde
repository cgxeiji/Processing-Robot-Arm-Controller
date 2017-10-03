import controlP5.*;
import processing.serial.*;

Machine m;
ControlP5 cp5;

// this function gets called when a line is received on the serial
// we trigger the machine.
void serialEvent(Serial myPort) {
    m.event(); 
}


final int kMaxUpdateRate = 100; // in milliseconds.
final int kMaxServos = 6;

// states
final int kStateDisconnected = -1;
final int kStateCalibration1 = 0;
final int kStateCalibration2 = 1;
final int kStateTest = 2;

// globals
int gState = kStateDisconnected;
ArmState[] gServoValues;

long gTime = millis();


void setup() {
  size(700,400);
  
  gServoValues = new ArmState[3];
  gServoValues[0] = new ArmState(100,500,300);
  gServoValues[1] = new ArmState(100,500,300);
  gServoValues[2] = new ArmState(0,180,90);
  
  cp5 = new ControlP5(this);
  setupControls();
  
  setupConnectionControls();
  
  m = new Machine();

}

void draw() {
  background(0);
  updateConnectionStatus();

  // if (machine is waiting mode ) return;
  if (gState == kStateDisconnected) return;
  if (millis() - gTime < kMaxUpdateRate) return;
  
  if (! gServoValues[gState].isDirty()) return;
  gServoValues[gState].clean();  
  if( gState == 0) {
    println("GCODE 1 " + gServoValues[0].gcode() );
    m.send("G54 "+ gServoValues[0].gcode()); 
  } else if( gState == 1) {
    println("GCODE 2 " + gServoValues[1].gcode() );
    m.send("G54 "+ gServoValues[1].gcode()); 
  } else if( gState == 2) {
    println("G53 "+ gServoValues[2].gcode() );
    m.send("G53 "+ gServoValues[2].gcode());
  }
  gTime = millis();
}

void switchToState(int state) {
  if(state == gState) return;

  println("switch to state " + state);

  if(state == 0) {
    m.send("M103");
    m.scheduleSend("M105");
  } else if(state == 1) {    
    m.send("M103");
    m.scheduleSend("M107");

  } else if(state == 2) {
    m.send("M104");
  }
  gState = state;
  controlSwitchState();
}