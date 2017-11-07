

int cols =9;
int rows = 8;
int [][] board;
int boxWidth, boxHeight;
int charX, charY;
int counter;
int state =1;
int speed;
int time = millis();




void setup() {

  size(700, 700);
  initializeValues();
}

void draw () {


  displaySqaures();
  drawBoard();
  fallingBlock();
  addCounter();
  detectCollision();
  displayCounter();
  gameDone();
}

void keyPressed() {
  if (key == 'a') {
    moveCharacterLeft();
  } else if (key == 'd') {
    moveCharacterRight();
  }
}

void initializeValues() {
  board =  new int [cols][rows];
  boxWidth = width/9;
  boxHeight = height/8; 
  counter =0;

  //put charater on the board
  charX = cols/2;
  charY = rows-1;
  board[charX][charY] = 1;
}

void drawBoard() {
  for (int x = 0; x <cols; x++) {
    for (int y = 0; y<rows; y++) {
      if (board[x][y] == 1) {
        fill(0);
      } else if (board[x][y] == 3) {
        fill(255, 0, 0);
      } else if (board[x][y] == 0) {
        fill(255);
      }


      rect(x*boxWidth, y*boxHeight, boxWidth, boxHeight);
    }
  }
}

void moveCharacterLeft() {
  if (charX >= 1) {
    board[charX][charY] = 0;
    charX--;
    board[charX][charY] = 1;
  }
}

void moveCharacterRight() {
  if (charX < cols-1) {
    board[charX][charY] = 0;
    charX++;
    board[charX][charY] = 1;
  }
}

void displaySqaures() {
  //Makes the blocks appear faster after 10 and 20 seconds.
  time = millis();
  if (time < 10000) {
    speed = 18;
  } else if (time > 10000 && time < 20000) {
    speed = 10;
  } else if (time > 20000 ) {
    speed = 6;
  } 
  //creates red sqaure in the top row randomly
  if (frameCount % speed == 0) {
    int x = int(random(cols));
    board[x][0] = 3;
  }
}


void fallingBlock() {
  //Makes the blocks fall faster after 10 and 20 seconds
  time = millis();
  if (time < 10000) {
    speed = 18;
  } else if (time > 10000 && time < 20000) {
    speed = 10;
  } else if (time > 20000) {
    speed = 6;
  }
  //Moves the red sqaure down
  if (frameCount % speed == 0) {
    for (int x = cols-1; x>=0; x--) {
      for (int y= rows -1; y>= 0; y--) {

        if (board[x][y] == 3) {
          board[x][y] =0;
          if (y < rows-1) { // don't go below the grid
            board[x][y+1]=3;
          }
        }
      }
    }
  }
}


void displayCounter() {
  fill(0);
  textSize(32);
  text(counter, 25, 50);
}

void detectCollision() {
  //If a red block lands on your character change the state to 2
  if (board[charX][charY] ==3) {
    state = 2;
  }
}

void gameDone() {
  //Prints Game Over with your score if the state is 2
  if (state == 2) {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("Game Over", width/2, height/2-50);
    text("Your Score Was " +   counter, width/2, height/2+40);
  }
}


void addCounter() {
  //Everytime a red block reaches the bottom row and state is 1, add one to the counter
  if (frameCount % speed == 0 && state == 1) {
    for (int x = cols-1; x>=0; x--) {
      if (board[x][rows-1] == 3) {
        counter ++;
      }
    }
  }
}