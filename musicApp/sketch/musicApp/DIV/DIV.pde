// Purpose: Reformatting 2D Music Button Symbols for better organization
// Library - Minim

class Button {
  float x, y, width, height;
  
  Button(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  void display() {
    rect(x, y, width, height);
  }
}

Button quitButton, imageDiv, stopDiv, muteDiv, previousDiv, fastRewindDiv;
Button pauseDiv, playDiv, loopOnceDiv, loopInfiniteDiv, fastForwardDiv;
Button nextDiv, shuffleDiv, songPositionDiv, timeRemainingDiv, songTitleDiv;
Button timeBarDiv, totalTimeDiv;

void setup() {
  fullScreen();
  initializeUI();
}

void draw() {
  displayUI();
}

void initializeUI() {
  int appWidth = displayWidth;
  int appHeight = displayHeight;
  int appShortSide = min(appWidth, appHeight);
  int buttonY = appHeight * 3/5;
  int numberOfButtons = 13;
  int widthOfButton = appWidth / numberOfButtons;

  quitButton = new Button(appWidth - appShortSide * 1/20, 0, appShortSide * 1/20, appShortSide * 1/20);
  imageDiv = new Button(appWidth * 1/4, appHeight * 1/5, appWidth * 1/2, appHeight * 1.5/5);
  songTitleDiv = new Button(appWidth * 1/4, appHeight * 1/20, appWidth * 1/2, appHeight * 1/10);

  stopDiv = new Button(widthOfButton, buttonY, widthOfButton, widthOfButton * 0.5);
  muteDiv = new Button(widthOfButton * 2, buttonY, widthOfButton, widthOfButton * 0.5);
  previousDiv = new Button(widthOfButton * 3, buttonY, widthOfButton, widthOfButton * 0.5);
  fastRewindDiv = new Button(widthOfButton * 4, buttonY, widthOfButton, widthOfButton * 0.5);
  pauseDiv = new Button(widthOfButton * 5, buttonY, widthOfButton, widthOfButton * 0.5);
  playDiv = new Button(widthOfButton * 6, buttonY, widthOfButton, widthOfButton * 0.5);
  loopOnceDiv = new Button(widthOfButton * 7, buttonY, widthOfButton, widthOfButton * 0.5);
  loopInfiniteDiv = new Button(widthOfButton * 8, buttonY, widthOfButton, widthOfButton * 0.5);
  fastForwardDiv = new Button(widthOfButton * 9, buttonY, widthOfButton, widthOfButton * 0.5);
  nextDiv = new Button(widthOfButton * 10, buttonY, widthOfButton, widthOfButton * 0.5);
  shuffleDiv = new Button(widthOfButton * 11, buttonY, widthOfButton, widthOfButton * 0.5);

  timeBarDiv = new Button(widthOfButton, buttonY + widthOfButton * 3/5, appWidth - widthOfButton * 2, appHeight - buttonY - widthOfButton);
  timeRemainingDiv = new Button(widthOfButton * 3, buttonY + widthOfButton * 3/5, appWidth - widthOfButton * 2, appHeight - buttonY - widthOfButton);
  totalTimeDiv = new Button(widthOfButton * 4, buttonY + widthOfButton * 3/5, appWidth - widthOfButton * 2, appHeight - buttonY - widthOfButton);
}

void displayUI() {
  quitButton.display();
  imageDiv.display();
  songTitleDiv.display();

  stopDiv.display();
  muteDiv.display();
  previousDiv.display();
  fastRewindDiv.display();
  pauseDiv.display();
  playDiv.display();
  loopOnceDiv.display();
  loopInfiniteDiv.display();
  fastForwardDiv.display();
  nextDiv.display();
  shuffleDiv.display();
  
  timeBarDiv.display();
  timeRemainingDiv.display();
  totalTimeDiv.display();
}
