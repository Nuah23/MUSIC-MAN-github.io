import ddf.minim.*;

Minim minim;
AudioPlayer player;
PImage album;

boolean isPlaying = false;  // To track play/pause state

void setup() {
  fullScreen();
  minim = new Minim(this);

  // Load audio and image from the data/ folder
  player = minim.loadFile("Playboy_Carti_Sky_Instrumental.mp3");
  album = loadImage("Nanjing.jpg");

  // Prevent null issues
  if (album != null) {
    album.resize(300, 300);
  }

  textAlign(CENTER, CENTER);
  textFont(createFont("Arial Black", 48));
  fill(0, 0, 139); // Blue text
}

void draw() {
  background(255);
  float centerX = width / 2;

  // Title
  fill(200);
  rect(centerX - 250, 50, 500, 80);
  fill(0, 0, 139);
  text("YEET music", centerX, 90);

  // Album image
  if (album != null) {
    image(album, centerX - 150, 150);
  }

  // Controls
  float btnY = 500;
  float btnSize = 80;
  float buttonX = centerX - 220;

  // Fast Backward
  fill(180);
  rect(buttonX, btnY, btnSize, btnSize);
  fill(0);
  triangle(buttonX + 35, btnY + 20, buttonX + 35, btnY + 60, buttonX + 5, btnY + 40);
  triangle(buttonX + 55, btnY + 20, buttonX + 55, btnY + 60, buttonX + 25, btnY + 40);

  // Play/Pause
  buttonX += btnSize;
  fill(180);
  rect(buttonX, btnY, btnSize, btnSize);
  fill(0);
  if (isPlaying) {
    rect(buttonX + 20, btnY + 20, 15, 40);
    rect(buttonX + 50, btnY + 20, 15, 40);
  } else {
    triangle(buttonX + 25, btnY + 20, buttonX + 25, btnY + 60, buttonX + 55, btnY + 40);
  }

  // Stop
  buttonX += btnSize;
  fill(180);
  rect(buttonX, btnY, btnSize, btnSize);
  fill(0);
  rect(buttonX + 15, btnY + 20, 40, 40);

  // Fast Forward
  buttonX += btnSize;
  fill(180);
  rect(buttonX, btnY, btnSize, btnSize);
  fill(0);
  triangle(buttonX + 25, btnY + 20, buttonX + 25, btnY + 60, buttonX + 55, btnY + 40);
  triangle(buttonX + 45, btnY + 20, buttonX + 45, btnY + 60, buttonX + 75, btnY + 40);

  // Progress Bar
  float barY = 620;
  float barWidth = 500;
  fill(220);
  rect(centerX - 250, barY, barWidth, 25);

  if (player.isPlaying()) {
    float progress = map(player.position(), 0, player.length(), 0, barWidth);
    fill(0, 0, 139);
    rect(centerX - 250, barY, progress, 25);
  }

  // Time Display
  int currentMillis = player.position();
  int totalMillis = player.length();
  String currentTime = nf(currentMillis / 60000, 2) + ":" + nf((currentMillis / 1000) % 60, 2);
  String totalTime = nf(totalMillis / 60000, 2) + ":" + nf((totalMillis / 1000) % 60, 2);

  fill(0);
  textSize(20);
  text(currentTime + " / " + totalTime, centerX, barY + 35);

  // Quit Button
  fill(200);
  rect(width - 70, 20, 40, 40);
  fill(255, 0, 0);
  textSize(24);
  text("X", width - 50, 40);
}

void mousePressed() {
  float centerX = width / 2;

  // Fast Backward
  if (mouseX > centerX - 220 && mouseX < centerX - 140 && mouseY > 500 && mouseY < 580) {
    int newPos = player.position() - 5000;
    if (newPos < 0) newPos = 0;
    player.cue(newPos);
  }

  // Play/Pause
  if (mouseX > centerX - 140 && mouseX < centerX - 60 && mouseY > 500 && mouseY < 580) {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play();
      isPlaying = true;
    }
  }

  // Stop
  if (mouseX > centerX - 60 && mouseX < centerX + 20 && mouseY > 500 && mouseY < 580) {
    player.pause();
    player.rewind();
    isPlaying = false;
  }

  // Fast Forward
  if (mouseX > centerX + 20 && mouseX < centerX + 100 && mouseY > 500 && mouseY < 580) {
    int newPos = player.position() + 5000;
    if (newPos > player.length()) newPos = player.length();
    player.cue(newPos);
  }

  // Quit
  if (mouseX > width - 70 && mouseX < width - 30 && mouseY > 20 && mouseY < 60) {
    exit();
  }
}
