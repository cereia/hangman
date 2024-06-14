# hangman

This is The Odin Project's Hangman project.

The goal is to create a hangman game that pulls a 5-12 letter word from a dictionary of English words (https://github.com/first20hours/google-10000-english/blob/master/google-10000-english-no-swears.txt) to act as the secret word that the player has to guess before they run out of guesses.

- Upon game start:
  - the secret word is chosen and the appropriate number of letters is indicated or,
  - the player is presented with the optiont to open one of their saved games if any exist
- The player can guess wrongly up to 7 times before they lose and the game ends.
- The correct letters will be put into their proper place in the word while any wrong letter guesses are displayed elsewhere.
- At the start of any turn, the player has the option to save the game.