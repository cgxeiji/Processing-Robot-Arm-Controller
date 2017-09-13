class Keyboard {
  IntDict keymap = new IntDict();
  IntDict pKeymap = new IntDict();
  
  String input = "";
  boolean record = false;
  
  Keyboard() {
    for(int i = 'a'; i < 'z'+1; i++) {
      keymap.set(str(char(i)), 0);
      pKeymap.set(str(char(i)), 0);
    }
    for(int i = '0'; i < '9'+1; i++) {
      keymap.set(str(char(i)), 0);
      pKeymap.set(str(char(i)), 0);
    }
    keymap.set(" ", 0);
    pKeymap.set(" ", 0);
  }
  
  boolean pushedOnce(char k) {
    boolean state = pKeymap.get(str(k)) == 0 && keymap.get(str(k)) == 1;
    update(k);
    return state;
  }
  
  boolean isReleased(char k) {
    boolean state = pKeymap.get(str(k)) == 1 && keymap.get(str(k)) == 0;
    update(k);
    return state;
  }
  
  boolean isPressed(char k) {
    return keymap.get(str(k)) == 1;
  }
  
  void update(char k, boolean b) {
    pKeymap.set(str(k), keymap.get(str(k)));
    keymap.set(str(k), (b == true ? 1 : 0));
  }
  
  void update(char k) {
    pKeymap.set(str(k), keymap.get(str(k)));
  }
}

Keyboard kb = new Keyboard();

void keyPressed() {
  if (!kb.record) {
    if (key >= 'a' && key <= 'z' || key >= '0' && key <= '9' || key == ' ') {
      kb.update(key, true);
    }
  } else {
    if (keyCode == BACKSPACE) {
      if (kb.input.length() > 0) {
        kb.input = kb.input.substring(0, kb.input.length()-1);
      }
    } else if (keyCode == DELETE) {
      kb.input = "";
    } else if (keyCode == ENTER) {
      kb.record = false;
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      kb.input = kb.input + key;
    }
  }
}

void keyReleased() {
  if (!kb.record) {
    if (key >= 'a' && key <= 'z' || key >= '0' && key <= '9' || key == ' ') {
      kb.update(key, false);
    }
  }
}