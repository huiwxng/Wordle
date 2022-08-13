int BLANK = 0;
int CORRECT = 1;
int MISPLACED = 2;
int INCORRECT = 3;

boolean RUNNING;

Box[][] boxes;
Keyboard keyboard;

Table targetWords;
Table words;

String keys = "QWERTYUIOPASDFGHJKLZXCVBNM";
char[][] input = {{' ', ' ', ' ', ' ', ' '},
                  {' ', ' ', ' ', ' ', ' '},
                  {' ', ' ', ' ', ' ', ' '},
                  {' ', ' ', ' ', ' ', ' '},
                  {' ', ' ', ' ', ' ', ' '},
                  {' ', ' ', ' ', ' ', ' '},
                };

String word = "";
String target;
int count = 0;
int guess = 0;
boolean wordle = false;

void setup() {
  size(460, 800);
  background(209);
  textAlign(LEFT, TOP);
  
  RUNNING = true;
  
  targetWords = loadTable("words_reasonable.csv");
  words = loadTable("words.csv");
  
  setupBoxes();
  showBoxes();
  
  target = targetWords.getString(0, int(random(0, targetWords.getColumnCount())));
  println(target.toUpperCase());
  
  keyboard = new Keyboard(55, 630, BLANK);
}

void draw() {
  showBoxes();
  keyboard.displayKeys();
}

void setupBoxes() {
  boxes = new Box[6][5];
  int boxSize = width / 5 - 12;
  int state;
  for (int r = 0; r < boxes.length; r++) {
    for (int c = 0; c < boxes[r].length; c++) {
      int x = 10 + 10 * c;
      int y = 10 + 10 * r;
      state = BLANK;
      boxes[r][c] = new Box(x + c * boxSize, y + r * boxSize, boxSize, state);
    }
  }
}

void showBoxes() {
  for (int r = 0; r < boxes.length; r++) {
    for (int c = 0; c < boxes[r].length; c++) {
      boxes[r][c].display(' ');
      for (int i = 0; i <= guess; i++) {
        boxes[i][c].display(input[i][c]);
      }
    }
  }
}

void checkWordle() {
  if (word.equals(target)) {
    for (int i = 0; i < word.length(); i++) {
      boxes[guess][i].changeState(CORRECT);
    }
    println("Wordle in " + (guess + 1) + "!");
    println("press ENTER to start new game");
    RUNNING = false;
  }
}

void checkLetters() {
  for (int i = 0; i < word.length(); i++) {
    for (int n = 0; n < target.length(); n++) {
      if (word.charAt(i) == target.charAt(i)) {
        boxes[guess][i].changeState(CORRECT);
      }
      else if ((word.charAt(n) == target.charAt(i)) && (boxes[guess][n].state != CORRECT)) {
        boxes[guess][n].changeState(MISPLACED);
      }
      else if ((boxes[guess][i].state != CORRECT) && (boxes[guess][i].state != MISPLACED)) {
        boxes[guess][i].changeState(INCORRECT);
      }
    }
  }
}

int getKeyIndex(char c) {
  String character = "" + c;
  return keys.indexOf(character.toUpperCase());
}

void checkKey() {
  for (int i = 0; i < word.length(); i++) {
    for (int n = 0; n < target.length(); n++) {
      int index = getKeyIndex(word.charAt(i));
      int indexn = getKeyIndex(word.charAt(n));
      if (word.charAt(i) == target.charAt(i)) {
        keyboard.updateState(CORRECT, index);
      }
      else if ((word.charAt(n) == target.charAt(i)) && (keyboard.keyArray[indexn].state != CORRECT)) {
        keyboard.updateState(MISPLACED, indexn);
      }
      else if ((keyboard.keyArray[index].state != CORRECT) && (keyboard.keyArray[index].state != MISPLACED)) {
        keyboard.updateState(INCORRECT, index);
      }
    }
  }
}

boolean isWord(String string) {
  for (int i = 0; i < words.getColumnCount(); i++) {
    if (string.equals(words.getString(0, i))) {
      return true;
    }
  }
  return false;
}

void keyPressed() {
  if (RUNNING == true) {
    if ((key == '\n') && (count == 5) && (isWord(word) == true)) {
      checkLetters();
      checkWordle();
      checkKey();
      if (guess < 5) {
        count = 0;
        guess++;
        word = "";
      }
      else {
        println("You lost!");
        println("press ENTER to start new game");
        RUNNING = false;
        text(target.toUpperCase(), 180, 550);
      }
    }
    else if ((key == '\n') && (count < 5)) {
      println("not 5 letters");
    }
    if ((key == '\n') && (count == 5) && (isWord(word) == false)) {
      println("not a word");
    }
    if ((key == BACKSPACE) && (count > 0)) {
      count--;
      word = word.substring(0, word.length() - 1);
      input[guess][count] = ' ';
    }
    if ((key == ' ') || ((key == BACKSPACE) && (count == 0))) {
    }
    else {
      if ((count < 5) && (Character.isLetter(key) == true) && (wordle == false)) {
        input[guess][count] = key;
        word += key;
        count ++;
      }
    }
  }
  else {
    if (key == '\n') {
      background(209);
      count = 0;
      word = "";
      guess = 0;
      for (int r = 0; r < input.length; r++) {
        for (int c = 0; c < input[c].length; c++) {
          input[r][c] = ' ';
        }
      }
      target = targetWords.getString(0, int(random(0, targetWords.getColumnCount())));
      println(target.toUpperCase());
      keyboard = new Keyboard(55, 630, BLANK);
      setupBoxes();
      showBoxes();
      RUNNING = true;
    }
  }
}
