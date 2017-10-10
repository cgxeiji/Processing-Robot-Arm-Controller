ScrollableList gPortList;
Toggle gConnectedToggle;
String[] gPorts; // the available serial ports. 

void enumeratePorts() {
  // if the connection is active, preserve the current value.....
  String active = "";
  if(int(gConnectedToggle.getValue()) != 0) {
    active = gPorts[int(gPortList.getValue())];
  }
  gPortList.clear(); 
  gPorts = Serial.list();  
  gPortList.setItems(gPorts);
  
  int v = gPorts.length-1; // initialize value as the last port in the list
  if (active.length() != 0) {
    for(int i = 0; i < gPorts.length; i++) {
      if(active.equals(gPorts[i])) v = i;
    }
  }
  gPortList.setValue(v);
}


void setupConnectionControls() {  
  // refresh Button
  cp5.addButton("rescan")
    .setPosition(10,10)
    .setSize(39,20)
    ;
  // connection button
  gConnectedToggle = cp5.addToggle("connect")
    .setPosition(250,10)
    .setSize(79,20)
    .align(ControlP5.CENTER, CENTER, CENTER, CENTER)
    ;    
  // port list    
  gPorts = Serial.list();
  gPortList = cp5.addScrollableList("dropdown")
    .setPosition(50, 10)
    .setSize(199, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ScrollableList.DROPDOWN)
    ;
  enumeratePorts();
  gPortList.close();  
}

void updateConnectionStatus() {
  if( ! m.isConnected()) {
    fill(64);
    // if the machine got disconnected for whatever reason... 
    //  update the toggle
    if( int(gConnectedToggle.getValue()) != 0) {
      gConnectedToggle.setCaptionLabel("connect");
    }
  } else {
    if( m.isWaiting() ) {
       fill(255,0,0);
    } else {
       fill(0,255,0);
    }
  }
  rect( 330,10,80,20);
}


void rescan() {
   enumeratePorts(); 
}

public void connect(int v) {  
  if ( m.isConnected() ) {
    gConnectedToggle.setCaptionLabel("connect");
    m.disconnect();
  } else {
    gConnectedToggle.setCaptionLabel("disconnect");
    int selected = int(gPortList.getValue()); 
    m.connect( this, gPorts[selected]);
  }
}