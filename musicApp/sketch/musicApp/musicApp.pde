import ddf.minim.*;

Minim minim;
AudioPlayer player;
PImage album;

boolean isPlaying = false;
boolean isMuted = false;
float savedGain = 0;

String[] songs = {"musicApp/sketch/assets/audio/PlayboyN.mp3"};
String[] albums = {"assets/images/ME-JU.jpg", "assets/images/1316.jpg"};
int currentSong = 0;

void setup() {
  fullScreen();
  minim = new Minim(this);
  textAlign(CENTER, CENTER);
  textFont(createFont("MV Boli", 60));
  fill(0, 0, 139);
  loadSong(currentSong);
}

void draw() {
  background(255);
  float centerX = width / 2;

  noFill();
  stroke(0);
  strokeWeight(5);
  rect(50, 50, width - 100, height - 100);

  fill(200);
  rect(centerX - 300, 50, 600, 100);
  fill(0, 0, 139);
  text("YEET Music - Merhawi Haile", centerX, 100);

  if (album != null) image(album, centerX - 250, 180);

  drawButtons(centerX);

  drawProgressBar(centerX);

  if (!player.isPlaying() && isPlaying) {
    currentSong = (currentSong + 1) % songs.length;
    loadSong(currentSong);
    player.play();
  }

  drawQuitButton();
}

void drawButtons(float centerX) {
  float btnY = 550;
  float btnSize = 100;
  float totalWidth = btnSize * 7;
  float x = centerX - totalWidth / 2;

  String[] labels = {"⏪", isPlaying ? "⏸" : "▶", "⏹", "⏩", "⏭", "⏮", isMuted ? "🔇" : "🔊"};
  for (int i = 0; i < labels.length; i++) {
    if (mouseX > x && mouseX < x + btnSize && mouseY > btnY && mouseY < btnY + btnSize) {
      fill(160); // Hover effect
    } else {
      fill(180);
    }
    rect(x, btnY, btnSize, btnSize);
    fill(0);
    textSize(40);
    text(labels[i], x + btnSize / 2, btnY + btnSize / 2);
    x += btnSize;
  }
}

void drawProgressBar(float centerX) {
  float barY = 700;
  float barWidth = 1500;
  fill(220);
  rect(centerX - barWidth / 2, barY, barWidth, 30);

  if (player.isPlaying()) {
    float progress = map(player.position(), 0, player.length(), 0, barWidth);
    fill(0, 0, 139);
    rect(centerX - barWidth / 2, barY, progress, 30);
  }

  int currentMillis = player.position();
  int totalMillis = player.length();
  String currentTime = nf(currentMillis / 60000, 2) + ":" + nf((currentMillis / 1000) % 60, 2);
  String totalTime = nf(totalMillis / 60000, 2) + ":" + nf((totalMillis / 1000) % 60, 2);
  fill(0);
  textSize(24);
  text(currentTime + " / " + totalTime, centerX, barY + 40);
}

void drawQuitButton() {
  fill(200);
  rect(width - 90, 30, 50, 50);
  fill(255, 0, 0);
  textSize(30);
  text("X", width - 60, 55);
}

void mousePressed() {
  float centerX = width / 2;
  float btnY = 550;
  float btnSize = 100;
  float x = centerX - btnSize * 3.5;

  if (isMouseOver(x, btnY, btnSize)) {
    player.cue(max(player.position() - 5000, 0));
  } else if (isMouseOver(x += btnSize, btnY, btnSize)) {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play();
      isPlaying = true;
    }
  } else if (isMouseOver(x += btnSize, btnY, btnSize)) {
    player.pause();
    player.rewind();
    isPlaying = false;
  } else if (isMouseOver(x += btnSize, btnY, btnSize)) {
    player.cue(min(player.position() + 5000, player.length()));
  } else if (isMouseOver(x += btnSize, btnY, btnSize)) {
    currentSong = (currentSong + 1) % songs.length;
    loadSong(currentSong);
    player.play();
    isPlaying = true;
  } else if (isMouseOver(x += btnSize, btnY, btnSize)) {
    currentSong = (currentSong - 1 + songs.length) % songs.length;
    loadSong(currentSong);
    player.play();
    isPlaying = true;
  } else if (isMouseOver(x += btnSize, btnY, btnSize)) {
    if (isMuted) {
      player.setGain(savedGain);
      isMuted = false;
    } else {
      savedGain = player.getGain();
      player.setGain(-80); // Mute
      isMuted = true;
    }
  } else if (mouseX > width - 90 && mouseX < width - 40 && mouseY > 30 && mouseY < 80) {
    exit();
  }
}

boolean isMouseOver(float x, float y, float w) {
  return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + w;
}

void loadSong(int index) {
  if (player != null) {
    player.close();
  }
  player = minim.loadFile(songs[index]);
  if (player == null) {
    println("Error loading audio: " + songs[index]);
    return;
  }
  album = loadImage(albums[index]);
  if (album == null) {
    println("Image not found: " + albums[index]);
    album = createImage(500, 300, RGB);
    album.loadPixels();
    for (int i = 0; i < album.pixels.length; i++) {
      album.pixels[i] = color(200);
    }
    album.updatePixels();
  }
  album.resize(500, 300);
  isPlaying = false;
} 
