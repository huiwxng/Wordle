class Keyboard {
  int x;
  int y;
  int size;
  int state;
  String keys = "QWERTYUIOPASDFGHJKLZXCVBNM";
  Box[] keyArray;
  
  Keyboard(int x0, int y0, int state0) {
    x = x0;
    y = y0;
    size = 35;
    state = state0;
    keyArray = new Box[26];
    
    for (int i = 0; i < keys.length(); i++) {
      keyArray[i] = new Box(x, y, size, state);
    }
  }
  
  void updateState(int s, int i) {
    keyArray[i].state = s;
  }
  
  void displayKeys() {
    textSize(size);
    
    for (int i = 0; i < keys.length(); i++) {
      if (keyArray[i].state == BLANK) {
        fill(255);
      }
      if (keyArray[i].state == CORRECT) {
        fill(0, 255, 0);
      }
      if (keyArray[i].state == MISPLACED) {
        fill(255, 255, 0);
      }
      if (keyArray[i].state == INCORRECT) {
        fill(150);
      }
      
      int tmpx = x;
      int tmpy = y;
      if (i < 10) {
        tmpx = x;
        tmpy = y;
      }
      if ((i >= 10) && (i < 19)) {
        tmpx = x - 330;
        tmpy = y + 40;
      }
      if (i >= 19) {
        tmpx = x - 610;
        tmpy = y + 80;
      }
      
      square(tmpx + i * size - 3, tmpy, size);
      fill(0);
      text(keys.charAt(i), tmpx + i * size, tmpy - 5);
    }
  }
}
