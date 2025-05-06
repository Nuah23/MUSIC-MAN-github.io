import ddf.minim.*;

Minim minim;
AudioPlayer player;
PImage album;

boolean isPlaying = false;
boolean isMuted = false;
float savedGain = 0.0;

String[] songs = {"assets/audio/PlayboyN.mp3"};
String[] albums = {""};
int currentSong = 0;

void setup() {
  fullScreen();
  minim = new Minim(this);
  loadSong(currentSong);

  textAlign(CENTER, CENTER);
  textFont(createFont("MV Boli", 60));
  fill(0, 0, 139);
}

void draw() {
  background(255);
  float centerX = width / 2;

  // Border
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(50, 50, width - 100, height - 100);

  // Title Bar
  fill(200);
  rect(centerX - 300, 50, 600, 100);
  fill(0, 0, 139);
  text("Alleyway Monastries", centerX, 100);

  // Album Image
  image(album, centerX - 250, 180);

  // Control Buttons
  float btnY = 550;
  float btnSize = 100;
  float totalButtonWidth = btnSize * 7;
  float buttonX = centerX - totalButtonWidth / 2;

  // Fast Backward
  drawButton(buttonX, btnY, btnSize, "⏪");
  buttonX += btnSize;

  // Play/Pause
  drawButton(buttonX, btnY, btnSize, isPlaying ? "⏸" : "▶");
  buttonX += btnSize;

  // Stop
  drawButton(buttonX, btnY, btnSize, "⏹");
  buttonX += btnSize;

  // Fast Forward
  drawButton(buttonX, btnY, btnSize, "⏩");
  buttonX += btnSize;

  // Next
  drawButton(buttonX, btnY, btnSize, "⏭");
  buttonX += btnSize;

  // Previous
  drawButton(buttonX, btnY, btnSize, "⏮");
  buttonX += btnSize;

  // Mute/Unmute
  drawButton(buttonX, btnY, btnSize, isMuted ? "🔇" : "🔊");

  // Progress Bar
  float barY = 700;
  float barWidth = 100 * 15;
  fill(220);
  rect(centerX - barWidth / 2, barY, barWidth, 30);

  if (player.isPlaying()) {
    float progress = map(player.position(), 0, player.length(), 0, barWidth);
    fill(0, 0, 139);
    rect(centerX - barWidth / 2, barY, progress, 30);
  }

  // Time Display
  int currentMillis = player.position();
  int totalMillis = player.length();
  String currentTime = nf(currentMillis / 60000, 2) + ":" + nf((currentMillis / 1000) % 60, 2);
  String totalTime = nf(totalMillis / 60000, 2) + ":" + nf((totalMillis / 1000) % 60, 2);
  fill(0);
  textSize(24);
  text(currentTime + " / " + totalTime, centerX, barY + 40);

  // Quit Button
  fill(200);
  rect(width - 90, 30, 50, 50);
  fill(255, 0, 0);
  textSize(30);
  text("X", width - 60, 55);
}

void drawButton(float x, float y, float size, String label) {
  fill(180);
  rect(x, y, size, size);
  fill(0);
  textSize(40);
  text(label, x + size / 2, y + size / 2);
}

void mousePressed() {
  float centerX = width / 2;
  float btnY = 550;
  float btnSize = 100;
  float totalButtonWidth = btnSize * 7;
  float buttonX = centerX - totalButtonWidth / 2;

  // Fast Backward
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    int newPos = player.position() - 5000;
    player.cue(max(newPos, 0));
    return;
  }
  buttonX += btnSize;

  // Play/Pause
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play();
      isPlaying = true;
    }
    return;
  }
  buttonX += btnSize;

  // Stop
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    player.pause();
    player.rewind();
    isPlaying = false;
    return;
  }
  buttonX += btnSize;

  // Fast Forward
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    int newPos = player.position() + 5000;
    player.cue(min(newPos, player.length()));
    return;
  }
  buttonX += btnSize;

  // Next
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    currentSong = (currentSong + 1) % songs.length;
    loadSong(currentSong);
    return;
  }
  buttonX += btnSize;

  // Previous
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    currentSong = (currentSong - 1 + songs.length) % songs.length;
    loadSong(currentSong);
    return;
  }
  buttonX += btnSize;

  // Mute/Unmute
  if (isMouseOver(buttonX, btnY, btnSize, btnSize)) {
    if (isMuted) {
      player.setGain(savedGain);
      isMuted = false;
    } else {
      savedGain = player.getGain();
      player.setGain(-80);
      isMuted = true;
    }
    return;
  }

  // Quit
  if (isMouseOver(width - 90, 30, 50, 50)) {
    exit();
  }
}

boolean isMouseOver(float x, float y, float w, float h) {
  return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
}

void loadSong(int index) {
  if (player != null) {
    player.close();
  }
  player = minim.loadFile(songs[index]);
  album = loadImage(albums[index]);
  if (album == null) {
    println("Warning: Image file not found.");
    album = createImage(500, 300, RGB);
    album.loadPixels();
    for (int i = 0; i < album.pixels.length; i++) {
      album.pixels[i] = color(200); // Light gray placeholder
