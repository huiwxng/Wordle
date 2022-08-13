Name: HUI WANG
Class Period: 10

# Wordle Design Document

### Game Engine Questions
1. How do we select the target word?
   * Select a random word from the one of the word lists
   * Or store a preset word in a variable on the file
2. How do we detect if the letters are in the right place?
   * place the user inputted word into a string
   * loop through the user inputted word to see if the indices match for the target word
   * take the letter and loop through the target word to see if the letter is in the word
3. How do we check if the word is an actual word?
   * check for the word on the word list, return true if it is, return false if not
4. How do we detect if the letter is in the right place if there are double letters?
   * loop through the string to find all instances of a certain letter
   * loop through the letters in the input to see if they match the target word
5. How do we change the on screen keyboard based on incorrect, correct, not in correct place letters?
   * make an object for each letter on the on board keyboard
   * check the state of each object

### Game Interface Questions
1. How do we collect input from the user?
   * use keyPressed()
2. How do we change the color of individual boxes?
   * make the boxes an array and change the color of the object at that array index
3. How do we display the keyboard?
   * make a class for the keyboard and make it an array and display it
4. How do we display the right colors on the keyboard?
   * change the color on the object in the array index
5. How do we display the words in the right boxes at the right time?
   * check where the user is in terms of typing their word
   * store the user input in a string to keep track
   * change the x and y coordinate based on the index

### Game File List
1. Main driver file:
   * Setup the screen size
   * Setup the entire board using the other classes
   * keyPressed() function
2. main wordle box:
   * Draws the main wordle
   * Changes color based on if the letter is guessed correctly, in the wrong spot, or incorrectly
   * Method to display what the user is typing
   * Check if the user is entering an invalid word
4. Keyboard class:
   * Draws the keyboard on the bottom
   * Changes color based on if the letter is guessed correctly, in the wrong spot, or incorrectly
