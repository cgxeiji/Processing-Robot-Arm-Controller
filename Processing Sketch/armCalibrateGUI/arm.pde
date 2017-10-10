
class ArmState {
  int[] mValues;
  int mMin;
  int mMax;
  int mDefault;
  
  final String mCharacters = "ABCDEFG";
  
  boolean mDirty;

  ArmState(int aMin, int aMax, int aDefault) {
    mMin = aMin;
    mMax = aMax;
    mDefault = aDefault;
    mValues = new int[kMaxServos];
    reset();
  }
  
  int getMin() { return mMin; }
  int getMax() { return mMax; }
  
  String gcode() {
    String ret = "";
    for(int i =0; i < mValues.length; i++) {
      ret = ret + " "+ mCharacters.charAt(i) + mValues[i];
    }
    return ret;
  }
  
  void reset() {
    for(int i=0; i < mValues.length; i++) mValues[i] = mDefault;
  }
 
  void clean() {
    mDirty = false;
  }
  boolean isDirty() { return mDirty; } 
   

  int getValue(int servo) {
    return mValues[servo];
  }  
  void setValue(int servo, int value) {
    if( value != mValues[servo]) mDirty = true;
    mValues[servo] = value;
  }
  
}