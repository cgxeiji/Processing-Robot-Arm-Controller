import processing.serial.*;

class Machine {
  Serial mSerial;
  boolean mWaiting;
  int mBaud = 115200;
  
  boolean mLog = true;
  
  StringList mReplies;
  StringList mExecutedCommands;
  StringList mNewCommands;
  int mRepliesDirty = 0;
  
  int lf = 10; // ASCII linefeed
  int cr = 13; // Carriage Return

  Machine() {
    mReplies = new StringList();
    mExecutedCommands = new StringList();
    mNewCommands = new StringList();
  }

  public int hasNewReplies() {
    return mReplies.size() - mRepliesDirty;
  }  
  
  public StringList getReplies()
  {
    mRepliesDirty = mReplies.size(); 
    return mReplies;
  }

/*
  public String[] enumeratePorts() {
    return Serial.list();    
  }
*/
  
  public void setBaudRate(int b) {
    mBaud = b;
  }
  
  public void forceReset() {
    mWaiting = false;
  }
    
  public boolean isConnected() {
    return mSerial != null;
  }
  
  public boolean isWaiting() {
    return mWaiting;
  }
  
  public void connect(PApplet a, String port) {
    mSerial = new Serial(a, port, mBaud); // "/dev/tty.usbmodem1451", 250000);
    mSerial.bufferUntil(lf);
    mWaiting = false;
  }

  public void disconnect() {
    if( mSerial == null) return;
    mSerial.clear();
    mSerial.stop();
    mSerial = null;
  }
  public boolean scheduleSend(String s) {
        if( mSerial == null) {
      println("not connected.... not sending");
      return false;
    }
    if( ! mWaiting ) {
      return send(s);
    }
    mNewCommands.append(s);
    return true;
  }
  
  public boolean send(String s) {
    if( mSerial == null) {
      println("not connected.... not sending");
      return false;
    }
    if( mWaiting ) {
      println("in waiting mode... not sending");
      return false;
    }
    mSerial.write(s);
    mSerial.write(10); // line feed
    println("send: "+s);
    mWaiting = true;
        
    if(mLog) {
      mExecutedCommands.append(s);
    }
    
    return true;
  }
  
  public void event() {
    if( mSerial == null) return;
    if( 0 == mSerial.available() ) return;
    println("serial available " + mSerial.available());
    // since we use bufferUntil linefeed  we should get a line.
    String ret = trim(mSerial.readString());
    
    if(mLog) {
      mReplies.append(ret);
    }    
    println(ret); 
    if( ret.equals("ok") ) {
       mWaiting = false;
       // if we have scheduled commands do them first
       if( mNewCommands.size() != 0 ) {
         if ( send(mNewCommands.get(0)) ) {
           mNewCommands.remove(0);
         }
       }
    }
  }  
  
} // end of class;