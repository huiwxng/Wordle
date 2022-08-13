class Box {
  int x;
  int y;
  int size;
  int state;
  
  Box(int x0, int y0, int size0, int state0) {
    x = x0;
    y = y0;
    size = size0;
    state = state0;
  }
  
  void changeState(int s) {
    state = s;
  }
  
  void display(char c) {
    c = Character.toUpperCase(c);
    if (state == BLANK) {
      fill(255);
    }
    if (state == CORRECT) {
      fill(0, 255, 0);
    }
    if (state == MISPLACED) {
      fill(255, 255, 0);
    }
    if (state == INCORRECT) {
      fill(150);
    }
    square(x, y, size);
    fill(0);
    textSize(size);
    text(c, x + size / 8, y - size / 8);
  }
}
