import controlP5.*;

// simplest trick to make int sliders. we dont' use these variables....
int s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17;

class ServoGroup {  
  ArmState mValues;
  boolean mIsDirty = true;  
  boolean mIsActive = true;
  Slider[] mSlider;
    
  String mName;
  
  ServoGroup(String aName, ArmState aValues) {
    mName = aName;
    mValues = aValues;
    mSlider = new Slider[kMaxServos];
  }
  
  ArmState getArm() { return mValues; }
  
  String name() {
    return mName;
  }
  
  // default colors 
  // https://github.com/sojamo/controlp5/blob/1f7cb649865eb8657495b5cfeddd0dbe85d70cac/src/controlP5/ControlP5Constants.java
  
  boolean isActive() { return mIsActive; }
  
  void activate(boolean value) {
    if( value == mIsActive) return;
    mIsActive = value;    
    for(int i=0; i < mSlider.length; i++) {
      if (value) {
        mSlider[i]
          .setColorBackground(color(0xff0074D9))
          .setLock(false);

      } else {
        mSlider[i]
          .setColorBackground(color(0xff002D5A))
          .setLock(true);
  
      }
    }
  }
  
  void initSliders() {
    for(int i=0; i< mSlider.length; i++) {
      mSlider[i].setValue(mValues.getValue(i));
    }
  }

  void linkSlider(int i, Slider s) {
   mSlider[i] = s;
  }
  
  boolean isDirty() {
    return mIsDirty;
  }
}

ServoGroup[] gServoGroup;
Button  gCommit1Button;
Button  gCommit2Button;

void setupControls() {

  int t = 100; // top of the radio buttons
  int w = 200; // width of each column
  int l = 50;
  int p = 10;  // padding
  int h = 20;
  
  cp5.addRadioButton("Radio")
    .setPosition(l+p, t)
    .setSize(w, h)
    .align(ControlP5.CENTER, CENTER)
    .setItemsPerRow(3)
    .addItem("Calibrate pose 1",0)
    .addItem("Calibrate pose 2",1)
    .addItem("Test",2)  
    .setValue(2)

    ;
    
  // make sliders
  gServoGroup = new ServoGroup[3];
  gServoGroup[0] = new ServoGroup("Calib 1 servo", gServoValues[0]);
  gServoGroup[1] = new ServoGroup("Calib 2 servo", gServoValues[1]);
  gServoGroup[2] = new ServoGroup("Test servo",  gServoValues[2]);

  for(int i=0; i<kMaxServos; i++) {
    cp5.addTextlabel("servo "+str(i))
      .setText("servo "+str(i))
      .setPosition(p, t+h*1.5+ h*i)
      .setSize(l,10)
    ;  
    
    for(int c=0; c<3; c++) {
      // all sliders in columns have the same id (just are disabled)
      Slider slider = cp5.addSlider("s" +str(kMaxServos*c+i))
        .setBroadcast(false)
        .setPosition(15+l+c*w+p, t+h*1.5+ h*i)
        .setSize(w-30,10)
        .setRange(gServoValues[c].getMin(),gServoValues[c].getMax())
        .setValue(gServoValues[c].getValue(i))
        .setId(i)
        .setBroadcast(true)
        .setSliderMode(Slider.FLEXIBLE)
       ;
       gServoGroup[c].linkSlider(i,slider);
       slider.getCaptionLabel().setVisible(false);
       slider.getValueLabel().align(ControlP5.RIGHT_OUTSIDE, CENTER).setPaddingX(5);
       slider.setColorForeground(color(255));
    }
  }
  for(int i=0; i< 3; i++) gServoGroup[i].activate(false);
  
  
  // add commit buttons
  
  gCommit1Button = cp5.addButton("Write1")
    .setPosition(l+p+1, t+h*7.5)
    .setSize(w-1, h)
    ;
  gCommit1Button.getCaptionLabel().setText("Write Calibration 1");
  gCommit2Button = cp5.addButton("Write2")
    .setPosition(l+p+w+1, t+h*7.5)
    .setSize(w-1, h)
    ;
  gCommit2Button.getCaptionLabel().setText("Write Calibration 2");

}

void controlSwitchState() 
{
  for(int i=0; i < gServoGroup.length; i++) {
    if( gState == i) {
      gServoGroup[i].activate(true);
    } else {
      gServoGroup[i].activate(false);
    }
  }    
}

void Write1(int v) {
  println("GCODE write calibration values 1 ");
  m.send("M106");
}

void Write2(int v) {
  println("GCODE write calibration values 2 ");
  m.send("M107");

}

void Radio(int a) {
  switchToState(a);
}

void controlEvent(ControlEvent e) {
  // all sliders are in range from 0 until kMaxServos
  if( (e.getId() >= 0) && (e.getId() <= kMaxServos)) {
    if (gState == kStateDisconnected) return; 
    gServoValues[gState].setValue(e.getId(), int(e.getValue()));
  }
}