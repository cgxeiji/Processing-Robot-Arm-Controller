boolean arm_isCmd(String s, String cmd) {
  int index = s.indexOf(cmd);

  return index != -1;
}

float arm_getValue(String s, String cmd) {
  int sIndex = s.indexOf(cmd);
  int eIndex = s.indexOf(' ', sIndex);

  String value;

  if (eIndex == -1) {
    value = s.substring(sIndex+1);
  } else {
    value = s.substring(sIndex+1, eIndex);
  }

  return float(value);
}