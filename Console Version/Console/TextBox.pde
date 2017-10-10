class TextBox {
  StringList sentences;
  int maxSize;
  int posX, posY;
  
  TextBox(int x, int y, int size) {
    sentences = new StringList();
    maxSize = size;
    posX = x;
    posY = y;
  }
  
  void add(String s) {
    if (sentences.size() > maxSize) {
      sentences.remove(0);
    }
    sentences.append(s);  
  }
  
  void stitch(String s) {
    sentences.set(sentences.size() - 1, sentences.get(sentences.size() - 1) + s);
  }
  
  void draw() {
    textSize(20);
    for (int i = 0; i < sentences.size(); i++) {
      text(sentences.get(i), posX, posY + i * 35);
    }
  }
}